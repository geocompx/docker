FROM ghcr.io/geocompx/minimal

# Define ARG for compatibility but don't use ENV to avoid storing in image
ARG GITHUB_PAT

# Use BuildKit secret mount to securely pass GitHub PAT during build
RUN --mount=type=secret,id=GITHUB_PAT \
    GITHUB_PAT=$(cat /run/secrets/GITHUB_PAT) \
    R -e "Sys.setenv(GITHUB_PAT=Sys.getenv('GITHUB_PAT')); remotes::install_github('geocompx/geocompkg', upgrade = TRUE, dependencies = TRUE, force = TRUE)"
