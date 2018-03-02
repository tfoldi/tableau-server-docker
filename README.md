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


<p><script type="text/javascript" src="https://asciinema.org/a/oJ7tTN0URdtF9UqpCRRGJzKvT.js" id="asciicast-oJ7tTN0URdtF9UqpCRRGJzKvT" async="" data-player="[object HTMLDivElement]"></script><div id="asciicast-container-oJ7tTN0URdtF9UqpCRRGJzKvT" class="asciicast" style="display: block; float: none; overflow: hidden; padding: 0px; margin: 20px 0px;"><iframe src="https://asciinema.org/a/oJ7tTN0URdtF9UqpCRRGJzKvT/embed?" id="asciicast-iframe-oJ7tTN0URdtF9UqpCRRGJzKvT" name="asciicast-iframe-oJ7tTN0URdtF9UqpCRRGJzKvT" scrolling="no" allowfullscreen="true" style="overflow: hidden; margin: 0px; border: 0px; display: inline-block; width: 590px; float: none; visibility: visible; height: 419px;"></iframe></div></p>
    

