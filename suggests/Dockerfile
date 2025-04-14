FROM ghcr.io/geocompx/minimal

# Define ARG for compatibility but don't use ENV to avoid storing in image
ARG GITHUB_PAT

# Use BuildKit secret mount to securely pass GitHub PAT during build
# Export the PAT as an environment variable before running R
RUN --mount=type=secret,id=GITHUB_PAT \
    export GITHUB_PAT=$(cat /run/secrets/GITHUB_PAT) && \
    R -e "remotes::install_github('geocompx/geocompkg', upgrade = TRUE, dependencies = TRUE, force = TRUE)"
