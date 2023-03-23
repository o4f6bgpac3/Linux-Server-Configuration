#!/bin/sh

echo "Checking if ran as elevated user..."
if [[ "$EUID" = 0 ]]; then
    echo "Confirmed"
else
    sudo -k # make sure to ask for password on next sudo
    if sudo true; then
        echo "Running as elevated user"
    else
        echo "Wrong password"
        exit 1
    fi
fi

read -p "Enter traefik directory (default: /srv/traefik): " dir

if [ -z $dir ]
  then
    dir=/srv/traefik
fi

read -p "Enter GoDaddy Email: " email
read -p "Enter GoDaddy Api Key: " apikey
read -p "Enter GoDaddy Api Secret: " apisecret
read -p "Enter Basic Auth User & Password (format: user:hashedpassword): " basicauth
read -p "Enter Traefik dashboard domain (e.g. traefik.example.com): " traefikdomain
read -p "Enter Root domain (e.g. example.com): " rootdomain

single_dollar_basicauth="${basicauth//\$\$/$}"

escaped_email=$(printf '%q' "$email")
escaped_apikey=$(printf '%q' "$apikey")
escaped_apisecret=$(printf '%q' "$apisecret")
escaped_basicauth=$(printf '%q' "$single_dollar_basicauth")
escaped_traefikdomain=$(printf '%q' "$traefikdomain")
escaped_rootdomain=$(printf '%q' "$rootdomain")

sudo mkdir $dir
sudo touch $dir/acme.json
sudo cp ./config.yml $dir
sudo cp ./docker-compose.yml $dir
sudo cp ./traefik.yml.template $dir/traefik.yml
sudo cp ./.env.template $dir/.env

sudo sed -i "s/GODADDYEMAIL/${escaped_email}/g" $dir/traefik.yml

sudo sed -i "s/GODADDYAPIKEY/${escaped_apikey}/g" $dir/.env
sudo sed -i "s/GODADDYAPISECRET/${escaped_apisecret}/g" $dir/.env
sudo sed -i "s/BASICAUTH/${escaped_basicauth}/g" $dir/.env
sudo sed -i "s/TRAEFIKDOMAIN/${escaped_traefikdomain}/g" $dir/.env
sudo sed -i "s/ROOTDOMAIN/${escaped_rootdomain}/g" $dir/.env

sudo chown -R root:docker $dir
sudo chmod -R 774 $dir
sudo chmod 600 $dir/acme.json

echo "Success! The SSL may take a couple of minutes to work. Type 'docker logs traefik' to check logs."
