FROM continuumio/miniconda3

# See https://pythonspeed.com/articles/conda-docker-image-size/
# RUN environment.yml .
RUN wget https://github.com/geocompr/py/raw/main/environment.yml

# https://stackoverflow.com/questions/60855061/
RUN . /root/.bashrc && \
    conda env create -f environment.yml && \
    conda init bash && \
    conda activate geocompy
RUN echo "conda activate geocompy" >> ~/.bashrc

RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v0.9.622/quarto-0.9.622-linux-amd64.deb
RUN dpkg -i quarto*

# RUN wget https://github.com/geocompr/py/archive/refs/heads/main.zip
# RUN unzip main.zip
RUN wget https://raw.githubusercontent.com/geocompr/py/main/unzip.py
RUN python unzip.py


# ENTRYPOINT ["conda", "run", "-n", "geocompy", \
#             "python", "-c", \
#             "import numpy; print('success!')"]
# See https://stackoverflow.com/questions/72021249/
# RUN conda config --add channels conda-forge && conda update -y conda \
#   && conda install -y geopandas
# RUN wget https://github.com/geocompr/py/archive/refs/heads/main.zip
# RUN conda install -c conda-forge unzip 
