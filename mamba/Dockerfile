FROM mambaorg/micromamba:focal

RUN micromamba install --yes --name base --channel conda-forge \
      requests \
      pathlib && \
    micromamba clean --all --yes

# Source: https://hub.docker.com/r/mambaorg/micromamba
COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes

# RUN sudo apt install wget
# RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v0.9.622/quarto-0.9.622-linux-amd64.deb
# RUN dpkg -i quarto*


# ENTRYPOINT ["conda", "run", "-n", "geocompy", \
#             "python", "-c", \
#             "import numpy; print('success!')"]
# See https://stackoverflow.com/questions/72021249/
# RUN conda config --add channels conda-forge && conda update -y conda \
#   && conda install -y geopandas
# RUN wget https://github.com/geocompr/py/archive/refs/heads/main.zip
# RUN conda install -c conda-forge unzip 
