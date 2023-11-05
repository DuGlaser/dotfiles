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

.PHONY: login/test-ubuntu
login/test-ubuntu:
	awsutils ec2 login \
		$(shell awsutils ec2 list --names "test-ubuntu" --fuzzy --limit 1 | jq ".InstanceId" -r)
