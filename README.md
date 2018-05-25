# IP Address: 54.165.216.76
# URL: http://54.165.216.76

# Summary of steps:
## Configure ufw
## Change ssh port
## Update and upgrade all packages
## Add user 'grader', include in sudoers group and setup ssh key
## Install appropriate packages for Item Catalog application
## Install git and clone Item Catalog repo
## Copy repo to appropriate hosting directory
## Set up postgresql to handle the database
## Modify Item Catalog code for new database
## Create .wsgi file
## Create apache2 config file

# Summary of installed software:
## libapache2-mod-wsgi-py3
## python-psycopg2
## python-flask
## python-sqlalchemy
## python-pip
## oauth2client
## requests
## httplib2

# Third Party Resources:
## http://modwsgi.readthedocs.io/en/develop/user-guides/virtual-environments.html
## https://github.com/jrleszcz/linux-server-setup/blob/master/how-to/configure-firewall-and-change-ssh-port.md
## https://medium.com/coding-blocks/creating-user-database-and-adding-access-on-postgresql-8bfcd2f4a91e
## https://docs.djangoproject.com/en/1.9/howto/deployment/wsgi/modwsgi/#using-mod-wsgi-daemon-mode
## https://blog.theodo.fr/2017/03/developping-a-flask-web-app-with-a-postresql-database-making-all-the-possible-errors/
