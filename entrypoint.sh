#!/bin/bash

echo "Entry $VERSION $PLATFORM"

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y git lsb-release build-essential pkg-config autoconf automake libtool libavcodec-dev libavdevice-dev libavformat-dev libswscale-dev libjpeg-dev libpq-dev libsqlite3-dev dpkg-dev debhelper dh-autoreconf zlib1g-dev libwebp-dev libmicrohttpd-dev gettext gnupg jq

if [ "$PLATFORM" == "ubuntu:xenial" ] || [ "$PLATFORM" == "i386/ubuntu:xenial" ]
then
	apt-get install -y libmysqlclient-dev

elif [ "$PLATFORM" == "i386/ubuntu:focal" ]
then

	#apt-get install -y default-libmysqlclient-dev
	echo "Only mariadb is supported on Ubuntu Focal"
	echo "See https://github.com/Motion-Project/motion-packaging/issues/13#issuecomment-596222102"
	exit 1

else
	apt-get install -y libmariadbclient-dev
fi

git clone https://github.com/Motion-Project/motion-packaging
cd motion-packaging
./builddeb.sh Motion-Project tosiara@users.noreply.github.com "$VERSION"
cp *.deb /debs/

