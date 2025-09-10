FROM python:3.12-slim-bookworm

# Install dependencies, git, and gh cli
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    unzip \
    git \
    build-essential \
    curl \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list \
    && apt-get update \
    && apt-get install -y gh \
    && rm -rf /var/lib/apt/lists/*

# Install quarto
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.34/quarto-1.7.34-linux-amd64.deb
RUN dpkg -i quarto*
RUN rm quarto*

# Install requirements
RUN wget https://raw.githubusercontent.com/geocompx/py/main/requirements.txt
RUN pip install -r requirements.txt

# Clean up build tools to reduce image size (optional but recommended)
RUN apt purge -y build-essential && apt autoremove -y && rm -rf /var/lib/apt/lists/*