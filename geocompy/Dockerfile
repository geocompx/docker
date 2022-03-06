FROM rocker/geospatial:dev-osgeo

# note: tried using the rocker way:
# RUN /rocker_scripts/install_python.sh

RUN wget https://github.com/rocker-org/rocker-versioned2/raw/master/scripts/install_python.sh
RUN bash install_python.sh
# Install Python packages for vector data:
RUN pip3 install geopandas movingpandas 
# Install Python packages for raster data:
RUN pip3 install rasterio rioxarray netcdf4 h5netcdf
# Install Python packages for visualisation
RUN pip3 install jupyter matplotlib hvplot geoviews
# Install quarto
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
RUN apt update
RUN apt install gh
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v0.9.56/quarto-0.9.56-linux-amd64.deb
RUN dpkg -i quarto*
RUN quarto --version
# Install pip is that needed? seems to duplicate pip commands above (RL 2022-03)
RUN /usr/bin/python3 -m pip install --upgrade pip
RUN python3 -m pip install jupyter matplotlib
# RUN quarto render
# RUN ls docs
RUN install2.r --skipinstalled --error reticulate quarto
RUN Rscript -e "library(reticulate); import('geopandas')" # test pkg installed and loads
