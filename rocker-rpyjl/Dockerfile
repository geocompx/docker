FROM ghcr.io/geocompx/docker:rocker-rpy
RUN /rocker_scripts/install_julia.sh
# Install JulliaCall:
RUN R -e "install.packages('JuliaCall')"
RUN julia -e 'using Pkg; Pkg.add(["GeoDataFrames", "Shapefile", "GeoJSON", "GeoParquet", "LibGEOS", "ArchGDAL", "GeometryOps", "GeoInterface", "Rasters", "NCDatasets", "ZarrDatasets", "GRIBDatasets"])'
