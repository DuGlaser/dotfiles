export function log(message: string, re = true) {
  Deno.stderr.writeSync(
    new TextEncoder().encode(`${message}${re ? "\n" : ""}`),
  );
}
