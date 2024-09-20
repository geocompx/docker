FROM ghcr.io/prefix-dev/pixi:bullseye
COPY pixi.toml .
RUN pixi install global
RUN pixi shell-hook > /shell-hook.sh
RUN echo 'exec "$@"' >> /shell-hook.sh
# Source shell hook from profile:
RUN echo 'source /shell-hook.sh' >> /etc/profile && \
    echo 'source /shell-hook.sh' >> /etc/bash.bashrc && \
    echo 'source /shell-hook.sh' >> /etc/zsh/zshrc
# RUN pixi run R -e 'remotes::install_github("geocompx/geocompkg", dependencies = TRUE, upgrade = FALSE)'
ENTRYPOINT ["/bin/bash"]
