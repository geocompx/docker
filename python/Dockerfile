FROM geocompr/geocompr

# note: tried using the rocker way:
# RUN /rocker_scripts/install_python.sh

# but instead with simply installing with pip:
# https://www.robertmylesmcdonnell.com/content/posts/docker/
RUN echo "RETICULATE_PYTHON=/usr/bin/python3" >> ${R_HOME}/etc/Renviron
RUN apt-get update \
    && apt-get -y install python3 \
    && apt -y install python3-pip
RUN pip3 install geopandas movingpandas

RUN install2.r --skipinstalled --error reticulate 
