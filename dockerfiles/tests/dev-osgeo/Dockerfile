FROM rocker/geospatial:dev-osgeo
# install the r-spatial stack linking to new OSGeo pkgs
RUN R -e "if (!requireNamespace('pak', quietly = TRUE)) install.packages('pak', repos = 'https://cloud.r-project.org/'); pak::pak('geocompr/geocompkg', upgrade = TRUE)"
RUN su rstudio && \
  cd /home/rstudio && \
  wget https://github.com/geocompx/geocompr/archive/main.zip && \
  unzip main.zip && \
  mv geocompr-main /home/rstudio/geocompr
RUN chown -Rv rstudio /home/rstudio/geocompr 
