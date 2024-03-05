FROM rocker/geospatial:dev-osgeo
# install the r-spatial stack linking to new OSGeo pkgs
RUN R -e "remotes::install_github('geocompr/geocompkg', upgrade = TRUE, force = TRUE)"
RUN su rstudio && \
  cd /home/rstudio && \
  wget https://github.com/geocompx/geocompr/archive/main.zip && \
  unzip main.zip && \
  mv geocompr-main /home/rstudio/geocompr && \
  cd geocompr && \
  make html
RUN chown -Rv rstudio /home/rstudio/geocompr 
