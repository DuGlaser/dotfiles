import { Context } from "./context.ts";
import { log } from "./utils.ts";

export type Command = {
  name: string;
  handler?: (context: Context) => Promise<unknown>;
  sub?: Command[];
};

export async function execCommand(
  _ctx: Context,
  commands: Command[],
): Promise<unknown> {
  const [sub, ctx] = getSubCommand(_ctx);
  if (!sub) {
    log(`cannot find command handler!`);
    Deno.exit(1);
  }

  const matched = commands.find((cmd) => cmd.name === sub);
  if (!matched) {
    log(`${sub} is invalid command!`);
    Deno.exit(1);
  }

  if (ctx.commands.length && matched.sub?.length) {
    return await execCommand(ctx, matched.sub);
  }

  if (!matched.handler) {
    log(`${sub} is invalid command!`);
    Deno.exit(1);
  }

  return await matched.handler(ctx);
}

function getSubCommand(ctx: Context): [string | undefined, Context] {
  const [subCommand, ...rest] = ctx.commands;

  return [
    subCommand,
    {
      ...ctx,
      commands: rest,
    },
  ];
}
