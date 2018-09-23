#!/bin/bash

# Exit on first error
set -e

LOGFILE=/var/log/tableau_docker.log
RETAIN_NUM_LINES=10000

function logsetup {
    TMP=$(tail -n $RETAIN_NUM_LINES $LOGFILE 2>/dev/null) && echo "${TMP}" > $LOGFILE
    exec > >(tee -a $LOGFILE)
    exec 2>&1
}

function log {
    echo "[$(date --rfc-3339=seconds)]: $*"
}

logsetup

if [ -f /opt/tableau/docker_build/.init-done ]; then

    log tsm already initialized

else

    log start initialize tsm
    su tsm -c "sudo sh -x /opt/tableau/tableau_server/packages/scripts.*/initialize-tsm -f --accepteula" 2>&1 1> /var/log/tableau_docker.log
    log initialize done

    source /etc/profile.d/tableau_server.sh

    log login tsm
    su tsm -c "sudo /opt/tableau/tableau_server/packages/customer-bin.${TABLEAU_SERVER_DATA_DIR_VERSION}/tsm login --username tsm --password tsm" 2>&1 1>> /var/log/tableau_docker.log
    log login tsm done

    log licenses activate
    su tsm -c "sudo /opt/tableau/tableau_server/packages/customer-bin.${TABLEAU_SERVER_DATA_DIR_VERSION}/tsm licenses activate -t" 2>&1 1>> /var/log/tableau_docker.log
    log licenses activate done

    log register
    su tsm -c "sudo /opt/tableau/tableau_server/packages/customer-bin.${TABLEAU_SERVER_DATA_DIR_VERSION}/tsm register --file /opt/tableau/docker_build/registration_file.json" 2>&1 1>> /var/log/tableau_docker.log
    log register done

    log settings import
    su tsm -c "sudo /opt/tableau/tableau_server/packages/customer-bin.${TABLEAU_SERVER_DATA_DIR_VERSION}/tsm settings import -f /opt/tableau/docker_build/tableau_config.json" 2>&1 1>> /var/log/tableau_docker.log
    log settings import done

    log pending-changes apply
    su tsm -c "sudo /opt/tableau/tableau_server/packages/customer-bin.${TABLEAU_SERVER_DATA_DIR_VERSION}/tsm pending-changes apply" 2>&1 1>> /var/log/tableau_docker.log
    log pending-changes apply done

    log initialize server
    su tsm -c "sudo /opt/tableau/tableau_server/packages/customer-bin.${TABLEAU_SERVER_DATA_DIR_VERSION}/tsm initialize --start-server --request-timeout 1800" 2>&1 1>> /var/log/tableau_docker.log
    log initialize server done

    log initialuser
    su tsm -c "sudo /opt/tableau/tableau_server/packages/bin.${TABLEAU_SERVER_DATA_DIR_VERSION}/tabcmd initialuser --server localhost:80 --username admin --password admin" 2>&1 1>> /var/log/tableau_docker.log
    log all done

    touch /opt/tableau/docker_build/.init-done

fi

