FROM ubuntu:18.04

## libssl1.0.0 for ubuntu 18.04 ...
RUN apt-get update -y && apt-get install -y git wget gnupg
RUN echo "deb http://security.debian.org/debian-security jessie/updates main" | tee -a /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9D6D8F6BC857C906 AA8E81B4331F7F50
RUN apt-get update -y && apt-get install -y libssl1.0.0

## clone pipeline
RUN git clone https://github.com/ENCODE-DCC/chip-seq-pipeline2

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

## Install pipeline's Conda environment.
RUN bash chip-seq-pipeline2/scripts/uninstall_conda_env.sh
RUN bash chip-seq-pipeline2/scripts/install_conda_env.sh
## WARNING: DO NOT PROCEED TO RUN PIPELINES UNTIL YOU SEE THE FOLLOWING SUCCESS MESSAGE OR PIPELINE WILL NOT WORK.
## === All done successfully ===
## Activate pipeline's Conda environment before running a pipeline.
## below works as 'RUN conda activate encode-chip-seq-pipeline' in dockerfile
SHELL ["conda", "run", "-n", "encode-chip-seq-pipeline", "/bin/bash", "-c"]
RUN apt-get install -y graphviz
RUN pip uninstall -y caper croo
RUN pip install caper==0.7.0 croo==0.3.4 qc2tsv 
RUN caper init local
## need to change default of tmp, cannot be /tmp
RUN mkdir -p /root/tmp
## change default.comfig
RUN sed -i 's#tmp-dir=#tmp-dir=/root/tmp#g' /root/.caper/default.conf

## make tutorial folder
RUN mkdir -p /root/chipseq-run/bin/
WORKDIR /root/chipseq-run/

## add scripts
ADD caper_run.sh /usr/local/bin/
ADD download_test_job.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/caper_run.sh /usr/local/bin/download_test_job.sh

## download test json file and tsv
RUN download_test_job.sh





