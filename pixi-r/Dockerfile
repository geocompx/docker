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
