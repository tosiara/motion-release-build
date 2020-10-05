#!/bin/bash

arch="amd64 i386 arm64v8 arm32v7"

platforms="ubuntu:xenial ubuntu:bionic ubuntu:focal debian:stretch debian:buster"
# Currently build script does not support i386/ubuntu:focal because of missing libmariadbclient-dev

LOCAL="/home/motion/motion-release-build"
v="4.3"

# otherwise you will get exec format error
apt-get install qemu binfmt-support qemu-user-static

for p in $platforms
do
	for a in $arch
	do
		image="$a/$p"
		docker pull "$image"
		docker run -v "$LOCAL:/debs" --env "PLATFORM=$image" --env "VERSION=$v" -ti "$image" /debs/entrypoint.sh
	done
done

