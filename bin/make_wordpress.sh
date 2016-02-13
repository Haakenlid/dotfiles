#! /bin/bash

WWW_ROOT="/srv/"

cd "$WWW_ROOT"

prompt_confirm() {
  echo -n "$@ [y/n]  "
  while true; do
    read -rn1 REPLY
    case $REPLY in
      [yY]) echo ; return 0 ;;
      [nN]) echo ; return 1 ;;
      [qQ]) echo -ne "\naborting" ; exit 1 ;;
         *) echo -ne "\b \b\a"
    esac
  done
}

prompt_confirm fittetryne && echo jippi || echo fuck
prompt_confirm drittdåse i kuk && echo jippi || echo fuck
echo 'jippi'
exit 0

SITE=$1
SITE_NAME_REGEX='^.*\.[a-z]{2,}$' 
while [ -z "$SITE" ]; do
  echo 'what is the domain name?'
  read SITE
  if [[ ! $SITE =~ $SITE_NAME_REGEX ]]; then
    echo "\"$SITE\" is not a valid domain name"
    unset SITE
  fi
  if [[ -d $SITE ]]; then
    confirm "$PWD/$SITE already exists. Delete it?"
  fi
done

randpw() { 
  # sixteen random characters
  < /dev/urandom tr -dc A-Za-z0-9 | head -c${1:-16}
}

while [ -z "$MYSQL_ROOT_PW" ]; do
  echo 'mysql root password?'
  read MYSQL_ROOT_PW
  if ! mysql -uroot -p"$MYSQL_ROOT_PW" -e "" >& /dev/null; then
    echo wrong password 
    unset MYSQL_ROOT_PW
  fi
done

DBUSER=${SITE/\./_}
DBNAME=$DBUSER
PASSWORD=$(randpw)

echo $PASSWORD $DBNAME $SITE

echo "creating database: $DBNAME"

SQL="create database $DBNAME;\
  GRANT ALL PRIVILEGES ON $DBNAME.*\
  TO $DBUSER@localhost IDENTIFIED BY '$PASSWORD'"

mysql -u root -p$MYSQL_ROOT_PW -e "$SQL" > /dev/null || exit 1

echo "downloading wordpress"

wget http://wordpress.org/latest.tar.gz

echo "pakker ut filer"
tar -xzvf latest.tar.gz

rm -rf $SITE

echo "kopierer filer til /srv/$SITE"
mv wordpress/ $SITE
rm latest.tar.gz
cd $SITE 
chmod -R g+rw .

echo "oppretter wordpress-konfigurasjon"

cp wp-config-sample.php wp-config.php

sed -i "s/database_name_here/$DBNAME/;s/username_here/$USER/;s/password_here/$PASSWORD/" wp-config.php

PHRASE="put your unique phrase here"
for i in {1..8}; do 
    sed -i "0,/$PHRASE/s/$PHRASE/$(randpw)/" wp-config.php
done

echo "define('FS_METHOD','direct');" >> wp-config.php

echo "konfigurerer nginx"
cd /etc/nginx/sites-available
sed s/DOMAIN_NAME_PLACEHOLDER/$SITE/ template | sudo tee $SITE > /dev/null
sudo ln -srf ./$SITE ../sites-enabled
sudo nginx -s reload

echo "siden er opprettet på http://$SITE"
