EDITOR=vim

all: regconfig build

build:
	docker build -t tfoldi/tableau-server:beta .

run: build
	docker run -ti --privileged -v /sys/fs/cgroup:/sys/fs/cgroup -v /run -p 80 tfoldi/tableau-server:beta

clean:
	docker ps -aq --no-trunc | xargs docker rm

exec:
	docker exec -ti `docker ps | grep tableau-server:beta |head -1 | awk -e '{print $$1}'` /bin/bash


config/registration_file.json: 
	cp config/registration_file.json.templ config/registration_file.json
	$(EDITOR) config/registration_file.json

regconfig: config/registration_file.json

stop:
	docker stop `docker ps | grep tableau-server:beta |head -1| awk -e '{print $$1}'`

