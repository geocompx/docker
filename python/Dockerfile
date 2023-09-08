FROM glcr.b-data.ch/python/base:3.11.5
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.450/quarto-1.3.450-linux-amd64.deb
RUN dpkg -i quarto*
RUN rm quarto*
RUN wget https://raw.githubusercontent.com/geocompx/py/main/requirements.txt
RUN pip install -r requirements.txt