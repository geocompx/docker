FROM rocker/binder:3.6.0
RUN R -e "remotes::install_github('geocompr/geocompkg')"
RUN su rstudio && \
  cd /home/rstudio && \
  wget https://github.com/Robinlovelace/geocompr/archive/master.zip && \
  unzip master.zip && \
  mv geocompr-master /home/rstudio/geocompr
RUN chown -Rv rstudio /home/rstudio/geocompr
