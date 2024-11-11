#!/bin/bash

arch="amd64 i386 arm64v8 arm32v7 arm32v5"
arch="arm32v7"

platforms="ubuntu:xenial ubuntu:bionic ubuntu:focal ubuntu:jammy ubuntu:noble debian:stretch debian:buster debian:bullseye debian:bookworm debian:trixie"
platforms="ubuntu:jammy debian:bookworm"
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
 		image="$a/$p"
   		docker_platforms=`docker run --rm mplatform/mquery $image`
 		if [ "$a" == "amd64" ];   then is_supported=`echo $docker_platforms | grep amd64`; fi
 		if [ "$a" == "arm64v8" ]; then is_supported=`echo $docker_platforms | grep arm64`; fi
   		if [ "$a" == "arm32v7" ]; then is_supported=`echo $docker_platforms | grep -E 'linux\/arm$|linux\/arm\/v7'`; fi
     		if [ "$a" == "arm32v5" ]; then is_supported=`echo $docker_platforms | grep -E 'linux\/arm$|linux\/arm\/v5'`; fi
       		if [ "$a" == "i386" ];    then is_supported=`echo $docker_platforms | grep 386`; fi
	 
	 	echo "Target image: $image"
   		echo "Target docker platform: $d"
   		echo "docker platform: $docker_platforms"
       		echo "Is supported: $is_supported"

	 	if [ -z "$is_supported" ]; then continue; fi
   		echo "Building..."
		docker run --platform "$d" -v "$LOCAL:/debs" --env "PLATFORM=$image" --env "VERSION=$v" --env "EMAIL=$email" "$image" /debs/entrypoint.sh
	done
done
