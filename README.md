# Simple Docker starter using a PHP stack
> Dockerized your web environment using PHP7.3, NGINX, COMPOSER, PHPUNIT, PHP-CS-FIXER, XDEBUG.


![Software License](https://img.shields.io/badge/php-%5E7.3-brightgreen.svg)

[![Author](https://img.shields.io/badge/author-gaetan.role--dubruille%40sensiolabs.com-blue.svg)](https://github.com/gaetanrole)

This repository uses official [PHP](https://hub.docker.com/_/php) and [NGINX](https://hub.docker.com/_/nginx) containers.

## Installation instructions

### Contents

- [PHP-FPM 7.3](https://hub.docker.com/_/php)
- [NGINX 1.15](https://hub.docker.com/_/nginx)
- [Composer 1.8](https://getcomposer.org/)
- [PHPunit 7.5](https://phpunit.de/)
- [PHP-CS-FIXER-V2](https://github.com/FriendsOfPHP/PHP-CS-Fixer)
- [Xdebug 2.7](https://xdebug.org/)

### Project requirements

- [Docker Machine](https://docs.docker.com/machine/overview/)
- [Docker Engine](https://docs.docker.com/installation/)
- [Docker Compose](https://docs.docker.com/compose/)
- Make (or not)

### Suggested requirements (for Mac)

- [Docker Machine NFS](https://github.com/adlogix/docker-machine-nfs)

### Suggested requirements (for Windows)

- Maybe a suggestion ? So add your contribution !

### Tree view

```
app/
    public/
    src/
    tests/
docker/
    nginx/
    php/
docker-compose.override.yml.dist
docker-compose.yml
README.md
```

### Installation

Assuming you have a running docker machine, **create and add your own config** `./docker-compose.override.yml`, based on the dist one.
Then let's run docker-compose :

```bash
$ docker-compose up -d
$ docker-compose exec -T php /usr/bin/entrypoint composer install -d /srv/app/ --prefer-dist 
```

Or if you want use the project's **Makefile** :

```bash
$ make install
```

> See other commands in it, such as clear, kill and so on.

## Usage

**Go on** : http://localhost:8080/ (or other ports specified in your `./docker-compose.override.yml`)

### Useful commands

```bash
# shell commands
$ docker-compose exec php /usr/bin/entrypoint sh

# Composer (e.g. composer update)
$ docker-compose exec -T php /usr/bin/entrypoint composer update -d /srv/app

# Retrieve an container IP Address (here for the http one with nginx container_name)
$ docker inspect --format '{{ .NetworkSettings.Networks.dockersymfony_default.IPAddress }}' $(docker ps -f name=nginx -q)
$ docker inspect $(docker ps -f name=nginx -q) | grep IPAddress

# Check container CPU consumption
$ docker stats $(docker inspect -f "{{ .Name }}" $(docker ps -q))

# Delete all containers
$ docker stop $(docker ps -aq)
$ docker rm $(docker ps -aq)

# Delete all images
$ docker rmi $(docker images -q)
```

## Using PHPUnit, XDebug, PHP-CS-FIXER

Default configuration is already set, see `./docker/php/conf.d/*.ini`.
Do not hesitate to add your `xdebug.remote_host` and configure your IDE, according to the current configuration.

_- E.g._ : 

```bash
$ docker-compose exec -T php /usr/bin/entrypoint /srv/app/vendor/bin/phpunit --configuration /srv/app/phpunit.xml.dist /srv/app/tests 
$ docker-compose exec -T php /usr/bin/entrypoint php-cs-fixer fix app/src/ --rules=@PSR2 
```

## Application path

The default application path is located at `./app/public/index.php`.
You will need to alter the application path depending on your specific needs, e.g. if using
Symfony, create a Symfony directory with all the application in it and change your NGINX conf & volumes path to `./app/symfony/public/index.php`.
You can also add a Makefile to be comfortable with Docker commands.

## Anything else ?

If you want persist some data to your application you can add these containers to your `docker-compose.yml` :

```docker
  database:
    image: mariadb:latest
    container_name: mariadb
    working_dir: /srv
    restart: always
```

And to your `docker-composer.override.yml.dist` :

```docker
  database:
    volumes:
      - "./data/db:/var/lib/mysql"
    environment:
      - MYSQL_DATABASE=<YOUR_DB_NAME>
      - MYSQL_USER=<YOUR_DB_USER>
      - MYSQL_PASSWORD=<YOUR_DB_PASSWORD>
      - MYSQL_RANDOM_ROOT_PASSWORD=yes
    ports:
      - "3306:3306"

  # http://localhost:8008/?server=database
  adminer:
    image: adminer:latest
    container_name: adminer
    working_dir: /srv
    restart: on-failure
    ports:
      - "8008:8080"
    links:
      - database

```

## Contributing

Do not hesitate to improve this repository, creating your PR on GitHub with a description which explains it.

Ask your question on `gaetan.role-dubruille@sensiolabs.com`.
