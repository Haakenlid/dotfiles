#! /bin/bash

# Update url to latest version
URL='https://github.com/BurntSushi/ripgrep/releases/download/0.6.0/ripgrep-0.6.0-x86_64-unknown-linux-musl.tar.gz'

if [[ ! $UID == 0 ]]; then 
  echo 'must be root to install' >&2 
  exit 1
fi

# download
mkdir _RG_
wget -O - "$URL" | tar zxf - -C _RG_ --strip-component=1

# binary
cp _RG_/rg /usr/local/bin/rg

# man pages
cp _RG_/rg.1 /usr/local/share/man/man1/
mandb 

# bash completions
cp _RG_/complete/rg.bash-completion /usr/share/bash-completion/completions/rg

# cleanup
rm -r _RG_
