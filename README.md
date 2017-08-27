# tableau-server-beta-docker
Dockerfile for Tableau Server on Linux - Single Node. 

## Build

To build first add your Tableau Beta site password to the `TABLEAU_DL_PASS` environment variable.

    export TABLEAU_DL_PASS=<password>
    
Then simply call `make`:

    make
    
## Run image

    docker run -ti tfoldi/tableau-server-beta
    
    
    
## Author

These ten lines of code done by me, [@tfoldi](https://twitter.com/tfoldi)
    

