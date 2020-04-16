FROM conda/miniconda3

## libssl1.0.0 for ubuntu 18.04 ...
RUN echo "deb http://security.debian.org/debian-security jessie/updates main" | tee -a /etc/apt/sources.list
RUN apt-get update -y && apt-get install -y git wget nano libssl-dev libssl1.0.0 

## Instruction: https://github.com/ENCODE-DCC/chip-seq-pipeline2/blob/master/docs/install_conda.md

## clone pipeline
RUN git clone https://github.com/ENCODE-DCC/chip-seq-pipeline2

## 
RUN  conda config --set auto_activate_base false
RUN  exec bash

## Install pipeline's Conda environment.

RUN bash chip-seq-pipeline2/scripts/uninstall_conda_env.sh
RUN bash chip-seq-pipeline2/scripts/install_conda_env.sh
## WARNING: DO NOT PROCEED TO RUN PIPELINES UNTIL YOU SEE THE FOLLOWING SUCCESS MESSAGE OR PIPELINE WILL NOT WORK.
## === All done successfully ===

SHELL ["conda", "run", "-n", "encode-chip-seq-pipeline", "/bin/bash", "-c"]
RUN pip install caper --upgrade
RUN  caper init local
## RUN conda update  phantompeakqualtools -c bioconda
## RUN pip install caper croo qc2tsv
RUN mkdir -p /root/tmp
## change default.comfig
RUN sed -i 's#tmp-dir=#tmp-dir=/root/tmp#g' /root/.caper/default.conf

## make tutorial folder
RUN mkdir /root/chipseq-run/
WORKDIR /root/chipseq-run/
RUN wget https://raw.githubusercontent.com/tengfei/docker-demo/master/encode-chip-seq-pipeline/test/bip_ENCSR000DYI_subsampled.json
RUN wget https://raw.githubusercontent.com/tengfei/docker-demo/master/encode-chip-seq-pipeline/test/hg38_bip.tsv
RUN wget https://raw.githubusercontent.com/tengfei/docker-demo/master/encode-chip-seq-pipeline/test/bip_ENCSR000DYI.json
RUN wget https://raw.githubusercontent.com/tengfei/docker-demo/master/encode-chip-seq-pipeline/test/bip_ENCSR203KEU.json

ADD caper_run.sh .
ADD download_test_job.sh .



