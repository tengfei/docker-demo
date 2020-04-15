#!/bin/bash
mkdir ~/chipseq-run/
cd ~/chipseq-run/
wget https://raw.githubusercontent.com/tengfei/docker-demo/master/encode-chip-seq-pipeline/test/bip_ENCSR000DYI_subsampled.json
wget https://raw.githubusercontent.com/tengfei/docker-demo/master/encode-chip-seq-pipeline/test/hg38_bip.tsv
## nohup caper run /chip-seq-pipeline2/chip.wdl -i bip_ENCSR000DYI_subsampled.json  &

mkdir -p /enigma/local_storage/chipseq-run/
cd /enigma/local_storage/chipseq-run/
wget https://raw.githubusercontent.com/tengfei/docker-demo/master/encode-chip-seq-pipeline/test/bip_local_ENCSR000DYI_subsampled.json
wget https://raw.githubusercontent.com/tengfei/docker-demo/master/encode-chip-seq-pipeline/test/hg38_bip.tsv

## organize output
## croo metadata.json --method copy --out-def-json --out-dir /enigma/local_storage/chipseq-run/
## organize qc files
## qc2tsv /sample1/qc.json gs://sample2/qc.json s3://sample3/qc.json ... > spreadsheet.tsv