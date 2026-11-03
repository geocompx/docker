# Contributing to geocompx/docker

Thank you for your interest in contributing to `geocompx/docker`! These container images power the reproducible builds of *Geocomputation with R*, *Geocomputation with Python*, *Spatial Microsimulation with R*, and interactive geospatial development environments.

## Image Hierarchy

The repository builds three primary image families via [`.github/workflows/ci.yml`](.github/workflows/ci.yml):

* **Posit / Ubuntu Noble Slim Chain (CLI & Devcontainers):**
  * `minimal-slim` (`posit/r-base:4.5-noble` + core R spatial packages via Posit Package Manager binaries)
  * `python` (`ubuntu:24.04` + Quarto + `uv`-managed Python 3.14 geospatial stack in `/opt/venv`)
  * `pythonr` (`ghcr.io/geocompx/python:latest` + R from `posit/r-base:4.5-noble` + full `geocompkg` `Imports` & `Suggests`)

* **Rocker RStudio Chain (Browser IDE & Book Builds):**
  * `minimal` (`rocker/geospatial:latest` + core `geocompkg` `Imports`)
  * `latest` (`ghcr.io/geocompx/minimal:latest` + `spatial-microsim-book`)
  * `suggests` (`ghcr.io/geocompx/minimal:latest` + `geocompkg` `Suggests`)
  * `buildbook` (`ghcr.io/geocompx/suggests:latest` + book rendering dependencies)
  * `rust` (`ghcr.io/geocompx/suggests:latest` + Rust `cargo`/`rustc` toolchain)
  * `rocker-rpy` (`ghcr.io/geocompx/minimal:latest` + `uv` Python geospatial environment)
  * `rocker-rpyjl` (`ghcr.io/geocompx/rocker-rpy:latest` + Julia geospatial packages)

* **OSGeo / GIS Bridge Images:**
  * `osgeo` (`rocker/geospatial:dev-osgeo` + `geocompkg`)
  * `qgis` (`rocker/geospatial:dev-osgeo` + QGIS LTR, GRASS, SAGA, and `geocompkg` `Suggests`)

## Local Building and Testing

To build an image locally from the repository root:

```bash
# Build geocompx/python
docker build -f python/Dockerfile -t ghcr.io/geocompx/python:latest .

# Build geocompx/pythonr (depends on ghcr.io/geocompx/python:latest)
docker build -f pythonr/Dockerfile -t ghcr.io/geocompx/pythonr:latest .
```

To verify that all shared libraries linked by installed R packages resolve cleanly in `pythonr`:

```bash
docker run --rm ghcr.io/geocompx/pythonr:latest bash -c \
  'LD_LIBRARY_PATH="/opt/R/current/lib/R/lib:${LD_LIBRARY_PATH}" ldd /opt/R/current/lib/R/library/*/libs/*.so | grep "not found" || echo "All shared libraries resolved!"'
```

## Guidelines for Dockerfile Changes

* **Keep layers self-contained:** Clean temporary files (`/var/lib/apt/lists/*`, `/tmp/*`, `/root/.cache/*`, R package `help/` and `doc/` directories) in the **same `RUN` instruction** where packages are installed so intermediate layers do not bloat the final image.
* **Prefer pre-compiled binaries:** Use Posit Package Manager (`https://packagemanager.posit.co/cran/__linux__/noble/latest`) for R packages on Ubuntu Noble images and `uv pip install --no-cache` for Python wheels.
* **Runtime vs. `-dev` headers in `pythonr`:** `pythonr/Dockerfile` purges C/C++ `-dev` header packages at the end of its build to save ~300 MB, and verifies all `.so` files with `ldd` at build time. Users installing pre-compiled PPM binary R packages or Python wheels do not need `-dev` headers; users compiling source C/C++ spatial packages at runtime can run `apt-get update && apt-get install -y libgdal-dev libgeos-dev libproj-dev libudunits2-dev`.
* **Update documentation:** If you add or rename an image, update [`README.Rmd`](README.Rmd) and render [`README.md`](README.md) with `Rscript -e "rmarkdown::render('README.Rmd')"`.
