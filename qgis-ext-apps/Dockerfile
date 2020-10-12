FROM geocompr/geocompr:qgis

# run the subsequent line if you are behind a proxy (usually the case when inside OC)
RUN echo 'Acquire::http::Proxy "http://dcea-ifwebgw01.gfk.com:3128";' >> /etc/apt/apt.conf
RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests --allow-unauthenticated -y \
    qgis-plugin-grass \
    saga
ENV QT_QPA_PLATFORM='offscreen'
RUN qgis_process && \
    echo "[PythonPlugins]\nprocessing=true" >> ~/.local/share/QGIS/QGIS3/profiles/default/QGIS/QGIS3.ini
# and now do the same for the rstudio user
USER rstudio
ENV QT_QPA_PLATFORM='offscreen' 
RUN qgis_process &&\
    RUN echo "[PythonPlugins]\nprocessing=true" >> ~/.local/share/QGIS/QGIS3/profiles/default/QGIS/QGIS3.ini
WORKDIR /home/rstudio/geocompr
USER root
# RUN R -e "remotes::install_github('paleolimbot/qgisprocess')"
