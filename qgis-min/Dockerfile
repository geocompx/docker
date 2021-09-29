FROM geocompr/geocompr
ENV DEBIAN_FRONTEND noninteractive
# source: https://qgis.org/en/site/forusers/alldownloads.html#debian-ubuntu
RUN apt update
RUN apt -y install software-properties-common
RUN wget -qO - https://qgis.org/downloads/qgis-2021.gpg.key | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/qgis-archive.gpg --import
RUN chmod a+r /etc/apt/trusted.gpg.d/qgis-archive.gpg
RUN add-apt-repository "deb https://qgis.org/ubuntu $(lsb_release -c -s) main"
RUN # Update your repository information to reflect also the just added QGIS one:
RUN apt update
RUN # Now, install QGIS:
RUN apt -y install qgis qgis-plugin-grass