# syntax=docker/dockerfile:1
FROM ubuntu:rolling
SHELL ["/bin/bash", "-c"]

# setup apt
ARG APT_MIRROR_PRIORITY1
ARG APT_MIRROR_PRIORITY2
COPY src/apt-config.sh /usr/local/bin/
RUN /usr/local/bin/apt-config.sh

# install essential packages
COPY src/essential_packages.txt /etc/apt/essential_packages.txt
ENV DEBIAN_FRONTEND=noninteractive
RUN \
	--mount=type=cache,target=/var/lib/apt/lists \
	--mount=type=cache,target=/var/cache/apt/archives \
	apt-get update \
	&& xargs -a /etc/apt/essential_packages.txt apt-get install
USER ubuntu
ENTRYPOINT [ "/bin/bash" ]
