import { z } from 'zod';
import { $, echo, ProcessPromise } from 'zx';
import { Context } from './context';

const Profile = z.string().optional().default('default');

const EC2ListOption = z.object({
  profile: Profile,
  limit: z.number().optional(),
  names: z
    .union([z.string(), z.array(z.string())])
    .transform((value) => {
      if (typeof value === 'string') return [value];
      return value;
    })
    .default([]),
  fuzzy: z.boolean().optional().default(false),
  state: z.string().optional().default('running'),
});

const EC2LoginOption = z.object({
  profile: Profile,
  target: z.string(),
  region: z.string().optional(),
});

export class EC2 {
  ctx: Context;

  constructor(ctx: Context) {
    this.ctx = ctx;
  }

  async login() {
    const options = EC2LoginOption.parse({
      ...this.ctx.options,
      target: this.ctx.commands[0],
    });
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
    await p.stdio('inherit', 'inherit', 'inherit');
  }

  async list() {
    const { profile, fuzzy, state, limit, names } = EC2ListOption.parse(
      this.ctx.options,
    );

    const ec2FilterOptions = [`Name=instance-state-name,Values=${state}`];

    if (names.length && !fuzzy) {
      ec2FilterOptions.push(`Name=tag:Name,Values=${names.join('')}`);
    }

    let p = $`aws ec2 describe-instances --profile ${profile} --filter ${ec2FilterOptions}`;
    p = p.pipe(
      $`jq '.Reservations[].Instances[] | {InstanceId, PrivateIpAddress, InstanceName: .Tags[] | select(.Key == "Name").Value }'`,
    );

    if (names.length && fuzzy) {
      p = this.fuzzySearch(p, names);
    }

    if (limit) {
      p = this.limit(p, limit);
    }

    echo(await p);
  }

  private limit(process: ProcessPromise, limit: number): ProcessPromise {
    return process.pipe($`jq -s '. | limit(${limit}; .[])'`);
  }

  private fuzzySearch(
    process: ProcessPromise,
    keywords: string[],
  ): ProcessPromise {
    const joined = keywords.join('|');
    const searchValue = `. | select(.InstanceName | test(".*(${joined}).*"))`;
    return process.pipe($`jq ${searchValue}`);
  }
}
