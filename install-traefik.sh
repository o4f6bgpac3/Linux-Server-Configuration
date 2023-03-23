#!/bin/sh

read -p "Enter traefik directory (default: /srv/traefik): " dir

if [ -z $dir ]
  then
    dir=/srv/traefik
fi

read -p "Enter GoDaddy Email" email
read -p "Enter GoDaddy Api Key " apikey
read -p "Enter GoDaddy Api Secret " apisecret
read -p "Enter Basic Auth User & Password (format: user:hashedpassword) " basicauth
read -p "Enter Traefik dashboard domain (e.g. traefik.example.com): " traefikdomain
read -p "Enter Root domain (e.g. example.com): " rootdomain

escaped_email=$(printf '%q' "$email")
escaped_apikey=$(printf '%q' "$apikey")
escaped_apisecret=$(printf '%q' "$apisecret")
escaped_basicauth=$(printf '%q' "$basicauth")
escaped_traefikdomain=$(printf '%q' "$traefikdomain")
escaped_rootdomain=$(printf '%q' "$rootdomain")

mkdir $dir
touch $dir/acme.json
chmod 600 $dir/acme.json
cp ./config.yml $dir
cp ./docker-compose.yml $dir
cp ./traefik.yml.template $dir/traefik.yml
cp ./.env.template $dir/.env

sed -i "s/GODADDYEMAIL/${escaped_email}/g" $dir/traefik.yml

sed -i "s/GODADDYAPIKEY/${escaped_apikey}/g" $dir/.env
sed -i "s/GODADDYAPISECRET/${escaped_apisecret}/g" $dir/.env
sed -i "s/BASICAUTH/${escaped_basicauth}/g" $dir/.env
sed -i "s/TRAEFIKDOMAIN/${escaped_traefikdomain}/g" $dir/.env
sed -i "s/ROOTDOMAIN/${escaped_rootdomain}/g" $dir/.env

chown root:docker $dir
chmod 774 $dir

echo "Success!"
