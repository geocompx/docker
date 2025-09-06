# Use the specified base image
FROM ghcr.io/geocompx/minimal

# Install core Python 3 packages and other dependencies.
# - python3-dev: Headers needed to compile certain Python packages with C extensions.
# - python3-pip: The package installer for Python 3, installed globally.
# - swig: Used for wrapping C/C++ libraries for Python.
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-dev \
    python3-pip \
    swig && \
    rm -rf /var/lib/apt/lists/*

# Create a symbolic link so the 'python' command defaults to 'python3'
# The '-f' flag forces the creation of the symbolic link, overwriting any existing file.
RUN ln -sf /usr/bin/python3 /usr/bin/python

# Create a symbolic link so the 'pip' command defaults to 'pip3'
# The '-f' flag forces the creation of the symbolic link, overwriting any existing file.
RUN ln -sf /usr/bin/pip3 /usr/bin/pip

# Install reticulate R package to enable R-Python interoperability
# This step remains the same as it is a separate R installation.
RUN R -e "install.packages('reticulate', repos='https://cloud.r-project.org/')"

# Set the environment variable for Quarto to use the system Python 3.
# The `which python3` command finds the path of the globally installed executable.
ENV QUARTO_PYTHON=/usr/bin/python

# Install project requirements globally using the system's pip3.
# We use `pip3` to ensure we are using the package manager for Python 3.
# The `--break-system-packages` flag is added to override the security feature.
# The `--ignore-installed` flag is added to prevent pip from trying to uninstall
# packages that are managed by the system.
RUN pip3 install --no-cache-dir --break-system-packages --ignore-installed -r https://github.com/geocompx/geocompy/raw/refs/heads/main/requirements.txt
