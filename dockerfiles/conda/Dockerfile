FROM continuumio/miniconda3

ARG QUARTO_VERSION=1.9.37

# See https://pythonspeed.com/articles/conda-docker-image-size/
# RUN environment.yml .
RUN wget https://github.com/geocompr/py/raw/main/environment.yml

# https://stackoverflow.com/questions/60855061/
RUN . /root/.bashrc && \
    conda env create -f environment.yml && \
    conda init bash && \
    conda activate geocompy


# https://pythonspeed.com/articles/activate-conda-dockerfile/
# Make RUN commands use the new environment:
RUN echo "conda activate geocompy" >> ~/.bashrc
SHELL ["/bin/bash", "--login", "-c"]

RUN arch="$(dpkg --print-architecture)" \
    && wget -q "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-${arch}.deb" \
    && apt-get update \
    && apt-get install -y --no-install-recommends "./quarto-${QUARTO_VERSION}-linux-${arch}.deb" \
    && rm "quarto-${QUARTO_VERSION}-linux-${arch}.deb" \
    && rm -rf /var/lib/apt/lists/*

# RUN wget https://github.com/geocompr/py/archive/refs/heads/main.zip
# RUN unzip main.zip
RUN wget https://raw.githubusercontent.com/geocompr/py/main/code/unzip.py
RUN python unzip.py

# Demonstrate the environment is activated:
RUN echo "Make geopandas is installed:"
RUN python -c "import geopandas"


# ENTRYPOINT ["conda", "run", "-n", "geocompy", \
#             "python", "-c", \
#             "import numpy; print('success!')"]
# See https://stackoverflow.com/questions/72021249/
# RUN conda config --add channels conda-forge && conda update -y conda \
#   && conda install -y geopandas
# RUN wget https://github.com/geocompr/py/archive/refs/heads/main.zip
# RUN conda install -c conda-forge unzip 
