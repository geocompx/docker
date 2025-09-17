#!/bin/bash

# CSV file
csv_file="image-info.csv"

# Write header
echo "image_name,description,size" > "$csv_file"

# Descriptions from the markdown table in README.Rmd
declare -A descriptions=(
    ["latest"]="docker pull ghcr.io/geocompx/latest"
    ["minimal"]="docker pull ghcr.io/geocompx/minimal"
    ["suggests"]="docker pull ghcr.io/geocompx/suggests"
    ["binder"]="docker pull ghcr.io/geocompx/binder"
    ["osgeo"]="docker pull ghcr.io/geocompx/osgeo"
    ["buildbook"]="docker pull ghcr.io/geocompx/buildbook"
    ["qgis"]="docker pull ghcr.io/geocompx/qgis"
    ["rocker-rpy"]="docker pull ghcr.io/geocompx/rocker-rpy"
    ["rocker-rpyjl"]="docker pull ghcr.io/geocompx/rocker-rpyjl"
    ["python"]="docker pull ghcr.io/geocompx/python"
    ["rust"]="docker pull ghcr.io/geocompx/rust"
    ["pythonr"]="docker pull ghcr.io/geocompx/pythonr"
    ["geocompy"]="docker pull ghcr.io/geocompx/latest"
    ["unzipped"]="docker pull ghcr.io/geocompx/unzipped"
)

# List of packages from the original script
packages=("binder" "buildbook" "geocompy" "minimal" "osgeo" "python" "pythonr" "qgis" "rocker-rpy" "rocker-rpyjl" "rust" "suggests" "unzipped")

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