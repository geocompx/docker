# Use the specified base image
FROM ghcr.io/geocompx/minimal

# Install core Python 3 packages and other dependencies.
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-dev \
    python3-pip \
    swig \
    && ln -sf /usr/bin/python3 /usr/bin/python \
    && ln -sf /usr/bin/pip3 /usr/bin/pip \
    && rm -rf /var/lib/apt/lists/*

# Install reticulate R package to enable R-Python interoperability
RUN R -e "install.packages('reticulate', repos='https://cloud.r-project.org/')" \
    && rm -rf /tmp/*

# Set the environment variables for Quarto, Reticulate, GDAL, and Pyogrio
ENV QUARTO_PYTHON=/usr/bin/python \
    RETICULATE_PYTHON=/usr/bin/python \
    GDAL_NUM_THREADS="ALL_CPUS" \
    GDAL_CACHEMAX="512" \
    VSI_CACHE="TRUE" \
    GDAL_HTTP_MULTIPLEX="YES" \
    PYOGRIO_USE_ARROW="1"

# Install uv for fast parallel Python wheel resolution
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

# Install project requirements globally using uv, strip debug symbols, and prune test directories
RUN wget -q -O /tmp/requirements.txt https://github.com/geocompx/geocompy/raw/refs/heads/main/requirements.txt \
    && sed -i 's/==/>=/g' /tmp/requirements.txt \
    && uv pip install --system --break-system-packages --reinstall-package pyyaml --no-cache -r /tmp/requirements.txt \
    && (find /usr/local/lib/python*/dist-packages -name "*.so*" -type f -exec strip --strip-unneeded {} + 2>/dev/null || true) \
    && (find /usr/local/lib/python*/dist-packages -type d -name "tests" -prune -exec rm -rf {} + 2>/dev/null || true) \
    && rm /tmp/requirements.txt
