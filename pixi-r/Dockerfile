FROM ghcr.io/prefix-dev/pixi:bullseye
# pixi.toml .
# RUN pixi global install quarto r-base r-tidyverse r-tmap r-pak julia
# Install libcurl4-openssl-dev
RUN apt-get update && apt-get install -y libcurl4-openssl-dev
COPY pixi.toml .
RUN pixi install
# Install github pkgs
RUN pixi shell-hook > /shell-hook.sh
RUN echo 'exec "$@"' >> /shell-hook.sh
# RUN pixi install 
# RUN pixi shell -y
RUN pixi run R -e 'remotes::install_github("geocompx/geocompkg", dependencies = TRUE, upgrade = FALSE)'
# RUN pixi run R -e 'pak::pkg_install("curl", dependencies = TRUE)'
ENTRYPOINT ["/bin/bash", "/shell-hook.sh"]
