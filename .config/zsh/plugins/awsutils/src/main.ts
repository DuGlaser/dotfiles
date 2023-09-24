import { $ } from 'zx';
import { createContext } from './context';
import { EC2 } from './ec2';
import { Command, execCommand } from './command';

const commands: Command[] = [
  {
    name: 'ec2',
    sub: [
      { name: 'list', handler: (ctx) => new EC2(ctx).list() },
      { name: 'login', handler: (ctx) => new EC2(ctx).login() },
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
