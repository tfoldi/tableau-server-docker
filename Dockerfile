# our image is cen
FROM centos:7

ARG tableau_dl_pass

# this is the version what we're building
ENV TABLEAU_VERSION="10.4-beta3" \
    TABLEAU_DL_USER="tableau104" \
    TABLEAU_DL_PASS=$tableau_dl_pass 

RUN echo  rpm -Uvh "https://${TABLEAU_DL_USER}:${TABLEAU_DL_PASS}@beta.tableau.com/linux_files/tableau-server-${TABLEAU_VERSION}.x86_64.rpm"

RUN rpm -Uvh "https://${TABLEAU_DL_USER}:${TABLEAU_DL_PASS}@beta.tableau.com/linux_files/tableau-server-automated-installer-${TABLEAU_VERSION}.x86_64.rpm" \
             "https://${TABLEAU_DL_USER}:${TABLEAU_DL_PASS}@beta.tableau.com/linux_files/tableau-server-${TABLEAU_VERSION}.x86_64.rpm" \
             "https://${TABLEAU_DL_USER}:${TABLEAU_DL_PASS}@beta.tableau.com/linux_files/tableau-postgresql-odbc-${TABLEAU_VERSION}.x86_64.rpm" \
             touch /opt/tableau-server-${TABLEAU_VERSION}.x86_64.rpm # We need to pass a valid existing file to installer, even if the package is installed


# Expose TSM and Gateway ports
EXPOSE 80 8850

CMD /bin/bash
