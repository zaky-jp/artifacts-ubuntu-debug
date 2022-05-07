#!/bin/bash

set -eu

# build base image first
docker build --file ./recipe/22.04-base --tag ubuntu:22.04-base .

# then build debug image
docker build --file ./recipe/22.04-debug --tag ubuntu:22.04-debug .
