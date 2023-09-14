import { argv } from 'zx';

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
