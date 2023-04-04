FROM ghcr.io/geocompx/docker:latest
# ARG only sets the ENV var during the build session whereas ENV also keeps it in the containers later on
ARG DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y --with-new-pkgs upgrade
# how to install LTR, latest or nightly QGIS version, see:
# https://qgis.org/en/site/forusers/alldownloads.html#debian-ubuntu
RUN apt-get -y install gnupg software-properties-common python3-pip
RUN add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable
RUN wget -O /etc/apt/keyrings/qgis-archive-keyring.gpg https://download.qgis.org/downloads/qgis-archive-keyring.gpg
# here, we install the QGIS-LTR, if you like the latest one, change in URIs from ubuntugis-ltr to ubuntugis
SHELL ["/bin/bash", "-c"]
RUN echo $'Types: deb deb-src \n\
URIs: https://qgis.org/ubuntugis-ltr\n\
Suites: jammy\n\
Architectures: amd64\n\
Components: main\n\
Signed-By: /etc/apt/keyrings/qgis-archive-keyring.gpg' >/etc/apt/sources.list.d/qgis.sources
RUN apt-get update
# here using apt-get leads 10 packages kept back which in turn prevents the successful installation of qgis, ok, use --with-new-pkgs!
RUN apt-get -y --with-new-pkgs upgrade && \
  apt-get -y autoremove && \
  apt-get -y install qgis qgis-plugin-grass saga

# for how to use the qgis-plugin-manager, see https://github.com/3liz/qgis-plugin-manager
RUN pip3 install qgis-plugin-manager
# to enable the qgis-plugin-manager, add the corresponding path to PATH
ENV PATH="/home/rstudio/.local/bin:$PATH"
RUN mkdir -p /home/rstudio/.local/share/QGIS/QGIS3/profiles/default/python/plugins
ENV QGIS_PLUGINPATH=/home/rstudio/.local/share/QGIS/QGIS3/profiles/default/python/plugins
RUN qgis-plugin-manager init
RUN qgis-plugin-manager update
# install SAGA next generation plugin
RUN qgis-plugin-manager install 'Processing Saga NextGen Provider'
# RUN qgis_process in a headless state
ENV QT_QPA_PLATFORM=offscreen
# enable desired plugins
RUN qgis_process plugins enable processing_saga_nextgen
RUN qgis_process plugins enable grassprovider

# install R package qgisprocess from Github (paused due to API limits)
# when running the next line RStudio server can no longer connect to the R session
# and in any case, we do not really have to install the package here
# RUN Rscript -e "remotes::install_github('r-spatial/qgisprocess')"
