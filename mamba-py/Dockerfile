FROM mambaorg/micromamba:bookworm
USER root
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
USER $MAMBA_USER
RUN curl -L -o environment.yml https://github.com/geocompx/geocompy/raw/main/environment.yml
RUN micromamba install -y -n base -f environment.yml && \
    micromamba clean --all --yes
