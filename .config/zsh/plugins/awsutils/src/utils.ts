export function log(message: string) {
  process.stderr.write(new TextEncoder().encode(message));
}
