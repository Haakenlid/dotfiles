#!/bin/bash

if [[ -z $1 ]]; then
  echo 'usage: install [packages ...]' >&2
  exit 1
fi


function main__() {
  must_be_root || exit 1
  REGULAR=()
  SPECIAL=()
  for arg in $@; do
    case $arg in
    ripgrep|rg   )  _ripgrep                ;;
    find|fd      )  _fd                     ;;
    spotify      )  SPECIAL+=($(_spotify))  ;;
    docker       )  SPECIAL+=($(_docker))   ;;
    neovim       )  SPECIAL+=($(_neovim))   ;;
    nodejs|node  )  REGULAR+=($(_nodejs))   ;;
    *            )  REGULAR+=($arg)         ;;
    esac
  done
  if [[ $SPECIAL ]]
    then apt-get update >/dev/null
    else apt_update_if_needed >/dev/null
  fi
  APTLIST=("${SPECIAL[@]}" "${REGULAR[@]}")
  [[ $APTLIST ]] && apt install -y ${APTLIST[@]}
}

function must_be_root() {
  if [[ $UID == 0 ]]
  then return 0
  else
    echo "$(basename $0) must run as root" >&2
    return 1
  fi
}

function apt_update_if_needed() {
  # Run update if it has not been done in a while
  TWENTY_FOUR_HOURS=$(( 60 * 60 * 24 ))
  APT_CACHE_FILE='/var/cache/apt/pkgcache.bin'

  NOW=$(date +%s)
  LAST_UPDATE=$(stat $APT_CACHE_FILE -c %Y)
  DELTA=$(( NOW - LAST_UPDATE ))
  [[ $DELTA -gt $TWENTY_FOUR_HOURS ]] && apt-get update
}

function _docker() {
  DOCKER_REPO="deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  echo "$DOCKER_REPO" > /etc/apt/sources.list.d/docker.list
  (
    type apt-key &>/dev/null || apt-get install -y \
      apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    python3 -m pip install --upgrade docker-compose
    groupadd -f docker
    usermod -aG docker $SUDO_USER
  ) >&2
  echo 'docker-ce docker-ce-cli containerd.io'
}

function _neovim() {
  su $SUDO_USER << EOF
ln -fsT ${HOME}/.vim ${HOME}/.config/nvim
ln -fsT ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim
EOF
  echo 'neovim python3-neovim'
}

function _nodejs() {
  DOWNLOAD=https://deb.nodesource.com/setup_11.x
  echo "downloading and executing ${DOWNLOAD}" >&2
  curl -sL ${DOWNLOAD} | /bin/bash - | awk '/^##/' >&2
  echo 'nodejs'
}

function _spotify() {
  SPOTIFY_REPO='deb http://repository.spotify.com stable non-free'
  echo "$SPOTIFY_REPO" > /etc/apt/sources.list.d/spotify.list
  (
    apt-key adv \
      --keyserver hkp://keyserver.ubuntu.com:80 \
      --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
  ) >&2
  echo 'spotify-client'
}

function _fd() {
  REPO="sharkdp/fd"
  LATEST=$(curl -sSL "https://api.github.com/repos/${REPO}/releases/latest" \
    | sed -n 's/.*tag_name".*"\(.*\)".*/\1/p')
  echo
  echo "install fd version: ${LATEST=v7.0.0}"  # fallback to v7.0.0
  ARCHITECTURE="amd64"  # or "i386"
  FILENAME="fd_${LATEST#v}_${ARCHITECTURE}.deb"
  DOWNLOAD="https://github.com/${REPO}/releases/download/${LATEST}/${FILENAME}"
  TMPDIR=$(mktemp -d)
  # https://github.com/sharkdp/fd/releases/download/v7.0.0/fd_7.0.0_amd64.deb
  (
    cd ${TMPDIR}
    echo "downloading ${DOWNLOAD}"
    wget --show-progress -q ${DOWNLOAD}
    ls -R1
    sudo dpkg -i ${FILENAME} && echo $'Install fd OK'
  ) >&2
  rm -r ${TMPDIR}
}

function _ripgrep() {
  REPO="BurntSushi/ripgrep"
  LATEST=$(curl -sSL "https://api.github.com/repos/${REPO}/releases/latest"\
    | sed -n '/tag_name/s/[^0-9.]//gp')
  echo
  echo "install ripgrep version: ${LATEST=0.8.1}"  # fallback to v0.8.1
  FILE="${LATEST}/ripgrep-${LATEST}-x86_64-unknown-linux-musl.tar.gz"
  DOWNLOAD="https://github.com/${REPO}/releases/download/${FILE}"
  TMPDIR=$(mktemp -d)
  (
    cd $TMPDIR
    echo "downloading ${DOWNLOAD}"
    wget --show-progress -q -O - ${DOWNLOAD} | tar zxf - --strip-component=1
    tree --noreport # list files
    cp rg /usr/local/bin/ && echo $'Install ripgrep OK'
    cp doc/rg.1 /usr/local/share/man/man1/
    cp complete/rg.bash /usr/share/bash-completion/completions/rg
    mandb -q
  ) >&2
  rm -r $TMPDIR
}

main__ $@
