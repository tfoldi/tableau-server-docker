
all:
		docker build --build-arg=tableau_dl_pass=${TABLEAU_DL_PASS} .

clean:
		docker ps -aq --no-trunc | xargs docker rm
