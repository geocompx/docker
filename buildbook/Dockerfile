FROM ghcr.io/geocompx/suggests
RUN su rstudio && \
    cd /home/rstudio && \
    wget https://github.com/geocompx/geocompr/archive/main.zip && \
    unzip main.zip && \
    mv geocompr-main /home/rstudio/geocompr && \
    find /home/rstudio/geocompr -type f \( -name "*.Rmd" -o -name "*.R" -o -name "*.qmd" -o -name "*.md" \) \
      -exec sed -i \
        -e 's#https://zenodo.org/record/5774954/files/#https://download.osgeo.org/geotiff/samples/usgs/#g' \
        -e 's#https://zenodo.org/records/5774954/files/#https://download.osgeo.org/geotiff/samples/usgs/#g' \
        -e 's#clm_snow.prob_esacci.dec_p.90_500m_s0..0cm_2000..2012_v2.0.tif#o41078a5.tif#g' \
        -e 's#clm_snow.cover_esa.modis_p05_1km_s0..0cm_2000.03_epsg4326_v1.tif#o41078a5.tif#g' {} + && \
    rm main.zip
RUN Rscript -e 'bookdown::render_book("/home/rstudio/geocompr", output_format = "bookdown::gitbook", clean = FALSE)'
RUN chown -R rstudio:rstudio /home/rstudio && \
    find /home/rstudio -type d -exec chmod 755 {} \; && \
    find /home/rstudio -type f -exec chmod 644 {} \;
USER rstudio
WORKDIR /home/rstudio/geocompr
