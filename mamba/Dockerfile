FROM mambaorg/micromamba:bookworm
USER root

RUN apt update && apt install -y \
    wget \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*
USER $MAMBA_USER
RUN micromamba install --yes --name base --channel conda-forge \
      requests \
      quarto \
      pathlib && \
    micromamba clean --all --yes

RUN wget https://github.com/geocompx/geocompy/raw/main/environment.yml

COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes