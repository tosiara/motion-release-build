#!/bin/bash

arch="amd64 i386 arm64v8 arm32v7 arm32v5"

platforms="ubuntu:xenial ubuntu:bionic ubuntu:focal ubuntu:jammy ubuntu:noble debian:stretch debian:buster debian:bullseye debian:bookworm debian:trixie"
# Currently build script does not support i386/ubuntu:focal because of missing libmariadbclient-dev

email="tosiara@users.noreply.github.com"
LOCAL="$PWD"
v="4.7"

# otherwise you will get exec format error
apt-get install -y qemu binfmt-support qemu-user-static

for p in $platforms
do
	for a in $arch
	do
		image="$a/$p"
		docker pull "$image"
		echo "docker run -v $LOCAL:/debs --env PLATFORM=$image --env VERSION=$v --env EMAIL=$email $image /debs/entrypoint.sh"
		docker run -v "$LOCAL:/debs" --env "PLATFORM=$image" --env "VERSION=$v" --env "EMAIL=$email" "$image" /debs/entrypoint.sh
	done
done
