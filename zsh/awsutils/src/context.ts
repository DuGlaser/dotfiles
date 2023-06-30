import { argv } from "npm:zx@7.1.1";

export type Context = {
  commands: string[];
  verbose: boolean;
  options: Record<string, unknown>;
};

export function createContext(): Context {
  const { _: commands, verbose, ...rest } = argv;

  return {
    commands,
    verbose: verbose ?? false,
    options: rest,
  };
}

export function getSubCommand(ctx: Context): [string | undefined, Context] {
  const [subCommand, ...rest] = ctx.commands;

  return [
    subCommand,
    {
      ...ctx,
      commands: rest,
    },
  ];
}
