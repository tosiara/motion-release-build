#!/bin/basdh

# otherwise you will get exec format error
apt-get update
apt-get install -y binfmt-support qemu-user-static

platforms="ubuntu:xenial ubuntu:bionic ubuntu:focal ubuntu:jammy ubuntu:noble debian:stretch debian:buster debian:bullseye debian:bookworm debian:trixie"
# Currently build script does not support i386/ubuntu:focal because of missing libmariadbclient-dev

for p in $platforms
do
    ./build-distro.sh "$p"
done
