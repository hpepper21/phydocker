FROM rocker/ropensci

MAINTAINER Brian O'Meara <omeara.brian@gmail.com>

ADD VERSION .

RUN apt-get update

RUN apt-get install -y apt-utils

RUN echo 'options(repos = c(CRAN="https://cran.rstudio.com"))' > ~/.Rprofile

RUN apt-get install -y software-properties-common

RUN apt-get -y install python-dev

RUN apt-get -y install libcgal-dev libglu1-mesa-dev libglu1-mesa-dev libx11-dev

RUN apt-get update

RUN apt-get -y install x11-common

RUN apt-get install -y libmpfr-dev libmpfr-doc

RUN apt-get install -y curl

RUN apt-get install libgl1-mesa-dev

RUN apt-get install ed

RUN Rscript -e "install.packages('ctv')"

RUN Rscript -e "ctv::install.views('Phylogenetics')"

RUN Rscript -e "install.packages('diagram')"

RUN Rscript -e "devtools::install_github('bomeara/phrapl')"

RUN Rscript -e "devtools::install_github( 'heibl/ips')"

RUN Rscript -e 'source("https://bioconductor.org/biocLite.R")'

RUN Rscript -e "install.packages('yearn')"

RUN mkdir /usr/local/pathd8download && \
wget http://www2.math.su.se/PATHd8/PATHd8.zip -O /usr/local/pathd8download/PATHd8.zip && \
cd /usr/local/pathd8download && \
unzip /usr/local/pathd8download/PATHd8.zip && \
cc PATHd8.c -O3 -lm -o PATHd8 && \
cp PATHd8 /usr/local/bin/PATHd8

# From https://github.com/Linuxbrew/docker/blob/master/centos7/Dockerfile

RUN apt-get install -y curl make ruby sudo \
  && apt-get clean all

RUN localedef -i en_US -f UTF-8 en_US.UTF-8 \
	&& useradd -m -s /bin/bash linuxbrew \
	&& echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

USER linuxbrew
WORKDIR /home/linuxbrew

ENV PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH \
	SHELL=/bin/bash \
	USER=linuxbrew

RUN yes | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)" \
	&& brew config


RUN brew tap jonchang/biology

RUN brew install revbayes

RUN brew install bucky

RUN brew tap bomeara/homebrew-science

RUN brew install -v treepl

RUN brew install raxml

RUN brew install phylip

RUN brew install phyutility

# RUN brew install phlawd

# RUN brew install phylocom

USER root

ENV PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH
