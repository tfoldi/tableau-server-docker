#!/bin/sh

# Exit on first error:w
set -e

touch /opt/tableau/docker_build/.start

su tsm -c "sudo sh -x /opt/tableau/tableau_server/packages/scripts.*/initialize-tsm --accepteula" 2>&1 1> /var/log/tableau_docker.log
touch /opt/tableau/docker_build/.init-done

source /etc/profile.d/tableau_server.sh

su tsm -c "sudo /opt/tableau/tableau_server/packages/customer-bin.${TABLEAU_SERVER_DATA_DIR_VERSION}/tsm login --username tsm --password tsm" 2>&1 1>> /var/log/tableau_docker.log
touch /opt/tableau/docker_build/.activate-done

su tsm -c "sudo /opt/tableau/tableau_server/packages/customer-bin.${TABLEAU_SERVER_DATA_DIR_VERSION}/tsm licenses activate -t" 2>&1 1>> /var/log/tableau_docker.log
touch /opt/tableau/docker_build/.activate-done

su tsm -c "sudo /opt/tableau/tableau_server/packages/customer-bin.${TABLEAU_SERVER_DATA_DIR_VERSION}/tsm register --file /opt/tableau/docker_build/registration_file.json" 2>&1 1>> /var/log/tableau_docker.log
touch /opt/tableau/docker_build/.registration-done

su tsm -c "sudo /opt/tableau/tableau_server/packages/customer-bin.${TABLEAU_SERVER_DATA_DIR_VERSION}/tsm settings import -f /opt/tableau/docker_build/tableau_config.json" 2>&1 1>> /var/log/tableau_docker.log
touch /opt/tableau/docker_build/.settings-import-done

su tsm -c "sudo /opt/tableau/tableau_server/packages/customer-bin.${TABLEAU_SERVER_DATA_DIR_VERSION}/tsm pending-changes apply" 2>&1 1>> /var/log/tableau_docker.log
touch /opt/tableau/docker_build/.apply-changes-done

su tsm -c "sudo /opt/tableau/tableau_server/packages/customer-bin.${TABLEAU_SERVER_DATA_DIR_VERSION}/tsm initialize --start-server --request-timeout 1800" 2>&1 1>> /var/log/tableau_docker.log
touch /opt/tableau/docker_build/.start-server-done

su tsm -c "sudo tabcmd initialuser --server localhost:80 --username admin --password admin" 2>&1 1>> /var/log/tableau_docker.log
touch /opt/tableau/docker_build/.add-user-done


touch /opt/tableau/docker_build/.init-done

