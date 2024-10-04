FROM geocompr/geocompr:suggests
RUN su rstudio && \
    cd /home/rstudio && \
    wget https://github.com/geocompx/geocompr/archive/main.zip && \
    unzip main.zip && \
    mv geocompr-main /home/rstudio/geocompr && \
    rm main.zip
RUN Rscript -e 'bookdown::render_book("/home/rstudio/geocompr", output_format = "bookdown::gitbook", clean = FALSE)'
RUN chown -R rstudio:rstudio /home/rstudio && \
    find /home/rstudio -type d -exec chmod 755 {} \; && \
    find /home/rstudio -type f -exec chmod 644 {} \;
USER rstudio
WORKDIR /home/rstudio/geocompr
