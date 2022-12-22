FROM geocompr/geocompr
ENV DEBIAN_FRONTEND noninteractive
# source: https://qgis.org/en/site/forusers/alldownloads.html#debian-ubuntu
RUN apt update
RUN apt -y install software-properties-common
# Source: https://www.qgis.org/en/site/forusers/alldownloads.html
RUN mkdir -m755 -p /etc/apt/keyrings  # not needed since apt version 2.4.0 like Debian 12 and Ubuntu 22 or newer
RUN wget -O /etc/apt/keyrings/qgis-archive-keyring.gpg https://download.qgis.org/downloads/qgis-archive-keyring.gpg
RUN add-apt-repository "deb https://qgis.org/ubuntu-nightly $(lsb_release -c -s) main"
RUN # Update your repository information to reflect also the just added QGIS one:
RUN apt update
RUN # Now, install QGIS:
RUN apt -y install qgis qgis-plugin-grass
RUN R -e "remotes::install_github('paleolimbot/qgisprocess')"