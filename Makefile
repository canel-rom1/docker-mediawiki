prefix ?= canelrom1
name   ?= mediawiki
tag    ?= $(shell date +%Y%m%d.%H%M%S)

port   ?= 80

all: run

run:
	docker run -d --name $(name) \
                   -p $(port):80 $(prefix)/$(name):latest

build: src/Dockerfile
	docker build -t $(prefix)/$(name):$(tag) src
	docker tag $(prefix)/$(name):$(tag) $(prefix)/$(name):latest 

stop:
	docker stop $(name)

rm: stop
	docker rm $(name)

clean-docker:
	docker rmi $(prefix)/$(name):$(tag)

clean-docker-latest:
	docker rmi $(prefix)/$(name):latest

clean: clean-docker clean-docker-latest

monitor:
	docker exec -it $(name) sh

up:
	docker-compose up -d

down:
	docker-compose down


# vim: ft=make
