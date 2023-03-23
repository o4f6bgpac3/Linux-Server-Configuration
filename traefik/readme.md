# How to install Traefik on CentOS

## Prerequisites

Have the following information ready for the installation:

GODADDY_EMAIL
_The email you use for GoDaddy DNS Management_

GODADDY_API_KEY
_The Api Key for your GoDaddy Domain_

GODADDY_API_SECRET
_The Api Secret	for your GoDaddy Domain_

TRAEFIK_DOMAIN
_The subdomain you want for the traefik dashboard (e.g. traefik.example.com)_

ROOT_DOMAIN
_Your domain (e.g. example.com)_

'sudo yum install -y httpd-tools'
'echo $(htpasswd -nb "admin" "REPLACE_ME_WITH_A_SECURE_PASSWORD") | sed -e s/\$/\$\$/g'
BASIC_AUTH_USER_PASSWORD
_For the authentication dialog when you visit the dashboard, see below how to generate_
'''
sudo yum install -y httpd-tools
echo $(htpasswd -nb "admin" "REPLACE_ME_WITH_A_SECURE_PASSWORD") | sed -e s/\$/\$\$/g
'''

## Installation
- git clone this repository
- cd into cloned directory
- cd traefik
- 'sudo chmod +x install-traefik.sh'
- './install-traefik.sh'

## Running Traefik
- If everything worked well, you should be able to cd into the traefik directory that you specified in the first prompt, then run:
'docker compose up -d'
- Check everything has gone well with:
'docker logs traefik'
- Open a browser and navigate to the TRAEFIK_DOMAIN
- A dialog should appear asking for credentials, these are what you specified in the BASIC_AUTH_USER_PASSWORD step
