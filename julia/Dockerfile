FROM julia:1.11.0-rc3-bullseye
# Install wget and unzip:
RUN apt update && apt install -y \
    wget \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*
# Install quarto
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.54/quarto-1.5.54-linux-amd64.deb
RUN dpkg -i quarto*
RUN rm quarto*
# Install quarto julia requirements
RUN julia -e 'using Pkg; Pkg.add("IJulia"); using IJulia; installkernel(“Julia nodeps”, “–depwarn=no”); using Pkg; Pkg.add("Revise")'
