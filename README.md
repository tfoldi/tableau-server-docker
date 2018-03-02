# tableau-server-beta-docker
Dockerfile for Tableau Server on Linux - Single Node. 

## Build
   
Be sure that your `EDITOR` environment variable is set then simply call `make`:

    make
    
## Run image

To boot (run) Tableau Server container simply execute:

    make run

It will call a `systemd` `/sbin/init` on the image and configure, register and start tableau server
on the first start.

To connect from a different terminal to the server itself use

    make exec
    
Pro tipp: If you commit the image state after the first execution (tableau configuration and registration) you don't
have to wait minutes next time.
    
## Author

These ten lines of code done by me, [@tfoldi](https://twitter.com/tfoldi)


## Install Demo
[Console Video](https://asciinema.org/a/oJ7tTN0URdtF9UqpCRRGJzKvT/embed?)
    
## Blog from tfoldi
[Blog](https://databoss.starschema.net/tableau-server-linux-docker-container/)
