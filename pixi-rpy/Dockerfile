FROM ghcr.io/geocompx/docker:pixi-r
# Todo: Find a way to auto-generate this from environment.yml/requirements.txt:
RUN pixi global install python xarray matplotlib folium rasterio r-reticulate 
RUN ln -sf /root/.pixi/bin/* /usr/local/bin