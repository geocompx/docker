FROM rocker/geospatial:4.0.0-ubuntu18.04-unstable
# install the r-spatial stack linking to new OSGeo pkgs
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		software-properties-common \
		vim \
		wget \
		ca-certificates \
  && add-apt-repository --enable-source --yes "ppa:ubuntugis/ubuntugis-unstable" 
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
 	  libudunits2-dev libgdal-dev libgeos-dev libproj-dev liblwgeom-dev
# install the r-spatial stack linking to new OSGeo pkgs
RUN R -e "install.packages(c('sf', 'lwgeom', 'rgdal', 'sp', 'stars', 'raster'))"
RUN R -e "remotes::install_github('geocompr/geocompkg', upgrade = TRUE)"
RUN su rstudio && \
  cd /home/rstudio && \
  wget https://github.com/Robinlovelace/geocompr/archive/main.zip && \
  unzip main.zip && \
  mv geocompr-main /home/rstudio/geocompr && \
  cd geocompr && \
  make html
RUN chown -Rv rstudio /home/rstudio/geocompr 
