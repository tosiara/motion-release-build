#!/bin/basdh

# otherwise you will get exec format error
apt-get update
apt-get install -y binfmt-support qemu-user-static

platforms="ubuntu:bionic ubuntu:focal ubuntu:jammy ubuntu:noble debian:buster debian:bullseye debian:bookworm debian:trixie"

for p in $platforms
do
    ./build-distro.sh "$p"
done

