#!/bin/bash

## example 1: ENCSR000DYI subsample: single end - TF
cd /root/chipseq-run/
## make one job folder that will contain all cromwell execution result 
mkdir ENCSR000DYI_subsampled_truerep
cd ENCSR000DYI_subsampled_truerep
## execute caper_run.sh in this folder
nohup caper_run.sh /root/chipseq-run/bip_ENCSR000DYI_subsampled_truerep.json &

## example 2: ENCSR000DYI full run: single end - TF
cd /root/chipseq-run/   
mkdir ENCSR000DYI
cd ENCSR000DYI
nohup caper_run.sh /root/chipseq-run/bip_ENCSR000DYI.json  &

## example 3: ENCSR000DYI full run: paired end - histone
cd /root/chipseq-run/ 
mkdir ENCSR203KEU
cd ENCSR203KEU/
nohup caper_run.sh /root/chipseq-run/bip_ENCSR203KEU.json  &