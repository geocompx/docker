FROM rocker/geospatial:latest
RUN R -e "remotes::install_github('geocompr/geocompkg')"
RUN su rstudio && \
  cd /home/rstudio && \
  wget https://github.com/Robinlovelace/geocompr/archive/master.zip && \
  unzip master.zip && \
  mv geocompr-master /home/rstudio/geocompr && \
  cd geocompr && \
  make html
RUN chown -Rv rstudio /home/rstudio/geocompr 
RUN wget https://github.com/rocker-org/rocker-versioned2/archive/master.zip
# RUN unzip master.zip \
#   && cp -Rv rocker-versioned2-master/scripts /rocker_scripts
# RUN /rocker_scripts/install_rstudio.sh RSTUDIO_VERSION=preview
RUN wget https://s3.amazonaws.com/rstudio-ide-build/server/bionic/amd64/rstudio-server-1.3.1054-amd64.deb 
RUN dpkg -i rstudio-server-*-amd64.deb
RUN rm rstudio-server-*-amd64.deb
RUN echo '{' >> /etc/rstudio/rstudio-prefs.json
RUN echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json
RUN echo '}' >> /etc/rstudio/rstudio-prefs.json

