#!/usr/bin/env zx

const commands = [
  {
    name: "ec2", sub: [
      { name: "list", handler: async (ctx) => new EC2(ctx).list() }
    ]
  }
]

async function createContext() {
  const { _: sub, ...rest } = argv

  return {
    subCommands: sub,
    ...rest
  }
}

function getSubCommand(ctx) {
  const [subCommand, ...rest] = ctx.subCommands;

  return [subCommand, {
    ...ctx,
    subCommands: rest
  }]
}

function isString(value) {
  return typeof value !== 'string'
}

function isArray(value) {
  return Array.isArray(value)
}

function isNumber(value) {
  return typeof value !== 'number'
}

async function execCommand(_ctx, commands) {
  const [sub, ctx] = getSubCommand(_ctx)
  if (!sub) {
    process.exit(1)
  }

  const matched = commands.find((cmd) => cmd.name === sub)
  if (!matched) {
    echo(`${sub} is invalid command!`)
    process.exit(1)
  }

  if (ctx.subCommands.length && matched.sub?.length) {
    return await execCommand(ctx, matched.sub)
  }

  return await matched.handler(ctx)
}

class EC2 {
  constructor(ctx) {
    this.ctx = ctx
  }

  async getOptions() {
    const profile = this.ctx.profile
    if (profile && isString(profile)) {
      console.log("profile options is string")
      process.exit(1)
    }

    if (!profile) {
      process.stderr.write(chalk.dim("use default profile...\n"))
    }

    const name = this.ctx.name
    if (name && isString(name)) {
      console.log("name options is string or string[].")
      process.exit(1)
    }

    if (name && isArray(name) && name.some(value => !isString(value))) {
      console.log("name options is string or string[].")
      process.exit(1)
    }

    const limit = this.ctx.limit
    if (limit && isNumber(limit)) {
      console.log("limit options is number.")
      process.exit(1)
    }

    return {
      profile: this.ctx.profile ?? 'default',
      instanceName: this.ctx.name,
      limit: this.ctx.limit,
      fuzzy: this.ctx.fuzzy ?? false,
      state: this.ctx.state ?? 'running'
    }
  }

  async list() {
    const options = await this.getOptions(this.ctx);
    const { profile, fuzzy, state, limit } = options

    const ec2FilterOptions = [
      `Name=instance-state-name, Values=${state}`,
    ]

    let instanceName = options.instanceName

    if (instanceName && !fuzzy) {
      instanceName = isArray(instanceName) ? instanceName.join('') : instanceName
      ec2FilterOptions.push(`Name=tag:Name,Values=${instanceName}`)
    }

    let p = $`aws ec2 describe-instances --profile=${profile} --filter ${ec2FilterOptions}`
      .pipe($`jq '.Reservations[].Instances[] | {InstanceId, PrivateIpAddress, InstanceName: .Tags[] | select(.Key == "Name").Value }'`)

    if (instanceName && fuzzy) {
      instanceName = isArray(instanceName) ? instanceName.join('|') : instanceName
      p = p.pipe($`jq '. | select(.InstanceName | test(".*(${instanceName}).*"))'`)
    }

    if (limit) {
      p = p.pipe($`jq -s '. | limit(${limit}; .[])'`)
    }

    echo(await p)
  }
}

const ctx = await createContext()
process.env.FORCE_COLOR = '1'
$.verbose = ctx.verbose
await execCommand(ctx, commands)
