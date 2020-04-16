#!/bin/bash
# run those script in your terminal (NOT as shell script) to activate env
echo "porting ..."
eval "$(conda shell.bash hook)"

echo "activating encode-chip-seq-pipeline ... "
conda activate encode-chip-seq-pipeline

echo "running caper ..."
INPUT_JSON=$1
caper run /chip-seq-pipeline2/chip.wdl -i $INPUT_JSON

## Organize output
## WARNING: by default if multiple task found, using latest one, manually specify one to collect if needed
## this is used for automation assuming only one task executed. 
METAFILE=$(ls -t ~/chipseq-run/chip/*/metadata.json| head -1)
croo $METAFILE --method copy  --out-dir /enigma/local_storage/chipseq-run/
## organize qc files into single tsv file
## hard coded for demo purse
qc2tsv /enigma/local_storage/chipseq-run/qc/qc.json > /enigma/local_storage/chipseq-run/qc-all.tsv