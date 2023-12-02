YAML_FILE := eucalyn.yaml
JSON_FILE := eucalyn.json

build:
	docker run --rm -v "${PWD}":/workdir mikefarah/yq  e -P --output-format=json ${YAML_FILE} > ${JSON_FILE}
