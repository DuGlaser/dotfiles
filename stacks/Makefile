SHELL = /bin/zsh
ACCOUNT := $(shell aws sts get-caller-identity --query "Account" --output text)

.PHONY: diff
diff:
	cdk diff -c account=${ACCOUNT}

.PHONY: deploy
deploy:
	cdk deploy -c account=${ACCOUNT}

.PHONY: destroy
destroy:
	cdk destroy -c account=${ACCOUNT}
