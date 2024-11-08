#!/bin/bash

arch="amd64 i386 arm64v8 arm32v7 arm32v5"
arch="arm64v8"

platforms="ubuntu:xenial ubuntu:bionic ubuntu:focal ubuntu:jammy ubuntu:noble debian:stretch debian:buster debian:bullseye debian:bookworm debian:trixie"
platforms="ubuntu:jammy"
# Currently build script does not support i386/ubuntu:focal because of missing libmariadbclient-dev

email="tosiara@users.noreply.github.com"
LOCAL="$PWD"
v="4.7"

# otherwise you will get exec format error
apt-get install -y binfmt-support qemu-user-static

for p in $platforms
do
	for a in $arch
	do
 		if [ "$a" == "amd64" ];   then d="$a"; fi
 		if [ "$a" == "arm64v8" ]; then d="linux/arm64/v8"; fi
   		if [ "$a" == "arm32v7" ]; then d="linux/arm32/v7"; fi
     		if [ "$a" == "arm32v5" ]; then d="linux/arm32/v5"; fi
       		if [ "$a" == "i386" ];    then d="linux/386"; fi
		image="registry.hub.docker.com/$a/$p"
		docker run --platform "$d" -v "$LOCAL:/debs" --env "PLATFORM=$image" --env "VERSION=$v" --env "EMAIL=$email" "$image" /debs/entrypoint.sh
	done
done
