# taken from: https://github.com/rocker-org/rocker/blob/master/r-ubuntu/Dockerfile
FROM rocker/r-ubuntu:20.04

# r-cran-docopt is not currently in c2d4u so we install from source
RUN apt-get update \
        && apt-get install -y --no-install-recommends \
 		 libfontconfig1-dev \
 		 libudunits2-dev libgdal-dev libgeos-dev libproj-dev \
 		 r-cran-sf r-cran-raster r-cran-rjava \
		 r-cran-mapdeck \
  	&& ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r \
 	&& ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r \
 	&& ln -s /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
 	&& ln -s /usr/lib/R/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
 	&& install.r docopt \
 	&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
 	&& rm -rf /var/lib/apt/lists/*

RUN install2.r --error \
    tmap    

CMD ["bash"]
