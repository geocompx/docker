FROM ghcr.io/prefix-dev/pixi:bullseye
COPY pixi.toml .
RUN pixi install
RUN pixi shell-hook > /shell-hook.sh
RUN echo 'exec "$@"' >> /shell-hook.sh
# Source shell hook from profile:
RUN echo 'source /shell-hook.sh' >> /etc/profile

# Set locale environment variables to avoid warnings
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# RUN pixi run R -e 'remotes::install_github("geocompx/geocompkg", dependencies = TRUE, upgrade = FALSE)'
ENTRYPOINT ["/bin/bash"]

