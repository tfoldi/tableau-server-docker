# Run `make run` to get things started

# our image is centos default image with systemd
FROM centos/systemd

# You have to specify the password for the beta site
ARG tableau_dl_pass

# who's your boss?
MAINTAINER "Tamas Foldi" <tfoldi@starschema.net>

# this is the version what we're building
ENV TABLEAU_VERSION="10.4-beta3" \
    TABLEAU_DL_USER="tableau104" \
    TABLEAU_DL_PASS=$tableau_dl_pass \
    LANG=en_US.UTF-8

# make systemd dbus visible 
VOLUME /sys/fs/cgroup /run /tmp

# Install core bits and their deps:w
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum install -y iproute curl sudo vim && \
    adduser tsm && \
    (echo tsm:tsm | chpasswd) && \
    (echo 'tsm ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/tsm) && \
    mkdir -p  /run/systemd/system /opt/tableau/docker_build && \
    yum install -y \
             "https://${TABLEAU_DL_USER}:${TABLEAU_DL_PASS}@beta.tableau.com/linux_files/tableau-server-automated-installer-${TABLEAU_VERSION}.x86_64.rpm" \
             "https://${TABLEAU_DL_USER}:${TABLEAU_DL_PASS}@beta.tableau.com/linux_files/tableau-server-${TABLEAU_VERSION}.x86_64.rpm"  \
             "https://${TABLEAU_DL_USER}:${TABLEAU_DL_PASS}@beta.tableau.com/linux_files/tableau-postgresql-odbc-9.5.3-1.x86_64.rpm"  && \
    rm -rf /var/tmp/yum-* 


COPY config/* /opt/tableau/docker_build/

RUN mkdir -p /etc/systemd/system/ && \
    cp /opt/tableau/docker_build/tableau_server_install.service /etc/systemd/system/ && \
    systemctl enable tableau_server_install

# Expose TSM and Gateway ports
EXPOSE 80 8850

CMD /sbin/init
