TAG ?= latest
REGISTRY_ID ?= 366915744137
REPOSITORY_REGION ?= eu-central-1
APP_NAME ?= app
ENV_NAME ?= project
NAME_CONTAINER ?= catsapp
REPO_NAME = $(REGISTRY_ID).dkr.ecr.$(REPOSITORY_REGION).amazonaws.com/${APP_NAME}-${ENV_NAME}-${NAME_CONTAINER}

.PHONY: build
build:
	$(MAKE) docker-login
	docker build -t $(REPO_NAME):$(TAG) .
	docker push $(REPO_NAME):$(TAG)

.PHONY: docker-login
docker-login:
	aws ecr get-login-password --region $(REPOSITORY_REGION) | docker login --username AWS --password-stdin $(REGISTRY_ID).dkr.ecr.$(REPOSITORY_REGION).amazonaws.com
