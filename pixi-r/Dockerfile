FROM ghcr.io/prefix-dev/pixi:bullseye

# Copy the pixi.toml file
COPY pixi.toml .

# Install dependencies using pixi
RUN pixi install

# Generate the shell hook script
RUN pixi shell-hook > /shell-hook.sh
RUN echo 'exec "$@"' >> /shell-hook.sh

# Ensure the shell hook script is sourced in the profile
RUN echo 'source /shell-hook.sh' >> /etc/profile
# And to root profile:
RUN echo 'source /shell-hook.sh' >> /root/.bashrc

# Install locales package and generate the en_US.UTF-8 locale
RUN apt-get update && apt-get install -y locales && \
    locale-gen en_US.UTF-8 && \
    echo "LANG=en_US.UTF-8" > /etc/default/locale && \
    echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale
# RUN pixi run R -e 'remotes::install_github("geocompx/geocompkg", dependencies = TRUE, upgrade = FALSE)'

# Set the entrypoint to bash
# ENTRYPOINT ["/bin/bash", "/shell-hook.sh"]