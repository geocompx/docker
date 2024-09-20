FROM ghcr.io/prefix-dev/pixi:bullseye
COPY pixi.toml .
RUN pixi install
RUN pixi shell-hook > /shell-hook.sh
RUN echo 'exec "$@"' >> /shell-hook.sh
# RUN pixi run R -e 'remotes::install_github("geocompx/geocompkg", dependencies = TRUE, upgrade = FALSE)'
ENTRYPOINT ["/bin/bash", "/shell-hook.sh"]
