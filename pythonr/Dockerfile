FROM ghcr.io/geocompx/python

LABEL devcontainer.metadata='[{"customizations":{"vscode":{"extensions":["REditorSupport.r","quarto.quarto","ms-python.python","ms-toolsai.jupyter"],"settings":{"python.defaultInterpreterPath":"/usr/local/bin/python","r.sessionWatcher":true,"r.plot.backend":"auto","r.bracketedPaste":true,"r.interactive.executionTarget":"terminal"}}}}]'

# Note: previously this image built on Rocker but install_R_ppa.sh fails on Debian
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    libdeflate0 \
    locales \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Manual R installation: Download and install R DEB for Debian 13 (trixie)
ARG R_VERSION=4.6.2
RUN curl -fsSLO https://cdn.posit.co/r/debian-13/pkgs/r-${R_VERSION}_1_$(dpkg --print-architecture).deb && \
    apt-get update && \
    apt-get install -y --no-install-recommends ./r-${R_VERSION}_1_$(dpkg --print-architecture).deb && \
    rm r-${R_VERSION}_1_$(dpkg --print-architecture).deb && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/opt/R/${R_VERSION}/bin:${PATH}"
ENV R_PKG_TYPE=binary
ENV RETICULATE_PYTHON="/usr/local/bin/python"

# Ensure python3 resolves to the 3.12 interpreter from the base image
RUN update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python 10

# Configure Rprofile.site and /root/.Rprofile with P3M trixie binary repository and HTTPUserAgent
# so both pak and base install.packages() receive precompiled Linux binary packages from P3M
RUN mkdir -p /etc/R "/opt/R/${R_VERSION}/lib/R/etc" /root && \
    cat <<'EOF' > "/opt/R/${R_VERSION}/lib/R/etc/Rprofile.site"
options(
  repos = c(CRAN = "https://p3m.dev/cran/__linux__/trixie/latest"),
  download.file.method = "libcurl",
  HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"])),
  sess.quiet = TRUE
)
EOF
RUN cp "/opt/R/${R_VERSION}/lib/R/etc/Rprofile.site" /etc/R/Rprofile.site && \
    cp "/opt/R/${R_VERSION}/lib/R/etc/Rprofile.site" /root/.Rprofile

# Install arf (modern Rust-based R console used by vscode-R persistent sessions)
RUN curl --proto '=https' --tlsv1.2 -LsSf https://github.com/eitsupi/arf/releases/latest/download/arf-console-installer.sh | env ARF_INSTALL_DIR=/usr/local/bin sh

# Install pak from precompiled binary
RUN R -e "install.packages('pak')"

# Install geocompkg (including Suggests) + VS Code R extension (vscode-R v3+) dependencies
# using pak so system requirements and precompiled P3M/r-universe binaries are resolved in parallel
RUN Rscript -e "options(repos = c(geocompx = 'https://geocompx.r-universe.dev', mlrorg = 'https://mlr-org.r-universe.dev', CRAN = 'https://p3m.dev/cran/__linux__/trixie/latest')); pak::pak(c('sf', 'geocompkg', 'languageserver', 'httpgd', 'jgd', 'rstudioapi', 'processx', 'ps', 'later', 'jsonlite', 'svglite', 'reticulate'), dependencies = TRUE)" && \
    rm -rf /tmp/* /root/.cache/R/pkgcache
