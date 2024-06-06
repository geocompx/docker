FROM ubuntu:jammy

RUN apt update
RUN apt install wget -y
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.41/quarto-1.5.41-linux-amd64.deb
RUN dpkg -i quarto*
