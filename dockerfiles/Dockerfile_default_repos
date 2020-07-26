FROM rocker/geospatial:latest
# install the r-spatial stack linking to new OSGeo pkgs
RUN R -e "install.packages(c('sf', 'lwgeom', 'rgdal', 'sp', 'stars'))"
RUN R -e "remotes::install_github('geocompr/geocompkg')"
RUN su rstudio && \
  cd /home/rstudio && \
  wget https://github.com/Robinlovelace/geocompr/archive/master.zip && \
  unzip master.zip && \
  mv geocompr-master /home/rstudio/geocompr && \
RUN chown -Rv rstudio /home/rstudio/geocompr 
