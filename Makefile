# Makefile focusing on Docker

DOCKER_COMPOSE		= docker-compose

##
###----------------------------------#
###    Project commands (Docker)     #
###----------------------------------#
##

build:				./docker-compose.yml ./docker-compose.override.yml.dist ## Build Docker images
					@if [ -f ./docker-compose.override.yml ]; \
            		then \
            			echo '\033[1;41m/!\ The ./docker-compose.override.yml already exists. So delete it, if you want to reset it.\033[0m'; \
            		else \
            			cp ./docker-compose.override.yml.dist ./docker-compose.override.yml; \
            		   	echo '\033[1;42m/!\ The ./docker-compose.override.yml was just created. Feel free to put your config in it.\033[0m'; \
            		fi
					$(DOCKER_COMPOSE) pull --quiet --ignore-pull-failures 2> /dev/null
					$(DOCKER_COMPOSE) build --force-rm --compress

start:				## Start all containers
					$(DOCKER_COMPOSE) up -d --remove-orphans --no-recreate

stop:				## Stop all containers
					$(DOCKER_COMPOSE) stop

install:			build start composer  ## Launch project : Build Docker and start the project with vendors

kill:				## Kill Docker containers
					$(DOCKER_COMPOSE) kill
					$(DOCKER_COMPOSE) down --volumes --remove-orphans

clear:				kill rmi ## Remove all containers and images

rmi:				## Remove all images (<none> too)
					docker image prune -fa

reset:				clear build ## Alias coupling clear and build rules

.PHONY:				build start stop install kill clear rmi reset

##
###------------#
###    Vendor  #
###------------#
##

composer:			## Install vendor/
					$(DOCKER_COMPOSE) exec -T php /usr/bin/entrypoint composer install -d ./app/ --prefer-dist --no-progress

.PHONY: 			composer

##
###------------#
###    Help    #
###------------#
##

.DEFAULT_GOAL := 	help

help:				## DEFAULT_GOAL : Display help messages from parent Makefile
					@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.PHONY: 			help
