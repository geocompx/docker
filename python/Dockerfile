ARG PYTHON_BASE_IMAGE=python:3.12-slim-bookworm
FROM ${PYTHON_BASE_IMAGE}

ARG QUARTO_VERSION=1.9.37

LABEL devcontainer.metadata='[{"customizations":{"vscode":{"extensions":["quarto.quarto","ms-python.python","ms-toolsai.jupyter"],"settings":{"python.defaultInterpreterPath":"/usr/local/bin/python"}}}}]'

# Install dependencies, git, and gh cli
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    build-essential \
    curl \
    git \
    unzip \
    wget \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list \
    && apt-get update \
    && apt-get install -y gh \
    && rm -rf /var/lib/apt/lists/*

# Install quarto
RUN arch="$(dpkg --print-architecture)" \
    && wget -q "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-${arch}.deb" \
    && apt-get update \
    && apt-get install -y --no-install-recommends "./quarto-${QUARTO_VERSION}-linux-${arch}.deb" \
    && rm "quarto-${QUARTO_VERSION}-linux-${arch}.deb" \
    && rm -rf /var/lib/apt/lists/*

# Install requirements
RUN wget -q -O /tmp/requirements.txt https://raw.githubusercontent.com/geocompx/py/main/requirements.txt \
    && python -m pip install --no-cache-dir -r /tmp/requirements.txt \
    && rm /tmp/requirements.txt


# Clean up build tools to reduce image size (optional but recommended)
RUN apt purge -y build-essential && apt autoremove -y && rm -rf /var/lib/apt/lists/*
