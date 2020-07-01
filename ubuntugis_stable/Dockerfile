FROM rocker/geospatial:latest
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	&& add-apt-repository --enable-source --yes "ppa:ubuntugis/ppa"
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
 	  libudunits2-dev libgdal-dev libgeos-dev libproj-dev liblwgeom-dev
# install the r-spatial stack linking to new OSGeo pkgs
RUN R -e "install.packages(c('sf', 'lwgeom', 'rgdal', 'sp', 'stars'))"
RUN R -e "remotes::install_github('geocompr/geocompkg')"
# other options (illustrative)
# RUN apt-get update && \
# set repos to CRAN to allow package updates
#   echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site 
