# Use the specified base image
FROM ghcr.io/geocompx/minimal

# Install core Python 3 packages and other dependencies.
# - python3-dev: Headers needed to compile certain Python packages with C extensions.
# - python3-pip: The package installer for Python 3, installed globally.
# - swig: Used for wrapping C/C++ libraries for Python.
# - python3-venv: The module to create virtual environments.
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    swig && \
    rm -rf /var/lib/apt/lists/*

# Create a symbolic link so the 'python' command defaults to 'python3'
# The '-f' flag forces the creation of the symbolic link, overwriting any existing file.
RUN ln -sf /usr/bin/python3 /usr/bin/python

# Create a symbolic link so the 'pip' command defaults to 'pip3'
# The '-f' flag forces the creation of the symbolic link, overwriting any existing file.
RUN ln -sf /usr/bin/pip3 /usr/bin/pip

# Create a Python virtual environment to avoid system package conflicts.
RUN python3 -m venv /opt/venv

# Set the environment variable for Quarto to use the virtual environment's Python.
ENV QUARTO_PYTHON=/opt/venv/bin/python

# Add the virtual environment's bin directory to the PATH.
ENV PATH="/opt/venv/bin:$PATH"

# Install project requirements into the virtual environment.
# This avoids all system package conflicts.
RUN pip install --no-cache-dir -r https://github.com/geocompx/geocompy/raw/refs/heads/main/requirements.txt

# Install reticulate R package to enable R-Python interoperability
# This step remains the same as it is a separate R installation.
RUN R -e "install.packages('reticulate', repos='https://cloud.r-project.org/')"
