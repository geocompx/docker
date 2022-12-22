FROM geocompr/geocompr:suggests
RUN su rstudio && \
  cd /home/rstudio/geocompr && \
  Rscript -e 'install.packages("metathis")' \
  Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::gitbook", clean = FALSE)'

