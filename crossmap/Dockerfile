FROM ubuntu:18.04

RUN apt-get update -y && apt-get install -y curl 

RUN curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN sh Miniconda3-latest-Linux-x86_64.sh
RUN exec bash
RUN conda config --add channels defaults
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge

RUN conda install crossmap

RUN curl -O http://hgdownload.soe.ucsc.edu/goldenPath/hg38/liftOver/hg38ToHg19.over.chain.gz

pip3 install --upgrade pip3
pip3 install CrossMap 
CrossMap.py bed ./hg38ToHg19.over.chain.gz ./hg38.blacklist.bed 

