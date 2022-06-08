# motion-release-build

Docker script to build multiple motion releases

# Supported platforms

* ubuntu:jammy
* ubuntu:xenial
* ubuntu:bionic
* ubuntu:focal
* debian:stretch
* debian:buster
* debian:bullseye

# Supported archinectures
 
 * amd64
 * i386
 * arm64v8
 * arm32v7
 * arm32v5
  
 # Not supported
 
 * i386/ubuntu:focal - libmariadbclient-dev not available
 * arm64v8/debian:bullseye - instaling libmariadb-dev crashes the docker image
 ```
 Processing triggers for libc-bin (2.31-13+deb11u2) ...
 qemu: uncaught target signal 11 (Segmentation fault) - core dumped
 ```

