#!/bin/bash

arch="amd64 i386 arm64v8 arm32v7 arm32v5"

email="tosiara@users.noreply.github.com"
LOCAL="$PWD"
v="$VERSION"

if [ -z "$v" ]
then
	v="4.7"
fi

for a in $arch
do
	image="$a/$1"
	docker_platforms=`docker run --rm mplatform/mquery $image`
	if [ "$a" == "amd64" ];   then is_supported=`echo $docker_platforms | grep amd64`; d="$a"; fi
	if [ "$a" == "arm64v8" ]; then is_supported=`echo $docker_platforms | grep arm64`; d="arm64/v8"; fi
	if [ "$a" == "arm32v7" ]; then is_supported=`echo $docker_platforms | grep -E 'linux\/arm$|linux\/arm\/v7'`; d="arm/v7"; fi
	if [ "$a" == "arm32v5" ]; then is_supported=`echo $docker_platforms | grep -E 'linux\/arm$|linux\/arm\/v5'`; d="arm/v5"; fi
	if [ "$a" == "i386" ];    then is_supported=`echo $docker_platforms | grep 386`; d="386"; fi
	 
	echo "Target image: $image"
	echo "Target docker platform: $d"
	echo "docker platform: $docker_platforms"
	echo "Is supported: $is_supported"

	if [ -z "$is_supported" ]; then continue; fi
	echo "Building..."
	docker run --platform "linux/$d" -v "$LOCAL:/debs" --env "PLATFORM=$image" --env "VERSION=$v" --env "EMAIL=$email" "$image" /debs/entrypoint.sh

done

