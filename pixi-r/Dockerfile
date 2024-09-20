FROM ghcr.io/prefix-dev/pixi:bullseye

# Copy the pixi.toml file
COPY pixi.toml .

# Install dependencies using pixi
RUN pixi install

# Generate the shell hook script
RUN pixi shell-hook > /shell-hook.sh

# Ensure the shell hook script is sourced in the profile
RUN echo 'source /shell-hook.sh' >> /etc/profile

# Install locales package and generate the en_US.UTF-8 locale
RUN apt-get update && apt-get install -y locales && \
    locale-gen en_US.UTF-8 && \
    echo "LANG=en_US.UTF-8" > /etc/default/locale && \
    echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale

# Set locale environment variables
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Copy and run the verify-locale script
COPY verify-locale.sh /usr/local/bin/verify-locale.sh
RUN chmod +x /usr/local/bin/verify-locale.sh && /usr/local/bin/verify-locale.sh

# Set the entrypoint to bash
ENTRYPOINT ["/bin/bash"]