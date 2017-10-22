#!/bin/bash

if [[ -z $1 ]]; then
  echo 'usage: install [packages ...]' >&2
  exit 1
fi


function main__() {
  must_be_root || exit 1
  OTHER=()
  SPECIAL=()
  for arg in $@; do
    case $arg in
      spotify ) SPECIAL+=($(_spotify)) ;;
      docker  ) SPECIAL+=($(_docker)) ;;
      neovim  ) SPECIAL+=($(_neovim)) ;;
      nodejs  ) SPECIAL+=($(_nodejs)) ;;
      ripgrep ) SPECIAL+=($(_ripgrep)) ;;
      *       ) OTHER+=($arg) ;;
    esac
  done
  if [[ $SPECIAL ]]
  then apt update
  else apt_update
  fi
  apt install -y ${SPECIAL[@]} ${OTHER[@]}
}

function must_be_root() {
  [[ $UID == 0 ]] && return 0
  echo 'must run as root' >&2
  return 1
}

function apt_update() {
  # Run update if it has not been done in a while
  TWENTY_FOUR_HOURS=$(( 60 * 60 * 24 ))
  APT_CACHE_FILE='/var/cache/apt/pkgcache.bin'

  NOW=$(date +%s)
  LAST_UPDATE=$(stat $APT_CACHE_FILE -c %Y)
  DELTA=$(( NOW - LAST_UPDATE ))
  [[ $DELTA -gt $TWENTY_FOUR_HOURS ]] && apt update
}

function _docker() {
  DOCKER_REPO="deb https://apt.dockerproject.org/repo ubuntu-xenial main"
  echo "$DOCKER_REPO" > /etc/apt/sources.list.d/docker.list
  (
    type apt-key &>/dev/null || apt-get install -y apt-transport-https ca-certificates
    apt-key adv \
      --keyserver hkp://ha.pool.sks-keyservers.net:80 \
      --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    python3 -m pip install docker-compose
    groupadd -f docker
    usermod -aG docker $SUDO_USER
  ) >&2
  echo 'docker-engine'
}

function _neovim() {
  su $SUDO_USER << EOF
ln -fsT ${HOME}/.vim ${HOME}/.config/nvim
ln -fsT ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim
EOF
  echo 'neovim python3-neovim'
}

function _nodejs() {
  curl -sL https://deb.nodesource.com/setup_8.x \
    | /bin/bash - >&2
  echo 'nodejs'
}

function _spotify() {
  SPOTIFY_REPO='deb http://repository.spotify.com stable non-free'
  echo "$SPOTIFY_REPO" > /etc/apt/sources.list.d/spotify.list
  (
    apt-key adv \
      --keyserver hkp://keyserver.ubuntu.com:80 \
      --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
  ) >&2
  echo 'spotify-client'
}

function _ripgrep() {
  REPO="https://github.com/BurntSushi/ripgrep/releases/download/"
  RELEASE="0.6.0/ripgrep-0.6.0-x86_64-unknown-linux-musl.tar.gz"
  (
    TMPDIR=$(mktemp -d)
    cd $TMPDIR
    wget --show-progress -q -O - ${REPO}${RELEASE} | tar zxf - --strip-component=1

    cp rg /usr/local/bin/
    cp rg.1 /usr/local/share/man/man1/
    cp complete/rg.bash-completion /usr/share/bash-completion/completions/rg

    cd ..
    rm -r $TMPDIR
    mandb -q
  ) >&2
}

main__ $@
