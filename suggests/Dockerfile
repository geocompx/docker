FROM ghcr.io/geocompx/minimal
RUN --mount=type=secret,id=GITHUB_PAT R -e "remotes::install_github('geocompx/geocompkg', auth_token = readLines('/run/secrets/GITHUB_PAT'), upgrade = TRUE, dependencies = TRUE, force = TRUE)"
