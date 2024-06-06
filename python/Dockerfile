FROM python:3.11.4-slim-bullseye
# Install wget and unzip:
RUN apt update && apt install -y \
    wget \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*
# Install quarto
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.4.555/quarto-1.4.555-linux-amd64.deb
RUN dpkg -i quarto*
RUN rm quarto*
# Install requirements
RUN wget https://raw.githubusercontent.com/geocompx/py/main/requirements.txt
RUN pip install -r requirements.txt
