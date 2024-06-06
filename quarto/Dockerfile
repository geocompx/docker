FROM ubuntu:jammy

RUN apt update
RUN apt install wget -y
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.4.555/quarto-1.4.555-linux-amd64.deb
RUN dpkg -i quarto*
