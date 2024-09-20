FROM ghcr.io/geocompkg/docker:pixi-r

# Copy the pixi.toml file
# COPY pixi.toml .

# Install dependencies using pixi
RUN pixi global install global geopandas xarray matplotlib folium rasterio
# RUN pixi run R -e 'remotes::install_github("geocompx/geocompkg", dependencies = TRUE, upgrade = FALSE)'

RUN ln -s /root/.pixi/bin/* /usr/local/bin