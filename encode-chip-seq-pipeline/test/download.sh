#!/bin/bash

wget https://raw.githubusercontent.com/tengfei/docker-demo/master/encode-chip-seq-pipeline/test/bip_ENCSR000DYI_subsampled.json
wget https://raw.githubusercontent.com/tengfei/docker-demo/master/encode-chip-seq-pipeline/test/hg38_bip.tsv
nohup caper run /chip-seq-pipeline2/chip.wdl -i bip_ENCSR000DYI_subsamped.json  &