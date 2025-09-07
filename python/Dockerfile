FROM python:3.12-slim-bookworm

# Install wget, unzip, git, and build tools (needed for compiling packages like matplotlib)
RUN apt update && apt install -y \
    wget \
    unzip \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install quarto
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.57/quarto-1.5.57-linux-amd64.deb
RUN dpkg -i quarto*
RUN rm quarto*

# Install requirements
RUN wget https://raw.githubusercontent.com/geocompx/py/main/requirements.txt
RUN pip install -r requirements.txt

# Clean up build tools to reduce image size (optional but recommended)
RUN apt purge -y build-essential && apt autoremove -y && rm -rf /var/lib/apt/lists/*