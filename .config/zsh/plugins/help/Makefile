.PHONY: init
init: src/env.ts
	bun install --frozen-lockfile

src/env.ts:
	echo 'export const API_KEY = "${API_KEY}"' > $@

.PHONY: fmt
fmt:
	bunx prettier --write ./src

define MJS_SNIPPET
#!/usr/bin/env node
import { createRequire } from 'node:module'
var require = createRequire(import.meta.url);
endef
export MJS_SNIPPET

TARGET_DIR := dist
TARGET_FILE := dist/main.mjs
SOURCE_FILE := src/main.ts

.PHONY: build
build:
	mkdir -p ${TARGET_DIR}
	echo "$${MJS_SNIPPET}" > ${TARGET_FILE}
	bunx esbuild ${SOURCE_FILE} --bundle --platform=node --format=esm >> ${TARGET_FILE}
	chmod +x ${TARGET_FILE}

.PHONY: clean
clean:
	rm -rf ${TARGET_DIR}

.PHONY: link
link: 
	npm link
