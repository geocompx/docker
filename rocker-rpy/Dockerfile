FROM ghcr.io/geocompx/minimal
RUN /rocker_scripts/install_python.sh
# Install ubuntu pkg so that python3 is python and pip3 is pip:
RUN apt-get update && apt-get install -y python-is-python3
RUN pip install -r https://github.com/geocompx/geocompy/raw/refs/heads/main/requirements.txt
# Set env variable so reticulat uses system installation of python:
ENV RETICULATE_PYTHON=/usr/bin/python3
