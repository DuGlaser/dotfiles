import { $ } from "npm:zx@7.1.1";
import { Context, createContext } from "./context.ts";
import { EC2 } from "./ec2.ts";
import { Command, execCommand } from "./command.ts";

const commands: Command[] = [
  {
    name: "ec2",
    sub: [
      { name: "list", handler: (ctx) => new EC2(ctx).list() },
      { name: "login", handler: (ctx) => new EC2(ctx).login() },
    ],
  },
];

// entry point
async function main() {
  const ctx = createContext();
  $.verbose = ctx.verbose;
  await execCommand(ctx, commands);
}

await main();
