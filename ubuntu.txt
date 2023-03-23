# IP Address: 54.229.214.39
# URL: http://54.229.214.39.xip.io

# Initial Login

## Update System
sudo apt-get update
sudo apt-get upgrade

## Configure Firewall
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 2200/tcp
sudo ufw allow 22
sudo ufw allow www
sudo ufw allow ntp
sudo ufw show added
sudo ufw enable
sudo ufw status

## Change ssh Port
sudo nano /etc/ssh/sshd_config
Change port from 22 to 2200
Add rule in lightsail Networking page to allow Custom TCP Port 2200

# Login with Port 2200
sudo ufw deny 22
sudo service ssh restart
Remove rule in lightsail Networking page for SSH TCP on Port 2200

## Configure new user
sudo useradd -m -s /bin/bash grader
sudo usermod -aG sudo grader
sudo mkdir /home/grader/.ssh
sudo chown grader:grader /home/grader/.ssh
sudo chmod 700 /home/grader/.ssh
sudo touch /home/grader/.ssh/authorized_keys
sudo chown grader:grader /home/grader/.ssh/authorized_keys
sudo chmod 644 /home/grader/.ssh/authorized_keys
sudo nano /home/grader/.ssh/authorized_keys
Add public ssh key content into this file
sudo passwd grader

# Login as grader

## Install required software
sudo apt-get install libapache2-mod-wsgi-py3
sudo apt-get install apache2
sudo apt-get install postgresql
sudo apt-get install python3-sqlalchemy
sudo apt-get install python3-psycopg2
sudo apt-get install python3-flask
sudo apt-get install python3-pip
sudo apt-get install git (already installed)
sudo pip3 install oauth2client
sudo pip3 install requests

## Configure postgresql
sudo -u postgres createuser -P catalog

## Get Item Catalog project
git clone https://github.com/mwade290/ItemCatalog.git (from home directory)
sudo cp -r ItemCatalog/ /var/www/
sudo mv /var/www/ItemCatalog /var/www/catalog
cd /var/www/catalog/catalog

## Modify project to suit server
sudo mv application.py __init__.py
sudo nano __init__.py
Insert 'sys.path.insert("/var/www/catalog/catalog")' under import statements
Move 'from database_setup import Base, User, Country, Highlight' to after sys.path.insert line
Modify CLIENT_ID clients_secrets.json path to "/var/www/catalog/catalog/client_secrets.json"
Modify 'for x in xrange(32)' to 'for x in range(32)'
Modify database engine to: postgres://catalog:password@localhost/catalog
sudo nano database_setup.py
Modify database engine to: postgres://catalog:password@localhost/catalog
sudo nano populate_database.py
python3 database_setup.py
python3 populate_database.py
python3 __init__.py (ctrl+c to quit when confirmed to be working)

## Create wsgi 
cd /var/www/catalog
sudo touch catalog.wsgi
sudo nano catalog.wsgi

Add the following:

#!/usr/bin/python
import sys
import logging
logging.basicConfig(stream=sys.stderr)
sys.path.insert(0, "/var/www/catalog/")

from catalog import app as application

application.secret_key = 'your_secret_key'


## Create apache2 config file
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/catalog.conf
sudo nano /etc/apache2/sites-available/catalog.conf
Modify: DocumentRoot /var/www/catalog/

Add the following: 

WSGIScriptAlias / /var/www/catalog/catalog.wsgi
<Directory /var/www/catalog/catalog/>
	Order allow,deny
	Allow from all
</Directory>

## Configure apache2 to host application
sudo a2dissite 000-default.conf
sudo a2ensite catalog.conf
sudo a2enmod wsgi
sudo service apache2 restart



# Third Party Resources:
http://modwsgi.readthedocs.io/en/develop/user-guides/virtual-environments.html
https://github.com/jrleszcz/linux-server-setup/blob/master/how-to/configure-firewall-and-change-ssh-port.md
https://medium.com/coding-blocks/creating-user-database-and-adding-access-on-postgresql-8bfcd2f4a91e
https://docs.djangoproject.com/en/1.9/howto/deployment/wsgi/modwsgi/#using-mod-wsgi-daemon-mode
https://blog.theodo.fr/2017/03/developping-a-flask-web-app-with-a-postresql-database-making-all-the-possible-errors/
