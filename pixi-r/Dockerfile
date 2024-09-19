FROM ghcr.io/prefix-dev/pixi:bullseye
# pixi.toml .
# RUN pixi global install quarto r-base r-tidyverse r-tmap r-pak julia
COPY pixi.toml .
RUN pixi install
RUN pixi shell-hook > /shell-hook.sh
RUN echo 'exec "$@"' >> /shell-hook.sh
# RUN pixi install 
# RUN pixi shell -y
ENTRYPOINT ["/bin/bash", "/shell-hook.sh"]