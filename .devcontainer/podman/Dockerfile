# syntax=docker/dockerfile:1
#FROM ubuntu:rolling
FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04
# setup apt
ARG APT_MIRROR_PRIORITY1
ARG APT_MIRROR_PRIORITY2
COPY src/apt-config.sh /usr/local/bin/
RUN bash /usr/local/bin/apt-config.sh

# install buildah
ENV DEBIAN_FRONTEND=noninteractive
RUN \
	--mount=type=cache,target=/var/lib/apt/lists \
	--mount=type=cache,target=/var/cache/apt/archives \
	apt-get update \
	&& apt-get install buildah

USER vscode
ENTRYPOINT [ "/usr/bin/zsh" ]
