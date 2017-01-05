#!/bin/bash

[ $UID != 0 ] && echo 'must run as root' && exit 1

curl -sL https://deb.nodesource.com/setup_7.x | /bin/bash -
apt install -y nodejs
