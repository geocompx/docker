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

# Configure dpkg to exclude documentation, manpages, and locale translations across all layers,
# and install dependencies, git, gh cli, and quarto in a single clean layer with SHA-256 inode deduplication
RUN printf "path-exclude /usr/share/doc/*\npath-exclude /usr/share/man/*\npath-exclude /usr/share/locale/*\npath-exclude /usr/share/info/*\n" > /etc/dpkg/dpkg.cfg.d/docker-no-doc \
    && apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        unzip \
        wget \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list \
    && arch="$(dpkg --print-architecture)" \
    && wget -q "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-${arch}.deb" \
    && apt-get update \
    && apt-get install -y --no-install-recommends gh "./quarto-${QUARTO_VERSION}-linux-${arch}.deb" \
    && rm "quarto-${QUARTO_VERSION}-linux-${arch}.deb" \
    && python -c 'import os,hashlib; seen={}; [([os.unlink(p),os.link(seen[h],p)] if h in seen else seen.setdefault(h,p)) for r,_,fs in os.walk("/opt/quarto") for f in fs if not os.path.islink(p:=os.path.join(r,f)) and (s:=os.path.getsize(p))>4096 and (h:=(s,hashlib.sha256(open(p,"rb").read()).hexdigest()))]' \
    && rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/locale/* /var/lib/apt/lists/*

# Install uv for fast Python package & project management
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

# Install requirements using uv, strip debug symbols from compiled C/C++ shared libraries,
# prune bundled package unit test suites/C++ headers, and hardlink duplicate files in site-packages
RUN apt-get update && apt-get install -y --no-install-recommends binutils \
    && wget -q -O /tmp/requirements.txt https://raw.githubusercontent.com/geocompx/geocompy/main/requirements.txt \
    && sed -i 's/==/>=/g' /tmp/requirements.txt \
    && uv pip install --system --no-cache -r /tmp/requirements.txt seaborn openpyxl statsmodels pyarrow \
    && (find /usr/local/lib/python3.14/site-packages -name "*.so*" -type f -exec strip --strip-unneeded {} + 2>/dev/null || true) \
    && (find /usr/local/lib/python3.14/site-packages -type d -name "tests" -prune -exec rm -rf {} + 2>/dev/null || true) \
    && rm -rf /usr/local/lib/python3.14/site-packages/pyarrow/include \
              /usr/local/lib/python3.14/site-packages/numpy/_core/include \
              /usr/local/lib/python3.14/site-packages/numpy/f2py/src \
              /usr/local/lib/python3.14/site-packages/jupyterlab/galata \
              /usr/local/lib/python3.14/site-packages/jedi/third_party/django-stubs \
    && (find /usr/local/lib/python3.14/site-packages -name "*.js.map" -delete 2>/dev/null || true) \
    && python -c 'import os,hashlib; seen={}; [([os.unlink(p),os.link(seen[h],p)] if h in seen else seen.setdefault(h,p)) for r,_,fs in os.walk("/usr/local/lib/python3.14/site-packages") for f in fs if not os.path.islink(p:=os.path.join(r,f)) and (s:=os.path.getsize(p))>4096 and (h:=(s,hashlib.sha256(open(p,"rb").read()).hexdigest()))]' \
    && apt-get purge -y --auto-remove binutils \
    && rm -rf /tmp/requirements.txt /var/lib/apt/lists/*
