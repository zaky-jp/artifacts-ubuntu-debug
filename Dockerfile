# syntax=docker/dockerfile:1

FROM ubuntu:22.04

# remove auto-clean to enable caching
RUN rm /etc/apt/apt.conf.d/docker-clean

# add fast mirrors + conf for always-yes apt
ADD mirrors.txt sources.list apt.conf /etc/apt/

# install useful tools
RUN \
  --mount=type=cache,target=/var/lib/apt/lists \
  --mount=type=cache,target=/var/cache/apt/archives \
  DEBIAN_FRONTEND=noninteractive apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y dialog apt-utils \
  && echo 'y' | unminimize \
  && apt-get install -y \
    man-db \
    curl \
    xz-utils \
    iproute2 \
    iputils-ping \
    dnsutils \
    neovim \
    less

ENTRYPOINT ["/bin/bash"]
CMD ["--login"]
