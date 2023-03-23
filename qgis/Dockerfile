FROM geocompr/geocompr
ENV DEBIAN_FRONTEND noninteractive
# source: https://qgis.org/en/site/forusers/alldownloads.html#debian-ubuntu
RUN apt update
RUN apt -y install software-properties-common
RUN apt -y install qgis qgis-plugin-grass saga
# run QGIS in a headless state
ENV QT_QPA_PLATFORM=offscreen
# # enable GRASS provider (Commented out because causing issues):
# RUN qgis_process plugins enable grassprovider
# # enable SAGA provider
# RUN qgis_process plugins enable sagaprovider
# # install R package qgisprocess from Github (paused due to API limits)
RUN R -e "remotes::install_github('r-spatial/qgisprocess')"
