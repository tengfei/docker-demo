#!/bin/bash
## Step1: activating conda env
## Run those script in your terminal (NOT as shell script) to activate env
echo "porting ..."
eval "$(conda shell.bash hook)"
echo "activating encode-chip-seq-pipeline ... "
conda activate encode-chip-seq-pipeline

## Step2: caper run the wdl file with input json
echo "running caper ..."
INPUT_JSON=$1
caper run /chip-seq-pipeline2/chip.wdl -i $INPUT_JSON

## Step3: croo to organize output
## WARNING: by default if multiple task found, using latest one, manually specify one to collect if needed
## This is used for automation assuming only one task executed. 
## Assume it's in the folder where this script is executed e.g. in default ~/chipseq-run/
echo "croo is collecting outputs"
METAFILE=$(ls -t ./chip/*/metadata.json| head -1)
OUTDIR_BASE=$(basename $(pwd))
## use default current folder name or use second parameters to specify output folder in local_storage
OUTDIR=${2:-/enigma/local_storage/$OUTDIR_BASE}
OUTDIR=$(realpath $OUTDIR)
croo $METAFILE --method copy  --out-dir $OUTDIR 

## Step4: qc2tsv to organize qc files into single tsv file
qc2tsv $OUTDIR/qc/qc.json > $OUTDIR/qc/qc-all.tsv