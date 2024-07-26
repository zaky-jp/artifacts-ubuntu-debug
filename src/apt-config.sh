#!/usr/bin/env bash
set -eu

# @define variables
export APT_DOCKER_CONF="/etc/apt/apt.conf.d/docker-clean"
export APT_CONTAINER_CONF="/etc/apt/apt.conf.d/90container"
if [[ $(uname -i) == "x86_64" ]]; then
	export APT_MIRROR_PRIORITY1="${APT_MIRROR_PRIORITY1:-http://ftp.udx.icscoe.jp/Linux/ubuntu/}"
	export APT_MIRROR_PRIORITY2="${APT_MIRROR_PRIORITY2:-http://linux.yz.yamagata-u.ac.jp/ubuntu/}"
else
	# use ports
	export APT_MIRROR_PRIORITY1="${APT_MIRROR_PRIORITY1:-http://repo.jing.rocks/ubuntu-ports/}"
	export APT_MIRROR_PRIORITY2="${APT_MIRROR_PRIORITY2:-http://ftp.kaist.ac.kr/ubuntu-ports/}"
fi
export APT_MIRROR_FILE="/etc/apt/mirrors.txt"
export APT_SOURCE_FILE="/etc/apt/sources.list.d/ubuntu.sources"

# @run
if [[ -e ${APT_DOCKER_CONF} ]]; then
  rm "${APT_DOCKER_CONF}"
fi

cat <<-EOS | tee "${APT_CONTAINER_CONF}" >/dev/null
	APT::Get::Assume-Yes "1";
	APT::Install-Recommends "0";
EOS

cat <<-EOS | tee "${APT_MIRROR_FILE}" >/dev/null
	${APT_MIRROR_PRIORITY1}	priority:1
	${APT_MIRROR_PRIORITY2}	priority:2
EOS

if [[ $(source /etc/os-release; echo "$VERSION_CODENAME") == "noble" ]]; then
	perl -0pi -e 's!(URIs:) \S+\n(?\!Suites: \S+security\n)!$1 mirror+file:$ENV{APT_MIRROR_FILE}\n!sg' "${APT_SOURCE_FILE}"
else
	perl -pi -e 's!^(deb) \S+ (?\!\S+security)!$1 mirror+file:$ENV{APT_MIRROR_FILE}!m'
fi
