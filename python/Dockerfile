FROM geocompr/geocompr

# note: tried using the rocker way:
# RUN /rocker_scripts/install_python.sh

RUN wget https://github.com/rocker-org/rocker-versioned2/raw/master/scripts/install_python.sh
RUN bash install_python.sh
RUN pip3 install geopandas rasterio rioxarray jupyter matplotlib netcdf4 h5netcdf 
RUN install2.r --skipinstalled --error reticulate
RUN Rscript -e "library(reticulate); import('geopandas')" # test pkg installed and loads
