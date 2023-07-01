import { $ } from "npm:zx@7.1.1";

export function log(message: string, re = true) {
  $.log({ kind: "stderr", data: `${message}${re ? "\n" : ""}`, verbose: true });
}
