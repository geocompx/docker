FROM rocker/binder
USER root
RUN R -e "install.packages('geocompkg', upgrade = TRUE, dependencies = TRUE, force = TRUE, repos = c('https://geocompr.r-universe.dev', 'https://mlr-org.r-universe.dev', 'https://cloud.r-project.org'))"
# Install arf — Alternative R Frontend (https://github.com/eitsupi/arf)
RUN curl --proto '=https' --tlsv1.2 -LsSf https://github.com/eitsupi/arf/releases/latest/download/arf-console-installer.sh | sh
USER $NB_USER