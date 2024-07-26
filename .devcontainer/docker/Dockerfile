# syntax=docker/dockerfile:1
FROM hadolint/hadolint:v2.12.0 AS source

FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04
COPY --from=source /bin/hadolint /usr/local/bin
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
	&& apt-get install shellcheck

USER vscode
ENTRYPOINT [ "/usr/bin/zsh" ]
