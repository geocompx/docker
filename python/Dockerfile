ARG PYTHON_BASE_IMAGE=python:3.14-slim-trixie
FROM ${PYTHON_BASE_IMAGE}

ARG QUARTO_VERSION=1.11.9

LABEL devcontainer.metadata='[{"customizations":{"vscode":{"extensions":["quarto.quarto","ms-python.python","ms-toolsai.jupyter"],"settings":{"python.defaultInterpreterPath":"/usr/local/bin/python"}}}}]'

ENV QUARTO_PYTHON="/usr/local/bin/python" \
    RETICULATE_PYTHON="/usr/local/bin/python" \
    GDAL_NUM_THREADS="ALL_CPUS" \
    GDAL_CACHEMAX="512" \
    VSI_CACHE="TRUE" \
    GDAL_HTTP_MULTIPLEX="YES" \
    PYOGRIO_USE_ARROW="1"

# Install dependencies, git, and gh cli (no build-essential needed since uv installs binary wheels)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    unzip \
    wget \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends gh \
    && rm -rf /var/lib/apt/lists/*

# Install quarto
RUN arch="$(dpkg --print-architecture)" \
    && wget -q "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-${arch}.deb" \
    && apt-get update \
    && apt-get install -y --no-install-recommends "./quarto-${QUARTO_VERSION}-linux-${arch}.deb" \
    && rm "quarto-${QUARTO_VERSION}-linux-${arch}.deb" \
    && rm -rf /var/lib/apt/lists/*

# Install uv for fast Python package & project management
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

# Install requirements using uv for fast parallel wheel resolution
RUN wget -q -O /tmp/requirements.txt https://raw.githubusercontent.com/geocompx/geocompy/main/requirements.txt \
    && sed -i 's/==/>=/g' /tmp/requirements.txt \
    && uv pip install --system --no-cache -r /tmp/requirements.txt seaborn openpyxl statsmodels pyarrow \
    && rm /tmp/requirements.txt
