FROM ghcr.io/geocompx/minimal

# Small helper so the 'python' command exists (doesn't reinstall python itself).
RUN apt-get update && apt-get install -y --no-install-recommends python-is-python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install project requirements into the existing venv if desired:
RUN python3 -m pip install -r https://github.com/geocompx/geocompy/raw/refs/heads/main/requirements.txt --break-system-packages
