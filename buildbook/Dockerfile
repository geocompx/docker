FROM geocompr/geocompr:latest
RUN su rstudio && \
  cd /home/rstudio/geocompr && \
  Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::gitbook", clean = FALSE)'

