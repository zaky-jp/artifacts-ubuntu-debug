# env
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all

# variables
IMAGE_TAG = rolling

# actions
.PHONY: all
all: clean build
.PHONY: build
build: src/Dockerfile
	docker build -f src/Dockerfile -t ubuntu-base:$(IMAGE_TAG) .
.PHONY: clean
clean:
	docker rmi ubuntu-base:$(IMAGE_TAG) || true
