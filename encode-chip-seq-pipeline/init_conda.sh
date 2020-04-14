#!/bin/bash
# activating might now have effect outside script, so run it mannually to activate environment
echo "porting ..."
eval "$(conda shell.bash hook)"

echo "activating encode-chip-seq-pipeline ... "
conda activate encode-chip-seq-pipeline

## put some scripts here 
echo "initializing caper ..."
caper init local