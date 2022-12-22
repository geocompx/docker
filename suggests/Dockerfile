FROM geocompr/geocompr:latest
# RUN --mount=type=secret,id=GITHUB_PAT \
#   echo "GITHUB_PAT=$(cat /run/secrets/GITHUB_PAT)" > ~/.Renviron
# RUN R -e "remotes::install_github('geocompr/geocompkg', upgrade = TRUE, dependencies = TRUE, force = TRUE)"
RUN R -e "options(repos = c(geocompr = 'https://geocompr.r-universe.dev', CRAN = 'https://cloud.r-project.org')); install.packages('geocompkg', dependencies = TRUE)"
RUN su rstudio && \
  cd /home/rstudio && \
  wget https://github.com/Robinlovelace/geocompr/archive/main.zip && \
  unzip main.zip && \
  mv geocompr-main /home/rstudio/geocompr && \
  rm main.zip
RUN chown -Rv rstudio /home/rstudio/geocompr
# Set RStudio preferences
# No inline code:
RUN echo '{' >> /etc/rstudio/rstudio-prefs.json
RUN echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json
RUN echo '}' >> /etc/rstudio/rstudio-prefs.json
