FROM ghcr.io/prefix-dev/pixi:bullseye

# Copy the pixi.toml file
COPY pixi.toml .

# Install dependencies using pixi
RUN pixi install

# Generate the shell hook script
RUN pixi shell-hook > /shell-hook.sh
# extend the shell-hook script to run the command passed to the container
RUN echo 'exec "$@"' >> /shell-hook.sh

# Ensure the shell hook script is sourced in the profile
RUN echo 'source /shell-hook.sh' >> /etc/profile
# And root user's bashrc:
RUN echo 'source /shell-hook.sh' >> /root/.bashrc

# Install locales package and generate the en_US.UTF-8 locale
RUN apt-get update && apt-get install -y locales && \
    locale-gen en_US.UTF-8

# # Set locale environment variables
# ENV LANG=en_US.UTF-8
# ENV LANGUAGE=en_US:en
# ENV LC_ALL=en_US.UTF-8

# # Verify locale settings
# RUN locale && \
#     echo "LANG=$LANG" && \
#     echo "LANGUAGE=$LANGUAGE" && \
#     echo "LC_ALL=$LC_ALL"

# Set the entrypoint to bash
ENTRYPOINT ["/bin/bash"]