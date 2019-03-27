# Simple Docker starter using PHP stack
> Dockerized your web environment using PHP7, NGINX, COMPOSER, PHPUNIT, PHP-CS-FIXER, XDEBUG.


![Software License](https://img.shields.io/badge/php-%5E7.3-brightgreen.svg)
![UPTODATE](https://img.shields.io/badge/dependencies-up%20to%20date-brightgreen.svg)

[![Author](https://img.shields.io/badge/author-gaetan.role--dubruille%40sensiolabs.com-blue.svg)](https://github.com/gaetanrole)

This repository uses official [PHP](https://hub.docker.com/_/php) and [NGINX](https://hub.docker.com/_/nginx) containers.

## Contents
- [PHP-FPM 7.3](https://php-fpm.org/)
- [NGINX](https://nginx.org/)
- [Composer 1.8](https://getcomposer.org/)
- [PHPunit 7.5](https://phpunit.de/)
- [PHP-CS-FIXER-V2](https://github.com/FriendsOfPHP/PHP-CS-Fixer)
- [Xdebug 2.7](https://xdebug.org/)

## Requirements
- [Docker Engine](https://docs.docker.com/installation/)
- [Docker Compose](https://docs.docker.com/compose/)

## Usage

Assuming you have a running docker machine, create and add your own config `./docker-compose.override.yml`, based on the dist one.
Then let's run docker-compose :

```bash
$ docker-compose up -d
$ docker-compose exec php composer install -d /srv/app/ --prefer-dist 
```

Go on : http://localhost:8082/ (or other ports specified in your `./docker-compose.override.yml`)

_- Wanna take a look ?_
```bash
$ docker-compose exec php sh
```
## Using PHPUnit, XDebug, PHP-CS-FIXER

Default configuration is already set, see `./docker/php/conf.d/*.ini`.
Do not hesitate to add your `xdebug.remote_host` and configure your IDE, according to the current configuration.

_- E.g._ : 
```bash
$ docker-compose exec php /srv/app/vendor/bin/phpunit --configuration /srv/app/phpunit.xml.dist /srv/app/tests 
$ docker-compose exec php php-cs-fixer fix app/src/ --rules=@PSR2 
```

## Application path

The default application path is located at `./app/public/index.php`.
You will need to alter the application path depending on your specific needs, e.g. if using
Symfony, create a symfony directory with all the application in it and change your NGINX conf & volumes path to `./app/symfony/public/index.php`

27/03/2019