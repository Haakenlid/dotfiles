#!/bin/bash

if logname &>/dev/null
then USER_NAME=$(logname)
else USER_NAME=$SUDO_USER
fi
if [[ -z $1 ]]; then
  echo 'usage: install [packages ...]' >&2
  exit 1
fi


function main__() {
  is_root || exit 1
  OTHER=()
  SPECIAL=()
  for arg in $@; do
    case $arg in
      spotify ) SPECIAL+=($(_spotify)) ;;
      docker  ) SPECIAL+=($(_docker)) ;;
      neovim  ) SPECIAL+=($(_neovim)) ;;
      nodejs  ) SPECIAL+=($(_nodejs)) ;;
      *       ) OTHER+=($arg) ;;
    esac
  done
  if [[ $SPECIAL ]]
  then apt update
  else apt_update
  fi
  apt install -y ${SPECIAL[@]} ${OTHER[@]}
}

function is_root() {
  # Is this run as root?
  [ $UID != 0 ] && echo 'must run as root' && return 1
  return 0
}

function apt_update() {
  # Update if needed
  APT_CACHE_FILE='/var/cache/apt/pkgcache.bin'
  # this file will be modified by apt-get update
  NOW=$(date +%s)
  LAST_UPDATE=$(stat $APT_CACHE_FILE -c %Y)
  DELTA=$(( NOW - LAST_UPDATE ))
  ONE_HOUR=3600
  [[ $DELTA -gt $ONE_HOUR ]] && apt update
}

function _docker() {
  DOCKER_REPO="deb https://apt.dockerproject.org/repo ubuntu-xenial main"
  echo "$DOCKER_REPO" > /etc/apt/sources.list.d/docker.list
  # apt-get install -y apt-transport-https ca-certificates
  (
  apt-key adv \
    --keyserver hkp://ha.pool.sks-keyservers.net:80 \
    --recv-keys 58118E89F3A912897C070ADBF76221572C52609D 
  python3 -m pip install docker-compose
  groupadd -f docker
  usermod -aG docker $USER_NAME
  ) >&2
  echo 'docker-engine'
}

function _neovim() {
  su $USER_NAME << 'EOF'
  ln -fs ${HOME}/.vim ${HOME}/.config/nvim
  ln -fs ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim
EOF
  echo 'neovim python3-neovim'
}

function _nodejs() {
  curl -sL https://deb.nodesource.com/setup_8.x | /bin/bash - >&2
  echo 'nodejs'
}

function _spotify() {
  (
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 

  echo 'deb http://repository.spotify.com stable non-free' > /etc/apt/sources.list.d/spotify.list
  ) >&2
  echo 'spotify-client'
}

main__ $@
