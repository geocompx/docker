FROM geocompr/geocompr:qgis

RUN R -e "remotes::install_github('paleolimbot/qgisprocess')"
RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests --allow-unauthenticated -y \
    qgis-plugin-grass \
    saga
# enable all available QGIS geoalgorithms for the root user
ENV QT_QPA_PLATFORM='offscreen'
RUN qgis_process && \
    echo "[PythonPlugins]\nprocessing=true" >> ~/.local/share/QGIS/QGIS3/profiles/default/QGIS/QGIS3.ini
# ... and now do the same for the rstudio user
USER rstudio
ENV QT_QPA_PLATFORM='offscreen' 
RUN qgis_process && \
    echo "[PythonPlugins]\nprocessing=true" >> ~/.local/share/QGIS/QGIS3/profiles/default/QGIS/QGIS3.ini
USER root
