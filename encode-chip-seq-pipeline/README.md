## Introduction

This is an effort to create a docker image that contains the whole conda-based enviroment setup to execute full [the ENCODE Transcription Factor and Histone ChIP-Seq processing pipeline](https://github.com/ENCODE-DCC/chip-seq-pipeline2) which implemented in WDL/Cromwell/Caper. Installation is geenrally following instruction [encode](https://github.com/ENCODE-DCC/chip-seq-pipeline2#installation)[conda](https://github.com/ENCODE-DCC/chip-seq-pipeline2/blob/master/docs/install_conda.md)

## Major Changes

Following changes might not be needed in the future

- Silently install miniconda3 and activate via a differenet approach for dockerfile 
- libssl1.0.0 for ubuntu 18.04 install (for some unsolved bugs)
- `pip install caper==0.7.0 croo==0.3.4 qc2tsv` a special versino to overcome latest `autouri` error. 
- `caper init local` automatically to prepare 
- Udpate `/root/.caper/default.conf` tmp file to `/root/tmp`


## Requirements

1. Please check and edit the [hg38_bip.tsv](https://github.com/tengfei/docker-demo/blob/master/encode-chip-seq-pipeline/test/hg38_bip.tsv) under the `test` folder, to make sure the absolute path is correct for all mounted files

2. Please check and edit the **input job json** under `test` folder, make sure the absolute path for your data is correct 

3. WARNING: `caper init local` used, so only local mode now. 

## Prepare docker runner

1. Mount datasets "ENCODE"
2. Use image "tengfei/encode-chip-seq-pipeline"
3. Instance type "r5.4xlarge" 16cpu + 128G (assuming, 2 rep *2)
4. Initial command "/bin/bash"

## Docker runner ready

This will create an envinronment with conda and everything ENCODE use for chip-seq analysis. User will be landing in a working folder `/root/chipseq-run/`. And in subfolder `/root/chipseq-run/bin/` you will find our main wrapping script `caper_run.sh` 

What it does? it's a wrapper for following steps:

1. setup environment and activate 
2. run `caper run`
3. run `croo` to organize outputs
4. run `qc2tsv` to organize qc files into single tsv file

How to use `caper_run.sh`?

- it accepts one required positional argument: input job json, you will find couple `/root/chipseq-run/`
- it accepts second optional positional argument: output folder will be available under `/enigma/local_storage/` by default, if will create a folder where you execute your command, if you execute your command in `/root/chipseq-run/` directly, it will collect outputs into `/enigma/local_storage/chipseq-run/`. Because we will be running multiple example, so we create folder for each example and run exmaple code from there. See below. 

## Test run example

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

## About input JSON 

Please check official [Input JSON manaual](https://github.com/ENCODE-DCC/chip-seq-pipeline2/blob/master/docs/input.md) as reference or a [shorter version](https://github.com/ENCODE-DCC/chip-seq-pipeline2/blob/master/docs/input_short.md) as checklist. Some JSON examples are provided ([minimum](https://github.com/ENCODE-DCC/chip-seq-pipeline2/blob/master/example_input_json/template.json) and [full](https://github.com/ENCODE-DCC/chip-seq-pipeline2/blob/master/example_input_json/template.full.json)) 

> An input JSON file is a file which must include all the information needed to run this pipeline. Hence, it must include the absolute paths to all the control and experimental fastq files; paths to all the genomic data files needed for this pipeline, and it must also specify the parameters and the metadata needed for running this pipeline. If the parameters are not specified in an input JSON file, default values will be used. We provide a set of template JSON files: minimum and full. We recommend to use a minimum template instead of full one. A full template includes all parameters of the pipeline with default values defined. 

> **IMPORTANT: ALWAYS USE ABSOLUTE PATHS.**

FOR platform maintainer, I picked some key input worth exposing

### Pipeline metadata

Parameter|Description
---------|-----------
`chip.title`| Title for experiment which will be shown in a final HTML report
`chip.description`| Description for experiment which will be shown in a final HTML report

### Pipeline parameters

**IMPORTANT** changed `chip.true_rep_only` to `true`, official default is `false`

Parameter|Default|Description
---------|-------|-----------
`chip.pipeline_type`| `tf` | `tf` for TF ChIP-seq or `histone` for Histone ChIP-seq.
`chip.true_rep_only` | false | Disable pseudo replicate generation and all related analyses

### Reference genome

UI could use `hg38` and `hg19` to automatically change following parameters, because it need to make sure genome_tsv has correct path to all files. 

`chip.genome_tsv`| File | Choose one of the TSV files listed below or build your own

### Input genomic data

Parameter|Description
---------|-----------
`chip.paired_end`| Boolean to define endedness for ALL IP replicates. This will override per-replicate definition in `chip.paired_ends`
`chip.ctl_paired_end`| Boolean to define endedness for ALL control replicates. This will override per-replicate definition in `chip.ctl_paired_ends`


Pipeline can start from any of the following data type (FASTQ, BAM, NODUP_BAM and TAG-ALIGN). But you can start fro fastq

Parameter|Description
---------|-----------
`chip.fastqs_repX_R1`| Array of R1 FASTQ files for replicate X. These files will be merged into one FASTQ file for rep X.
`chip.fastqs_repX_R2`| Array of R2 FASTQ files for replicate X. These files will be merged into one FASTQ file for rep X. Do not define for single ended dataset. 



For controls:

Parameter|Description
---------|-----------
`chip.ctl_fastqs_repX_R1`| Array of R1 FASTQ files for control replicate X. These files will be merged into one FASTQ file for rep X.
`chip.ctl_fastqs_repX_R2`| Array of R2 FASTQ files for control replicate X. These files will be merged into one FASTQ file for rep X. Do not define for single ended dataset. 


## Optional mapping parameters

Parameter|Type|Default|Description
---------|---|----|-----------
`chip.aligner` | String | bowtie2 | Currently supported aligners: bwa and bowtie2. 
`chip.use_bwa_mem_for_pe` | Boolean | false | Currently supported aligners: bwa and bowtie2. To use your own custom aligner, see the below parameter.

## Optional filtering parameters

Parameter|Default|Description
---------|-------|-----------
`chip.mapq_thresh` | 30 for bwa, 255 for bowtie2 | Threshold for mapped reads quality (samtools view -q). If not defined, automatically determined according to aligner.


## Optional control parameters

Parameter|Default|Description
---------|-------|-----------
`chip.always_use_pooled_ctl` | false | Choosing an appropriate control for each replicate. Always use a pooled control to compare with each replicate. If a single control is given then use it.

## Optional peak-calling parameters

Parameter|Default|Description
---------|-------|-----------
`chip.cap_num_peak_macs2` | 500000 | Cap number of peaks called from a peak-caller (MACS2)
`chip.pval_thresh` | 0.01 | P-value threshold for peak-caller MACS2 (macs2 callpeak -p).
`chip.idr_thresh` | 0.05 | IDR (irreproducible discovery rate) threshold.
`chip.fdr_thresh` | 0.01 | FDR threshold for peak-caller SPP (run_spp.R -fdr=).
`chip.cap_num_peak_spp` | 300000 | Cap number of peaks called from a peak-caller (SPP)

## Suggestion
 
Allow user to upload a job JSON that will overide or add additional parameters, except input files and genome_tsv (hardcoded locally for mounted files). For example, if our default job json is `default.json`, this will be merged and updated by user's own `new.json` file before execution with `caper_run.sh`. 
