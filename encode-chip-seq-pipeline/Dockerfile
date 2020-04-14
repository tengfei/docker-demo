FROM conda/miniconda3
RUN apt-get update -y && apt-get install -y git
## Instruction: https://github.com/ENCODE-DCC/chip-seq-pipeline2/blob/master/docs/install_conda.md

## clone pipeline
RUN git clone https://github.com/ENCODE-DCC/chip-seq-pipeline2

## Disable auto activation of base Conda enrivonment
RUN  conda config --set auto_activate_base false
## Install pipeline's Conda environment.
RUN bash chip-seq-pipeline2/scripts/uninstall_conda_env.sh
RUN bash chip-seq-pipeline2/scripts/install_conda_env.sh
## WARNING: DO NOT PROCEED TO RUN PIPELINES UNTIL YOU SEE THE FOLLOWING SUCCESS MESSAGE OR PIPELINE WILL NOT WORK.
## === All done successfully ===

RUN conda activate encode-chip-seq-pipeline

## install caper / croo / qc2tsv AGAIN 
RUN pip install caper croo qc2tsv

RUN caper init local