FROM conda/miniconda3

## libssl1.0.0 for ubuntu 18.04 ...
RUN echo "deb http://security.debian.org/debian-security jessie/updates main" | tee -a /etc/apt/sources.list
RUN apt-get update -y && apt-get install -y git wget nano libssl-dev libssl1.0.0 graphviz

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
RUN pip install caper croo qc2tsv --upgrade
RUN  caper init local
## RUN conda update  phantompeakqualtools -c bioconda
## RUN pip install caper croo qc2tsv
RUN mkdir -p /root/tmp
## change default.comfig
RUN sed -i 's#tmp-dir=#tmp-dir=/root/tmp#g' /root/.caper/default.conf

## make tutorial folder
RUN mkdir -p /root/chipseq-run/bin/
ENV PATH "/root/chipseq-run/bin/:$PATH"
WORKDIR /root/chipseq-run/

ADD caper_run.sh /root/chipseq-run/bin/
ADD download_test_job.sh /root/chipseq-run/bin/
RUN chmod +x /root/chipseq-run/bin/*.sh
RUN /root/chipseq-run/bin/download_test_job.sh




