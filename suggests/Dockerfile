FROM ghcr.io/geocompx/docker:minimal
# RUN --mount=type=secret,id=GITHUB_PAT \
#   echo "GITHUB_PAT=$(cat /run/secrets/GITHUB_PAT)" > ~/.Renviron
# RUN R -e "remotes::install_github('geocompr/geocompkg', upgrade = TRUE, dependencies = TRUE, force = TRUE)"
RUN R -e "remotes::install_github('geocompx/geocompkg', upgrade = TRUE, dependencies = TRUE, force = TRUE)"
