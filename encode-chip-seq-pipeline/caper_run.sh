#!/bin/bash
# run those script in your terminal (NOT as shell script) to activate env
echo "porting ..."
eval "$(conda shell.bash hook)"

echo "activating encode-chip-seq-pipeline ... "
conda activate encode-chip-seq-pipeline

echo "running caper ..."
INPUT_JSON=$1
caper run /chip-seq-pipeline2/chip.wdl -i $INPUT_JSON

## organize output
## croo metadata.json --method copy --out-def-json --out-dir /enigma/local_storage/chipseq-run/
## organize qc files
## qc2tsv /sample1/qc.json gs://sample2/qc.json s3://sample3/qc.json ... > spreadsheet.tsv