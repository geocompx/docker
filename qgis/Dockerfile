FROM rocker/geospatial:dev-osgeo
# ARG only sets the ENV var during the build session whereas ENV also keeps it in the containers later on
ARG DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y --with-new-pkgs upgrade
# # how to install LTR, latest or nightly QGIS version, see:
# # https://qgis.org/en/site/forusers/alldownloads.html#debian-ubuntu
# RUN apt-get -y install gnupg software-properties-common python3-pip
# RUN wget -O /etc/apt/keyrings/qgis-archive-keyring.gpg https://download.qgis.org/downloads/qgis-archive-keyring.gpg
# # here, we install the QGIS-LTR, if you like the latest one, change in URIs from ubuntugis-ltr to ubuntugis
# SHELL ["/bin/bash", "-c"]
# RUN echo 'Types: deb deb-src' > /etc/apt/sources.list.d/qgis.sources
# RUN echo 'URIs: https://qgis.org/ubuntugis' >> /etc/apt/sources.list.d/qgis.sources
# RUN echo 'Suites: jammy' >> /etc/apt/sources.list.d/qgis.sources
# RUN echo 'Architectures: amd64' >> /etc/apt/sources.list.d/qgis.sources
# RUN echo 'Components: main' >> /etc/apt/sources.list.d/qgis.sources
# RUN echo 'Signed-By: /etc/apt/keyrings/qgis-archive-keyring.gpg' >> /etc/apt/sources.list.d/qgis.sources
# RUN apt-get update
# here using apt-get leads 10 packages kept back which in turn prevents the successful installation of qgis, ok, use --with-new-pkgs!
# RUN apt-get -y --with-new-pkgs upgrade && \
#   apt-get -y autoremove && \
#   apt-get -y install qgis qgis-plugin-grass saga

# for how to use the qgis-plugin-manager, see https://github.com/3liz/qgis-plugin-manager
# RUN apt install pip3
# RUN pip3 install qgis-plugin-manager
# to enable the qgis-plugin-manager, add the corresponding path to PATH
ENV PATH="/home/rstudio/.local/bin:$PATH"
# from the next line onwards we have trouble with the rstudio server, therefore we switch to the rstudio user
USER rstudio
RUN mkdir -p /home/rstudio/.local/share/QGIS/QGIS3/profiles/default/python/plugins
ENV QGIS_PLUGINPATH=/home/rstudio/.local/share/QGIS/QGIS3/profiles/default/python/plugins

# install QGIS plugins ################################################################################################
# Using qgisprocess workflow:
# See https://github.com/r-spatial/qgisprocess/blob/main/.github/workflows/R-CMD-check.yaml#L64
# RUN echo "QGIS_PLUGINPATH=$(pwd)/extra_plugins" >> $GITHUB_ENV
# This bit, with user as root, failed in Docker image, changing to rstudio:
USER root
RUN mkdir -p /root/.gnupg
RUN chmod 700 /root/.gnupg
# Version that works in image:
RUN gpg --no-default-keyring --keyring /etc/apt/keyrings/ubuntugis-unstable-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 6B827C12C2D425E227EDCA75089EBE08314DF160
RUN sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/ubuntugis-unstable-archive-keyring.gpg] http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu `lsb_release -c -s` main" > /etc/apt/sources.list.d/ubuntugis-unstable.list'
RUN wget -qO /etc/apt/keyrings/qgis-archive-keyring.gpg https://download.qgis.org/downloads/qgis-archive-keyring.gpg
RUN sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/qgis-archive-keyring.gpg] https://qgis.org/ubuntugis-nightly-release `lsb_release -c -s` main" > /etc/apt/sources.list.d/qgis.list'
RUN apt-get update
RUN apt-get install -y qgis qgis-plugin-grass saga
RUN wget -qO sagang_plugin.zip https://plugins.qgis.org/plugins/processing_saga_nextgen/version/0.0.7/download/
RUN unzip -q sagang_plugin.zip -d /home/rstudio/.local/share/QGIS/QGIS3/profiles/default/python/plugins

# Outdated: install SAGA next generation plugin with the qgis-plugin-manager ###########################################
# RUN qgis-plugin-manager init
# RUN qgis-plugin-manager update
# install SAGA next generation plugin
# RUN qgis-plugin-manager install 'Processing Saga NextGen Provider'

# the rest is nice to have but not really necessary
# RUN qgis_process in a headless state
# ENV QT_QPA_PLATFORM=offscreen

# enable desired plugins
# RUN qgis_process plugins enable processing_saga_nextgen
# RUN qgis_process plugins enable grassprovider
USER root

# install R packages ##################################################################################################
# Set the options() for R users:
RUN echo 'options(repos = "https://packagemanager.posit.co/cran/latest")' >> /usr/local/lib/R/etc/Rprofile.site
RUN Rscript -e "install.packages('remotes')" 
# RUN Rscript -e "remotes::install_github('r-spatial/sf')"
# RUN Rscript -e "remotes::install_github('rspatial/terra')" 
RUN R -e "remotes::install_github('geocompx/geocompkg', upgrade = TRUE, dependencies = TRUE)"


