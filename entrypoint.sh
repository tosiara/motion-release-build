#!/bin/bash

echo "Entry $VERSION $PLATFORM"

apt-get update
if [ "$?" != "0" ]
then
	sed -i 's@deb.debian.org/debian-security@security.debian.org/debian-security@g' /etc/apt/sources.list
	sed -i 's@http://deb.@http://archive.@g' /etc/apt/sources.list
 	apt-get update
fi
DEBIAN_FRONTEND=noninteractive apt-get install -y git lsb-release build-essential pkg-config autoconf automake libtool libavcodec-dev libavdevice-dev libavformat-dev libswscale-dev libjpeg-dev libpq-dev libsqlite3-dev dpkg-dev debhelper dh-autoreconf zlib1g-dev libwebp-dev libmicrohttpd-dev gettext gnupg jq

if [[ "$PLATFORM" == *ubuntu:xenial ]]
then
	apt-get install -y libmysqlclient-dev

elif [[ "$PLATFORM" == *ubuntu:jammy ]] || [[ "$PLATFORM" == *ubuntu:noble ]] || [[ "$PLATFORM" == *debian:bullseye ]] || [[ "$PLATFORM" == *debian:bookworm ]] || [[ "$PLATFORM" == *debian:trixie ]]
then
        apt-get install -y libmariadb-dev

elif [ "$PLATFORM" == "i386/ubuntu:focal" ]
then

	#apt-get install -y default-libmysqlclient-dev
	echo "Only mariadb is supported on Ubuntu Focal i386"
	echo "See https://github.com/Motion-Project/motion-packaging/issues/13#issuecomment-596222102"
	exit 1
else
	apt-get install -y libmariadbclient-dev
fi

if [[ "$PLATFORM" == *debian:bookworm ]] || [[ "$PLATFORM" == *debian:trixie ]]
then
	apt-get install -y libcamera-tools libcamera-dev libcamera-v4l2
fi

if [ "$PLATFORM" == "arm32v5/debian:bullseye" ]
then
	echo "Debian Bullseye armel support has been dropped due to LTS"
	exit 1
fi

git clone https://github.com/tosiara/motion-packaging
cd motion-packaging
./builddeb.sh Motion-Project "$EMAIL" "$VERSION"
cp *.deb /debs/

