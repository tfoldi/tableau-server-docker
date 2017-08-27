
all:
		docker build --build-arg=tableau_dl_pass=nessie .

clean:
		docker ps -aq --no-trunc | xargs docker rm
