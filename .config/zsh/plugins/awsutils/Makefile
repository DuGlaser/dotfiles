.PHONY: init
init:
	bun install --frozen-lockfile

.PHONY: fmt
fmt:
	bunx prettier --write ./src

define MJS_SNIPPET
#!/usr/bin/env node
import { createRequire } from 'node:module'
var require = createRequire(import.meta.url);
endef
export MJS_SNIPPET

OUTPUT_FILE := dist/main.mjs
OUTPUT_DIR := $(dir ${OUTPUT_FILE})
SOURCE_FILE := src/main.ts

.PHONY: build
build:
	mkdir -p ${OUTPUT_DIR}
	echo "$${MJS_SNIPPET}" > ${OUTPUT_FILE}
	bunx esbuild ${SOURCE_FILE} --bundle --platform=node --format=esm >> ${OUTPUT_FILE}
	chmod +x ${OUTPUT_FILE}

.PHONY: clean
clean:
	rm -rf ${OUTPUT_DIR}

.PHONY: link
link: 
	ln -sf ${PWD}/${OUTPUT_FILE} ~/.local/bin/awsutils
