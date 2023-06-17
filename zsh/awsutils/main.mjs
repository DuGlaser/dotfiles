#!/usr/bin/env zx

/**
 * commands
 **/
const commands = [
  {
    name: 'ec2',
    sub: [
      { name: 'list', handler: async (ctx) => new EC2(ctx).list() },
      { name: 'login', handler: async (ctx) => new EC2(ctx).login() },
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
  return typeof value === 'string';
}

function isArray(value, validator) {
  const isArray = Array.isArray(value);
  if (isArray && validator) {
    return value.every((v) => validator(v));
  }

  return isArray;
}

function isNumber(value) {
  return typeof value === 'number';
}

/**
 * EC2 utils
 **/
function getProfile(ctx) {
  const profile = ctx.profile;
  if (profile && !isString(profile)) {
    log('profile options is string');
    process.exit(1);
  }

  if (!profile) {
    log(chalk.dim('use default profile...'));
  }

  return profile ?? 'default';
}

function getEC2ListOption(ctx) {
  const profile = getProfile(ctx);

  const names = ctx.names;
  if (names && !(isString(names) || isArray(names, isString))) {
    log('name options is string or string[].');
    process.exit(1);
  }

  const nameList = !names
    ? []
    : typeof names === 'string'
    ? names.split(',')
    : names;

  const limit = ctx.limit;
  if (limit && !isNumber(limit)) {
    log('limit options is number.');
    process.exit(1);
  }

  return {
    profile,
    limit,
    names: nameList,
    fuzzy: ctx.fuzzy ?? false,
    state: ctx.state ?? 'running',
  };
}

function getEC2LoginOption(ctx) {
  const [target] = getSubCommand(ctx);
  if (!target) {
    log('target is required. target is the ARN of the EC2 instance.');
    log(chalk.dim('$ awsutils ec2 ssm <target>'));
    process.exit(1);
  }

  return {
    profile: getProfile(ctx),
    region: ctx.region,
    target,
  };
}

class EC2 {
  constructor(ctx) {
    this.ctx = ctx;
  }

  async limit(process, limit) {
    return process.pipe($`jq -s '. | limit(${limit}; .[])'`);
  }

  async login() {
    const options = getEC2LoginOption(this.ctx);
    const { profile, target, region } = options;

    const ssmOptions = [
      ['--target', target],
      profile && ['--profile', profile],
      region && ['--region', region],
    ]
      .flat()
      .filter((value) => !!value);

    const p = $`aws ssm start-session ${ssmOptions}`;
    process.on('SIGINT', () => {});
    p.stdio('inherit', 'inherit', 'inherit');
  }

  async list() {
    const options = getEC2ListOption(this.ctx);
    const { profile, fuzzy, state, limit, names: instanceNames } = options;

    const ec2FilterOptions = [`Name=instance-state-name,Values=${state}`];

    if (instanceNames.length && !fuzzy) {
      ec2FilterOptions.push(`Name=tag:Name,Values=${instanceNames.join('')}`);
    }

    let p = $`aws ec2 describe-instances --profile ${profile} --filter ${ec2FilterOptions}`;
    p = p.pipe(
      $`jq '.Reservations[].Instances[] | {InstanceId, PrivateIpAddress, InstanceName: .Tags[] | select(.Key == "Name").Value }'`
    );

    if (instanceNames.length && fuzzy) {
      const joined = instanceNames.join('|');
      const searchValue = `. | select(.InstanceName | test(".*(${joined}).*"))`;
      p = p.pipe($`jq ${searchValue}`);
    }

    if (limit) {
      p = this.limit(p, limit);
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
