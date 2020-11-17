## work from latest LTS ubuntu release
FROM ubuntu:18.04

## 设置语言，支持中文
ENV LANG C.UTF-8

## run update and install necessary tools from package manager
RUN apt-get update -y && apt-get install -y \
    wget\
    build-essential \
    cmake \
    zlib1g-dev \
    libhdf5-dev \
    libnss-sss \
    curl \
    autoconf \
    bzip2 \
    python3-dev \
    python3-pip \
    python3-biopython \
    pigz \
    git \
    libncurses5-dev \
    libncursesw5-dev \
    libbz2-dev \
    liblzma-dev \
    bzip2 \
    unzip \
    git-lfs\
    gnumeric

# install python libraries
RUN pip3 install numpy
RUN pip3 install scipy
RUN pip3 install pandas

## miniconda
## Instruction: https://github.com/ENCODE-DCC/chip-seq-pipeline2/blob/master/docs/install_conda.md
## Download Miniconda installer. Use default answers to all questions except for the first and last.
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /root/miniconda.sh
RUN bash /root/miniconda.sh -b -p /root/miniconda 
RUN rm /root/miniconda.sh
## RUN eval "$(~/miniconda/bin/conda shell.bash hook)"
## RUN export PATH=~/miniconda/bin:$PATH
## RUN ~/miniconda/bin/conda init
ENV PATH="/root/miniconda/bin:${PATH}"
RUN conda init
## IMPORTANT: Close your session and re-login. If you skip this step then pipeline's Conda environment will be messed up with base Conda environment.
RUN exec bash

## IMPORTANT: Disable auto activation of base Conda enrivonment.
RUN conda config --set auto_activate_base false
## IMPORTANT: Close your session and re-login.
RUN exec bash

RUN conda config --add channels defaults
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge
RUN conda install cromwell
RUN pip3 install toil[aws,mesos,azure,google,encryption,cwl]

RUN conda install samtools bwa bowtie hisat2 star stringtie htseq fastqc bedtools seqtk snpeff bioconductor-ballgown

