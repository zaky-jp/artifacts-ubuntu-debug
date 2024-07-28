# syntax=docker/dockerfile:1
# use prebuild image as binary source
FROM hadolint/hadolint:v2.12.0 AS source

FROM ubuntu:rolling
SHELL ["/bin/bash", "-c"]
# copy hadolint
COPY --from=source /bin/hadolint /usr/local/bin
# setup apt
ARG APT_MIRROR_PRIORITY1
ARG APT_MIRROR_PRIORITY2
COPY src/apt-config.sh /usr/local/bin/
RUN bash /usr/local/bin/apt-config.sh

# install dev packages
COPY src/essential_packages.txt /etc/apt/essential_packages.txt
ENV DEBIAN_FRONTEND=noninteractive
RUN \
	--mount=type=cache,target=/var/lib/apt/lists \
	--mount=type=cache,target=/var/cache/apt/archives \
	apt-get update \
	&& xargs -a /etc/apt/essential_packages.txt apt-get install \
	&& apt-get install make git nodejs npm shellcheck
