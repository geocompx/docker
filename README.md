
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Geocomputation with R in Docker

<!-- badges: start -->

[![](https://img.shields.io/docker/pulls/geocompr/geocompr.svg)](https://hub.docker.com/r/geocompr/geocompr:)
<!-- badges: end -->

This repo documents Docker images for geographic research and
reproducing code in the book *Geocomputation with R*. The Dockerfiles
build on work done for the [Rocker
Project](https://www.rocker-project.org/) by Carl Boettiger, Dirk
Eddelbuettel and Noam Ross. As documented on the Rocker Project website,
Docker can save time by removing pain and reducing time associated with
setting-up your operating system to work with the latest geographic
packages.

To get started, after you [install
Docker](https://docs.docker.com/get-docker/), try running one of the
following commands:

``` bash
# The latest version of rocker/geospatial + geocompr dependencies
docker run -e PASSWORD=pw --rm -p 8786:8787 geocompr/geocompr
# With up-to-date OSGeo packages (runs on Ubuntu 18.04):
docker run -e PASSWORD=pw --rm -p 8786:8787 geocompr/geocompr:ubuntugis-unstable
```

Then open a browser at <http://localhost:8786/> and you should see
something like this:

![](https://user-images.githubusercontent.com/1825120/79639334-33eb9f00-8183-11ea-8358-588fe17afe25.png)
If so congratulations 🎉 you can proceed to open the `geocompr.Rproj`
project or other files in the `geocompr` folder, which contains a
complete copy of the source code and example data needed to build the
html version of the book.

To run a container without RStudio, try the following.

    docker run -e PASSWORD=pw --rm -ti geocompr/geocompr /bin/bash

Use this resource to play with the examples, develop new answers to the
questions at the end of each page, or even to generate reproducible
examples to illustrate
[issues](https://github.com/Robinlovelace/geocompr/issues) with the
books contents.

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
git clone https://github.com/Robinlovelace/geocompr.git 
# or download manually from https://github.com/Robinlovelace/geocompr/archive/master.zip
cd geocompr # navigate into the repo
# on linux and mac with password:
docker run -d -p 8786:8787 -v $(pwd):/home/rstudio/data -e USERID=$UID -e PASSWORD=pw geocompr/geocompr
# on linux and mac without password:
docker run -d -p 8786:8787 -e DISABLE_AUTH=TRUE -v $(pwd):/home/rstudio/geocompr  geocompr/geocompr
# on windows without a password:
docker run -d -p 8786:8787 -v ${pwd}:/home/rstudio/data -e DISABLE_AUTH=TRUE robinlovelace/geocompr
```

![](https://user-images.githubusercontent.com/1825120/39538109-9b50e7ac-4e33-11e8-93b3-e00e95a79294.png)

If you see something like this after following the steps above,
congratulations: it worked\! See
[github.com/rocker-org](https://github.com/rocker-org/rocker/wiki/Using-the-RStudio-image#running-rstudio-server)
for more info.

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

| image                                                                      | description                                             | size                                                                               |
| -------------------------------------------------------------------------- | ------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| [geocompr:latest](https://hub.docker.com/r/geocompr/geocompr)              | rocker/geospatial:latest base image                     | ![](https://img.shields.io/docker/image-size/geocompr/geocompr/latest)             |
| [geocompr:buildbook](https://hub.docker.com/r/geocompr/geocompr)           | rocker/geospatial:latest with built version of the book | ![](https://img.shields.io/docker/image-size/geocompr/geocompr/buildbook)          |
| [geocompr:ubuntugis\_unstable](https://hub.docker.com/r/geocompr/geocompr) | UbuntuGIS unstable repos on Ubuntu                      | ![](https://img.shields.io/docker/image-size/geocompr/geocompr/ubuntugis_unstable) |
| [geocompr:python](https://hub.docker.com/r/geocompr/geocompr)              | geocompr/geocompr with Python                           | ![](https://img.shields.io/docker/image-size/geocompr/geocompr/python)             |
| [geocompr:qgis](https://hub.docker.com/r/geocompr/geocompr)                | geocompr/geocompr with QGIS                             | ![](https://img.shields.io/docker/image-size/geocompr/geocompr/qgis)               |
| [geocompr:qgis-dev](https://hub.docker.com/r/geocompr/geocompr)            | geocompr/geocompr with dev version of QGIS              | ![](https://img.shields.io/docker/image-size/geocompr/geocompr/qgis-dev)           |

<!-- [geocompr:rstudio_devel](https://hub.docker.com/r/geocompr/geocompr)            |  UbuntuGIS Unstable repos and R devel  | ![](https://img.shields.io/docker/image-size/geocompr/geocompr/rstudio_devel) -->

The base image is `rocker/geospatial:latest` from
[github.com/rocker-org/rocker-versioned2](https://github.com/rocker-org/rocker-versioned2).

Add :tagname to geocompr/geocompr to get the tag you’re interested in.

To run the `buildbook` version, for example, run the following command
(with port and password set to a port of your preference):

``` bash
docker run -e PASSWORD=pw --rm -p 8786:8787 geocompr/geocompr:buildbook
```

## Examples

The Python tag contains Python geospatial packages:

``` bash
docker run -e PASSWORD=pw --rm -ti geocompr/geocompr:python /bin/bash

python
import pandas as pd
import geopandas as gpd
import movingpandas as mpd
```

To run QGIS from the command line, you can run:

    docker run -e PASSWORD=pw --rm -ti geocompr/geocompr:qgis /bin/bash
    qgis --version
    # qgis_process

<!-- README last updated 2020-10-02 22:54:39 -->

<!-- To build on different system configurations we provide tags that correspond to the following categories: -->

<!-- `baseimage-ubuntugis-setup-rpackages-buildbook` -->

<!-- ```{r} -->

<!-- baseimage = c( -->

<!--   base = "base" -->

<!-- ) -->

<!-- ``` -->

<!-- Ubuntugis options include using the `ubuntugis-unstable` and `ubuntugis-stable` repos. -->

<!-- ```{r} -->

<!-- ubuntugis = c( -->

<!--   no_ubuntugis = "default_repos", -->

<!--   ubuntugis_unstable = "ubuntugis_unstable", -->

<!--   ubuntugis_stable = "ubuntugis_stable" -->

<!-- ) -->

<!-- ``` -->

<!-- Setup options can include RStudio settings (yet to be added). -->

<!-- R package options relate to which R packages are installed on the image (yet to be added). -->

<!-- Buildbook options report whether or not the book is built: -->

<!-- ```{r} -->

<!-- buildbook = c( -->

<!--   no = "", -->

<!--   yes = "buildbook" -->

<!-- ) -->

<!-- ``` -->

<!-- We will create a 'build matrix' covering all combinations of these options (excluding the base image for now): -->

<!-- ```{r} -->

<!-- g = expand.grid(ubuntugis, buildbook, stringsAsFactors = FALSE) -->

<!-- g -->

<!-- ``` -->

<!-- These can be converted into tags as follows: -->

<!-- ```{r} -->

<!-- tag_df = tidyr::unite(g, tag) -->

<!-- tags = gsub(pattern = "__|^_|_$", replacement = "", tag_df$tag) -->

<!-- tags -->

<!-- ``` -->

<!-- We could write code to auto-generate Dockerfiles, as demonstrated in [rocker-org/rocker-versioned2](https://github.com/rocker-org/rocker-versioned2). -->

<!-- For now, to start the project going, we will manually edit the files, which can be created as follows: -->

<!-- ```{r, eval=FALSE} -->

<!-- new_dockerfiles = paste0("dockerfiles/Dockerfile_", tags) -->

<!-- new_dockerfiles -->

<!-- lapply(new_dockerfiles, file.copy, from = "rocker-ubuntugis-bookbuild/Dockerfile", TRUE) -->

<!-- ``` -->

<!-- Edit these files as appropriate: -->

<!-- ```{r, eval=FALSE} -->

<!-- file.edit("dockerfiles/Dockerfile_ubuntugis_unstable") -->

<!-- ``` -->

<!-- Create a folder for each Dockerfile: -->

<!-- ```{r, eval=FALSE} -->

<!-- lapply(tags, dir.create) -->

<!-- lapply(tags, function(x) { -->

<!--   file.copy( -->

<!--     from = paste0("dockerfiles/Dockerfile_", x), -->

<!--     , to = paste0(x, "/Dockerfile"), -->

<!--     overwrite = TRUE) -->

<!-- }) -->

<!-- ``` -->

<!-- Build Docker files in this repo with the following command -->

<!-- ```bash -->

<!-- docker build ubuntugis_unstable -->

<!-- ``` -->
