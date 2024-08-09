# Linux Server Configuration

## Introduction

This repo was created to help me reset my home server to a usable state if it ever failed but as there's lots that I've learned in this process, it makes sense to be public in case 
anyone else comes across any similar issues and needs some examples.

## Usage

### Traefik

Traefik is a reverse proxy, which means any traffic that comes into the server will go to Traefik which will then redirect (route) it to where it needs to be.
Navigate to the Traefik directory and use the readme there.

### Containers

Additional containers have been placed in the containers folder to be used at will.
All that's required is to create a directory somewhere, copy the docker-compose.yml and .env files there, adjust the .env to suit and run 'docker compose up -d'.
Traefik will automatically* detect the new container and route the relevant traffic to it.

\*This is assuming they're on the same docker network and the docker-compose.yml has been set up correctly

### GoDaddy

This no longer works because GoDaddy has changed their API. I've left it here for reference but it's not usable.

### Cloudflare

This contains a script which updates the IP on your domain if you don't have a static IP.
Follow comments in cloudflare.txt for permissions and crontab setup.

## Sources

As always, the internet is wealth of knowledge, but it's hard to navigate through it all so I'll list some handy sources that have helped me set all this up.

### https://www.youtube.com/@TechnoTim

TechnoTim has some great videos on homelab setups and is very easy to listen to.
