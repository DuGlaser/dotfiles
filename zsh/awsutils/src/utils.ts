export function log(message: string, re = true) {
  process.stderr.write(new TextEncoder().encode(`${message}${re ? '\n' : ''}`));
}
