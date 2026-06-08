FROM ghcr.io/geocompx/rocker-rpy
RUN /rocker_scripts/install_julia.sh
RUN R -e "install.packages('JuliaCall')"
RUN julia -e 'using Pkg; Pkg.add(["GeoInterface", "GeoFormatTypes", "Extents", "GeometryOps", "LibGEOS", "ArchGDAL", "GeoDataFrames", "Shapefile", "GeoJSON", "GeoParquet", "Rasters", "NCDatasets", "ZarrDatasets", "GRIBDatasets", "DataFrames", "CSV", "Plots", "Makie", "CairoMakie"])'
