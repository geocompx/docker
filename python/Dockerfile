FROM python:3.11.1-bullseye
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.2.280/quarto-1.2.280-linux-amd64.deb
RUN dpkg -i quarto*
RUN rm quarto*
RUN wget https://raw.githubusercontent.com/geocompx/py/136-reinstate-requirementstxt/requirements.txt
RUN pip install -r requirements.txt