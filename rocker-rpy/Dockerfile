FROM ghcr.io/geocompx/minimal

# Use Python already provisioned by the base image virtualenv (/opt/venv).
# Do not reinstall Python; ensure the venv python is preferred and 'python' exists.
RUN /rocker_scripts/install_python.sh

# Prefer the venv python and put its bin on PATH so reticulate picks it up.
ENV RETICULATE_PYTHON=/opt/venv/bin/python
ENV PATH=/opt/venv/bin:${PATH}

# Override the python symlink to use the venv Python (not system Python)
RUN ln -sf /opt/venv/bin/python /usr/bin/python
# Set version of Python that Quarto will use:
ENV QUARTO_PYTHON=/opt/venv/bin/python

# Optionally install project requirements into the existing venv if desired:
RUN /opt/venv/bin/pip install -r https://github.com/geocompx/geocompy/raw/refs/heads/main/requirements.txt
