FROM python:3.13-slim-bookworm
# Install wget and unzip:
RUN apt update && apt install -y \
    wget \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*
# Install quarto
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.57/quarto-1.5.57-linux-amd64.deb
RUN dpkg -i quarto*
RUN rm quarto*
# Install requirements
RUN wget https://raw.githubusercontent.com/geocompx/py/main/requirements.txt
RUN pip install -r requirements.txt
