#!/bin/bash

# CSV file
csv_file="image-info.csv"

# Write header
echo "image_name,description,size" > "$csv_file"

# Descriptions from the markdown table in README.Rmd
declare -A descriptions=(
    ["latest"]="docker pull ghcr.io/geocompx/latest image + book files"
    ["minimal"]="docker pull ghcr.io/geocompx/minimal rocker/geospatial plus geocompkg Imports"
    ["suggests"]="docker pull ghcr.io/geocompx/suggests includes all packages from geocompkgs (Suggests)"
    ["binder"]="docker pull ghcr.io/geocompx/binder runs with Binder"
    ["osgeo"]="docker pull ghcr.io/geocompx/osgeo running on rocker/geospatial:osgeo"
    ["buildbook"]="docker pull ghcr.io/geocompx/buildbook runs the book code"
    ["qgis"]="docker pull ghcr.io/geocompx/qgis with QGIS"
    ["rocker-rpy"]="docker pull ghcr.io/geocompx/rocker-rpy with python"
    ["rocker-rpyjl"]="docker pull ghcr.io/geocompx/rocker-rpyjl with R, Python, and Julia"
    ["python"]="docker pull ghcr.io/geocompx/python Python image + geo pkgs"
    ["rust"]="docker pull ghcr.io/geocompx/rust with Rust"
    ["mamba-py"]="docker pull ghcr.io/geocompx/mamba-py"
    ["mamba-pyr"]="docker pull ghcr.io/geocompx/mamba-pyr"
    ["pythonr"]="docker pull ghcr.io/geocompx/pythonr Python and R image + geo pkgs"
    ["geocompy"]="docker pull ghcr.io/geocompx/latest image + book files"
    ["unzipped"]="docker pull ghcr.io/geocompx/unzipped rocker/geospatial with geocompr book unzipped"
)

# List of packages from the original script
packages=("binder" "buildbook" "geocompy" "mamba-py" "mamba-pyr" "minimal" "osgeo" "python" "pythonr" "qgis" "rocker-rpy" "rocker-rpyjl" "rust" "suggests" "unzipped")

for pkg in "${packages[@]}"; do
    if [[ -n "${descriptions[$pkg]}" ]]; then
        image="ghcr.io/geocompx/$pkg"
        echo "Pulling $image"
        docker pull "$image" > /dev/null 2>&1
        size=$(docker images "$image" --format "{{.Size}}" | head -1)
        description="${descriptions[$pkg]}"
        echo "$pkg,\"$description\",$size" >> "$csv_file"
    fi
done