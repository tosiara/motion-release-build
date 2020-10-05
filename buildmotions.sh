#!/bin/bash

platforms="ubuntu:xenial ubuntu:bionic ubuntu:focal debian:stretch debian:buster i386/debian:stretch i386/debian:buster i386/ubuntu:xenial i386/ubuntu:bionic"
# Currently build script does not support i386/ubuntu:focal because of missing libmariadbclient-dev

LOCAL="/home/motion/motion-release-build"
v="4.3"

for p in $platforms
do
	docker pull "$p"
	docker run -v "$LOCAL:/debs" --env "PLATFORM=$p" --env "VERSION=$v" -ti "$p" /debs/entrypoint.sh
done

