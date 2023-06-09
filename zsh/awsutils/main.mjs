#!/usr/bin/env zx

/**
 * commands
 **/
const commands = [
  {
    name: 'ec2',
    sub: [
      { name: 'list', handler: async (ctx) => new EC2(ctx).list() },
      { name: 'ssm', handler: async (ctx) => new EC2(ctx).ssm() },
    ],
  },
];

async function execCommand(_ctx, commands) {
  const [sub, ctx] = getSubCommand(_ctx);
  if (!sub) {
    log(`cannot find command handler!`);
    process.exit(1);
  }

  const matched = commands.find((cmd) => cmd.name === sub);
  if (!matched) {
    log(`${sub} is invalid command!`);
    process.exit(1);
  }

  if (ctx.subCommands.length && matched.sub?.length) {
    return await execCommand(ctx, matched.sub);
  }

  return await matched.handler(ctx);
}

/**
 * logger
 **/
function log(message, re = true) {
  $.log({ kind: 'stderr', data: `${message}${re ? '\n' : ''}`, verbose: true });
}

/**
 * context utils
 **/
async function createContext() {
  const { _: sub, ...rest } = argv;

  return {
    subCommands: sub,
    ...rest,
  };
}

function getSubCommand(ctx) {
  const [subCommand, ...rest] = ctx.subCommands;

  return [
    subCommand,
    {
      ...ctx,
      subCommands: rest,
    },
  ];
}

/**
 * type check utils
 **/
function isString(value) {
  return typeof value !== 'string';
}

function isArray(value) {
  return Array.isArray(value);
}

function isNumber(value) {
  return typeof value !== 'number';
}

/**
 * EC2 utils
 **/
function getEC2ListOption(ctx) {
  const profile = ctx.profile;
  if (profile && isString(profile)) {
    log('profile options is string');
    process.exit(1);
  }

  if (!profile) {
    log(chalk.dim('use default profile...'));
  }

  const names = ctx.names;
  if (names && isString(names)) {
    log('name options is string or string[].');
    process.exit(1);
  }

  if (names && isArray(names) && names.some((value) => !isString(value))) {
    log('name options is string or string[].');
    process.exit(1);
  }

  const nameList = !names
    ? []
    : typeof names === 'string'
    ? names.split(',')
    : names;

  const limit = ctx.limit;
  if (limit && isNumber(limit)) {
    log('limit options is number.');
    process.exit(1);
  }

  return {
    profile: ctx.profile ?? 'default',
    names: nameList,
    limit: ctx.limit,
    fuzzy: ctx.fuzzy ?? false,
    state: ctx.state ?? 'running',
  };
}

class EC2 {
  constructor(ctx) {
    this.ctx = ctx;
  }

  async limit(process, limit) {
    return process.pipe($`jq - s '. | limit(${limit}; .[])'`);
  }

  async ssm() {
    log('coming soon...');
  }

  async list() {
    const options = getEC2ListOption(this.ctx);
    const { profile, fuzzy, state, limit, names: instanceNames } = options;

    const ec2FilterOptions = [
      `Name = instance - state - name, Values = ${state}`,
    ];

    if (instanceNames.length && !fuzzy) {
      ec2FilterOptions.push(
        `Name = tag: Name, Values = ${instanceNames.join('')}`
      );
    }

    let p = $`aws ec2 describe - instances--profile = ${profile} --filter ${ec2FilterOptions}`;
    p = p.pipe(
      $`jq '.Reservations[].Instances[] | {InstanceId, PrivateIpAddress, InstanceName: .Tags[] | select(.Key == "Name").Value }'`
    );

    if (instanceNames.length && fuzzy) {
      const joined = instanceNames.join('|');
      const searchValue = `. | select(.InstanceName | test(".*(${joined}).*"))`;
      p = p.pipe($`jq ${searchValue}`);
    }

    if (limit) {
      p = this.limit(limit);
    }

    echo(await p);
  }
}

/**
 * main
 **/
async function main() {
  const ctx = await createContext();
  process.env.FORCE_COLOR = '1';
  $.verbose = ctx.verbose;
  await execCommand(ctx, commands);
}

await main();
