FROM rocker/geospatial
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
 	  libudunits2-dev libgdal-dev libgeos-dev libproj-dev
# install the r-spatial stack linking to new OSGeo pkgs
RUN R -e "if (!requireNamespace('pak', quietly = TRUE)) install.packages('pak', repos = 'https://cloud.r-project.org/'); pak::pak('geocompr/geocompkg', upgrade = TRUE)"
RUN su rstudio && \
  cd /home/rstudio && \
  wget https://github.com/geocompx/geocompr/archive/main.zip && \
  unzip main.zip && \
  mv geocompr-main /home/rstudio/geocompr
RUN chown -Rv rstudio /home/rstudio/geocompr 
