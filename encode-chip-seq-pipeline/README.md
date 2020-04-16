## Requirements

1. Please check and edit the [hg38_bip.tsv](https://github.com/tengfei/docker-demo/blob/master/encode-chip-seq-pipeline/test/hg38_bip.tsv) under the `test` folder, to make sure the absolute path is correct for all mounted files

2. Please check and edit the **input job json** under `test` folder, make sure the absolute path for your data is correct 

3. WARNING: `caper init local` used, so only local mode now. 

## Prepare docker runner

1. Mount datasets "ENCODE"
2. Use image "tengfei/encode-chip-seq-pipeline"
3. Instance type "c5.xlarge"
4. Initial command "/bin/bash"

## Docker runner ready

This will create an envinronment with conda and everything ENCODE use for chip-seq analysis. User will be landing in a working folder `/root/chipseq-run/`. And in subfolder `/root/chipseq-run/bin/` you will find our main wrapping script `caper_run.sh` 

What it does? it's a wrapper for following steps:

1. setup environment and activate 
2. run `caper run`
3. run `croo` to organize outputs
4. run `qc2tsv` to organize qc files into single tsv file

How to use?

- it accepts one required positional argument: input job json, you will find couple `/root/chipseq-run/`
- it accepts second optional positional argument: output folder will be available under `/enigma/local_storage/` by default, if will create a folder where you execute your command, if you execute your command in `/root/chipseq-run/` directly, it will collect outputs into `/enigma/local_storage/chipseq-run/`. Because we will be running multiple example, so we create folder for each example and run exmaple code from there. See below. 

## Test run

```
## you should be here by default
cd /root/chipseq-run/

## make one job folder that will contain all cromwell execution result 
mkdir ENCSR000DYI_subsampled_truerep
cd ENCSR000DYI_subsampled_truerep

## execute caper_run.sh in this folder
nohup caper_run.sh /root/chipseq-run/bip_ENCSR000DYI_subsampled_truerep.json &
```

## Check outputs 

The results should be collected based on metadata.json and all in `/enigma/local_storage/ENCSR000DYI_subsampled_truerep/` you can archive the outputs and check results. 