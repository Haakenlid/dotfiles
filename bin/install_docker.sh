#!/bin/bash

[ $UID != 0 ] && echo 'must run as root' && exit 1

apt install apt-transport-https ca-certificates
apt-key adv \
  --keyserver hkp://ha.pool.sks-keyservers.net:80 \
  --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
REPO="deb https://apt.dockerproject.org/repo ubuntu-xenial main"
echo "$REPO" | tee /etc/apt/sources.list.d/docker.list
apt update
apt install docker-engine
pip3 install docker-compose

