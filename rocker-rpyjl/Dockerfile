FROM ghcr.io/geocompx/rocker-rpy
RUN /rocker_scripts/install_julia.sh
RUN R -e "install.packages('JuliaCall')"
RUN julia -e 'using Pkg; Pkg.add(["GeoDataFrames", "Shapefile", "GeoJSON", "GeoParquet", "LibGEOS", "ArchGDAL", "GeometryOps", "GeoInterface", "Rasters", "NCDatasets", "ZarrDatasets", "GRIBDatasets"])'
