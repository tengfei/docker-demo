FROM ubuntu:18.04

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
## 设置语言，支持中文
ENV LANG C.UTF-8

## run update and install necessary tools from package manager
RUN apt-get update && apt-get install -y \
    git gcc g++ perl python3 automake make \
    wget tree curl libdb-dev \
    bzip2 zlibc zlib1g zlib1g-dev  default-jre pbzip2\
    python-setuptools python-dev build-essential \
    unzip libbz2-dev  liblzma-dev && \
    apt-get clean
    
## Install mini conda https://stackoverflow.com/questions/58269375/how-to-install-packages-with-miniconda-in-dockerfile
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 

## COPY environment.yml .
## RUN conda env create --file=environment.yml

RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge

## Install popular python tools
RUN conda install python=3.7 numpy scipy matplotlib statsmodels pandas requests igv-reports

## Install popular bioinformatics tools
RUN conda install samtools bwa bowtie2 hisat2 stringtie htseq fastqc bedtools seqtk snpeff picard multiqc gatk4

## Install popular R CRAN tools
RUN conda install r r-tidyverse r-survival r-survminer r-rcolorbrewer r-xlsx r-gplots

## Install popular R Bioconductor tools
RUN conda install bioconductor-ballgown bioconductor-limma bioconductor-deseq2 bioconductor-edger
RUN conda install bioconductor-complexheatmap

## Install pipeline engine
## RUN conda install cromwell
## RUN pip3 install toil[aws,mesos,azure,google,encryption,cwl]

## Tools needed for building a CTAT Genome lib.
RUN conda install star-fusion=1.9.0 star=2.7.2b
RUN conda install blast hmmer gmap

## HISAT-Stringtie-Ballgawn
RUN conda install r-devtools
ENV TAR="/bin/tar"
RUN R -e "devtools::install_github('alyssafrazee/RSkittleBrewer')"