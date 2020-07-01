FROM rocker/geospatial:latest
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		software-properties-common \
		vim \
		wget \
		ca-certificates \
	&& add-apt-repository --enable-source --yes "ppa:ubuntugis/ubuntugis-unstable" 
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
 	  libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev
# other options (illustrative)
# RUN apt-get update && \
# set repos to CRAN to allow package updates
#   echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site 
RUN R -e "install.packages(c('sf', 'lwgeom', 'rgdal', 'sp', 'stars'))"
RUN R -e "remotes::install_github('geocompr/geocompkg')"
RUN su rstudio && \
  cd /home/rstudio && \
  wget https://github.com/Robinlovelace/geocompr/archive/master.zip && \
  unzip master.zip && \
  mv geocompr-master /home/rstudio/geocompr && \
  cd geocompr && \
  make html
RUN chown -Rv rstudio /home/rstudio/geocompr 
# other options (illustrative)
# RUN apt-get update && \
# set repos to CRAN to allow package updates
#   echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site 
