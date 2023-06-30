import { $ } from "npm:zx@7.1.1";
import { Context, createContext, getSubCommand } from "./context.ts";
import { EC2 } from "./ec2.ts";

type Command = {
  name: string;
  handler?: (context: Context) => Promise<unknown>;
  sub?: Command[];
};

const commands: Command[] = [
  {
    name: "ec2",
    sub: [
      { name: "list", handler: (ctx) => new EC2(ctx).list() },
      { name: "login", handler: (ctx) => new EC2(ctx).login() },
    ],
  },
];

async function execCommand(
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

function log(message: string, re = true) {
  $.log({ kind: "stderr", data: `${message}${re ? "\n" : ""}`, verbose: true });
}

// entry point
async function main() {
  const ctx = createContext();
  $.verbose = ctx.verbose;
  await execCommand(ctx, commands);
}

await main();
