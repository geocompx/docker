<!-- README.md is generated from README.Rmd. Please edit that file -->

# Geocomputation with Docker

[![](https://img.shields.io/docker/pulls/geocompr/geocompr?style=plastic)](https://github.com/geocompx/docker/blob/master/)

This repo documents Docker images for geographic research and
reproducing code in the books *Geocomputation with R* and
*Geocomputation with Python*. The Dockerfiles build on work done for the
[Rocker Project](https://www.rocker-project.org/). As documented on the
Rocker Project website, Docker can save time and increase
reproducibility by providing an environment with up-to-date and stable
software.

To get started, after you [install
Docker](https://docs.docker.com/get-docker/), try running one of the
following commands:

``` bash
# The latest version of rocker/geospatial + geocompr dependencies
docker run -e PASSWORD=pw --rm -p 8786:8787 ghcr.io/geocompx/latest
# With up-to-date OSGeo packages and qgisprocess:
docker run -e PASSWORD=pw --rm -p 8786:8787 ghcr.io/geocompx/osgeo
```

If you are asked for a username and password, then you should use
`rstudio` as your username and the password you set with the above code
(e.g., `pw`).

Then open a browser at <http://localhost:8786/>, and you should see
something like this:

![](https://user-images.githubusercontent.com/1825120/79639334-33eb9f00-8183-11ea-8358-588fe17afe25.png)

If so congratulations 🎉 you can proceed to open the `geocompr.Rproj`
project or other files in the `geocompr` folder, which contains a
complete copy of the source code and example data needed to build the
html version of the book.

To run a container without RStudio, try the following.

    docker run -e PASSWORD=pw --rm -ti ghcr.io/geocompx/latest /bin/bash

Use this resource to play with the examples, develop new answers to the
questions at the end of each page, or even to generate reproducible
examples to illustrate
[issues](https://github.com/geocompx/geocompr/issues) with the books
contents.

If not, see documentation on using Docker at websites such as
[docker.com](https://docs.docker.com/get-started/) and
<https://www.rocker-project.org/>.

## Sharing folders with Docker

To use these Docker images for your own work you will need to share
files with Docker. That means sharing ‘volumes’. You can do this using
the `-v` argument as shown below, which shares your current working
directory with the Docker container. If you run these commands in a
terminal that has access to Docker, like `bash` or Windows `PowerShell`
you should get a local copy of *Geocomputation with R* on your computer
that you can use for testing and development purposes, e.g. to test
changes before submitting a Pull Request to improve the book:

``` bash
# download repo with Windows Powershell or a Unix terminal
git clone https://github.com/geocompx/geocompr.git 
# or download manually from https://github.com/geocompx/geocompr/archive/main.zip
cd geocompr # navigate into the repo
# on linux and mac with password:
docker run -d -p 8786:8787 -v $(pwd):/home/rstudio/data -e USERID=$UID -e PASSWORD=pw ghcr.io/geocompx/minimal
# on linux and mac without password:
docker run -d -p 8786:8787 -e DISABLE_AUTH=TRUE -v $(pwd):/home/rstudio/geocompr  ghcr.io/geocompx/minimal
```

![](https://user-images.githubusercontent.com/1825120/39538109-9b50e7ac-4e33-11e8-93b3-e00e95a79294.png)

If you see something like this after following the steps above,
congratulations: it worked! See
[github.com/rocker-org](https://github.com/rocker-org/rocker/wiki/Using-the-RStudio-image#running-rstudio-server)
for more info.

You can also pull and run the same images from ghcr.io, e.g. as follow:

``` bash
# For latest version:
docker run -d -p 8786:8787 -v $(pwd):/home/rstudio/data -e PASSWORD=pw ghcr.io/geocompx/minimal
# For a specific version/date (see https://github.com/geocompx/docker/pkgs/container/minimal):
docker run -d -p 8786:8787 -v $(pwd):/home/rstudio/data -e PASSWORD=pw ghcr.io/geocompx/minimal:date_2024-10-14
```

From this point to *build* the book you can open projects in the
`geocompr` directory from the project box in the top-right hand corner,
and knit `index.Rmd` with the little `knit` button above the the RStudio
script panel (`Ctl+Shift+B` should do the same job).

There are various versions of the `geocompr` Docker image available. The
default is the `latest` tag, representing the `Dockerfile` in the root
of this repo, but you can get other images, as outlined below.

## Versions

Building on the
[rocker-org](https://github.com/rocker-org/rocker-versioned/blob/master/README.md)
project, we provide various versions for testing and development,
including builds that use more up-to-date versions of OSGeo packages
such as GDAL provided by the [UbuntuGIS software
repository](https://wiki.ubuntu.com/UbuntuGIS), as shown below:

| image | description | size |
|----|----|----|
| [latest](https://github.com/geocompx/docker/pkgs/container/docker/) | docker pull ghcr.io/geocompx/latest image + book files | ![](https://ghcr-badge.deta.dev/geocompx/docker/size?tag=latest) |
| [minimal](https://github.com/geocompx/docker/blob/master/minimal) | docker pull ghcr.io/geocompx/minimal rocker/geospatial plus geocompkg Imports | ![](https://ghcr-badge.deta.dev/geocompx/docker/size?tag=minimal) |
| [suggests](https://github.com/geocompx/docker/blob/master/suggests) | docker pull ghcr.io/geocompx/suggests includes all packages from geocompkgs (Suggests) | ![](https://ghcr-badge.deta.dev/geocompx/docker/size?tag=suggests) |
| [binder](https://github.com/geocompx/docker/blob/master/binder) | docker pull ghcr.io/geocompx/binder runs with Binder | ![](https://ghcr-badge.deta.dev/geocompx/docker/size?tag=binder) |
| [osgeo](https://github.com/geocompx/docker/blob/master/) | docker pull ghcr.io/geocompx/osgeo running on rocker/geospatial:osgeo | ![](https://ghcr-badge.deta.dev/geocompx/docker/size?tag=osgeo) |
| [buildbook](https://github.com/geocompx/docker/blob/master/) | docker pull ghcr.io/geocompx/buildbook runs the book code | ![](https://ghcr-badge.deta.dev/geocompx/docker/size?tag=buildbook) |
| [qgis](https://github.com/geocompx/docker/blob/master/) | docker pull ghcr.io/geocompx/qgis with QGIS | ![](https://ghcr-badge.deta.dev/geocompx/docker/size?tag=qgis) |
| [rocker-rpy](https://github.com/geocompx/docker/blob/master/) | docker pull ghcr.io/geocompx/rocker-rpy with python | ![](https://ghcr-badge.deta.dev/geocompx/docker/size?tag=rocker-rpy) |
| [rocker-rpyjl](https://github.com/geocompx/docker/blob/master/) | docker pull ghcr.io/geocompx/rocker-rpyjl with R, Python, and Julia | ![](https://ghcr-badge.deta.dev/geocompx/docker/size?tag=rocker-rpyjl) |
| [python](https://github.com/geocompx/docker/blob/master/) | docker pull ghcr.io/geocompx/python Python image + geo pkgs | ![](https://ghcr-badge.deta.dev/geocompx/docker/size?tag=python) |
| [rust](https://github.com/geocompx/docker/blob/master/) | docker pull ghcr.io/geocompx/rust with Rust | ![](https://ghcr-badge.deta.dev/geocompx/docker/size?tag=rust) |
| [mamba-py](https://github.com/geocompx/docker/blob/master/) | docker pull ghcr.io/geocompx/mamba-py | ![](https://ghcr-badge.deta.dev/geocompx/docker/size?tag=mamba-py) |
| [mamba-pyr](https://github.com/geocompx/docker/blob/master/) | docker pull ghcr.io/geocompx/mamba-pyr | ![](https://ghcr-badge.deta.dev/geocompx/docker/size?tag=mamba-pyr) |

The base image is `rocker/geospatial` from
[github.com/rocker-org/rocker-versioned2](https://github.com/rocker-org/rocker-versioned2).

Add :tagname after ghcr.io/geocompx/<image> to get the image you want.

<!-- To run the `buildbook` version (represented by the extension `-b` for most tags), for example, run the following command (with port and password set to a port of your preference): -->

``` bash
docker run -e PASSWORD=pw --rm -p 8786:8787 ghcr.io/geocompx/buildbook
```

## Examples

### osgeo

To test your code or package against recent versions of OSGeo libraries
(GDAL, GEOS, PROJ), you can run the following command from inside root
directory of the folder containing the code:

``` bash
# on linux and mac with password:
docker run -d -p 8786:8787 -v $(pwd):/home/rstudio/data \
  -e USERID=$UID -e PASSWORD=pw ghcr.io/geocompx/osgeo
```

### Python

The Python tag contains Python geospatial packages:

``` bash
docker run -e PASSWORD=pw --rm -ti ghcr.io/geocompx/python /bin/bash

python3
import pandas as pd
import geopandas as gpd
import movingpandas as mpd
```

You can run an interactive session via Reticulate in RStudio as follows:

``` bash
docker run -e PASSWORD=pw --rm -p 8786:8787 ghcr.io/geocompx/python
```

And then in the resulting RStudio session you can enter something along
the lines of:

``` r
library(sf)
f = file.path(system.file("shape/nc.shp", package="sf"))
nc_sf = read_sf(f)
library(reticulate)
system("pip3 install descartes")
gp = import("geopandas")
nc_gp = gp$read_file(f)
class(nc_gp)
plot(nc_gp$AREA, nc_gp$PERIMETER)
gp = import("geopandas", convert = FALSE)
nc_gp = gp$read_file(f)
nc_gp
plt = import("matplotlib.pyplot", convert = FALSE)
nc_gp$plot()
plt$savefig("test.png")
```

To plot from Python packages (work in
[progress](https://github.com/geocompr/docker/issues/12)).

### QGIS

To run QGIS from the command line, you can run:

``` bash
docker pull ghcr.io/geocompx/qgis
docker run --rm -ti ghcr.io/geocompx/qgis /bin/bash
qgis --version
# QGIS 3.20.3-Odense 'Odense' (495fbaecaf)
```

You can also run QGIS algorithms via the `qgisprocess` package as
follows:

    docker run -d -p 8786:8787 -v $(pwd):/home/rstudio/data -e PASSWORD=pw ghcr.io/geocompx/qgis

Then open a browser and the local url such as
<http://192.168.0.99:8786/> or <http://localhost:8786>, enter RStudio
server, and you should be able to access QGIS as follows in the R
console:

``` r
system("qgis --version")
## QGIS 3.16.1-Hannover 'Hannover' (b381a90dca)
remotes::install_github("paleolimbot/qgisprocess") # install the latest version of the package
qgis_algs = qgisprocess::qgis_algorithms()
nrow(qgis_algs)
## [1] 303
table(qgis_algs$provider)
##    3d   gdal native   qgis 
##     1     55    196     51 
```

### QGIS extensions

You can access algorithms from other GIS programs through QGIS but they
need to be installed. These can be accessed from the
`ghcr.io/geocompx/qgis` image as follows:

    docker run -d -p 8786:8787 -v $(pwd):/home/rstudio/data -e PASSWORD=pw ghcr.io/geocompx/qgis

Again, open the browser, e.g. at <http://localhost:8786>, and find the
new algorithms as follows:

``` r
system("qgis --version")
## QGIS 3.16.1-Hannover 'Hannover' (b381a90dca)
remotes::install_github("paleolimbot/qgisprocess") # install the latest version of the package
## Skipping install of 'qgisprocess' from a github remote, the SHA1 (6e378511) has not changed since last install.
qgis_algs = qgisprocess::qgis_algorithms()
nrow(qgis_algs)
## [1] 970
table(qgis_algs$provider)

##    3d   gdal grass7 native   qgis   saga 
##     1     55    301    196     51    366 
```

Congratulations, you now have nearly 1000 QGIS algorithms at your
disposal from the R command line 🎉

## Building the images locally

You can build the images locally, e.g. as follows:

``` bash
docker build qgis -t test
docker run -p 8888:8888 test
docker build conda -t geocompy
docker run -it geocompy /bin/bash
```

You should then be able to run commands in the newly created images,
e.g. with:

``` bash
docker run -it test /bin/bash
```
