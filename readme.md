## Reason to use public docker registry

- Tons of published thrid party apps developed and maintained by the author or offiical organization directly
- Global mirror
- "The place" to develop, maintain and/or publish your script and work officially
- Could be pulled and used on many platform directly 
- Better integration with other environment, e.g. your github account.

## Prerequisite

- User have dockerhub account
- (optional) user have github account
- (optinoal) User have local docker client for testing purpose

## Case 1: Use existing public docker image that contains the tools you need

1. Use [dockerhub](https://hub.docker.com/) for example, search for keyword like "fastqc"
2. Find a source you can trust: official build and maintained by author, or third repos, for example, you can find official GATK 4.1 docker image `broadinstitute/gatk:4.1.4.0` on dockerhub or ENCODE chip-seq container at `quay.io/encode-dcc/chip-seq-pipeline:v1.3.6` at quay. 
3. For testing purpose,  we can use `biocontainers/fastqc:v0.11.8dfsg-2-deb_cv1` which read a fastq and output qc report. 

## Case 2: Build your own tool quickly based on official or good quality docker image 

1. Choose base image: for example "ubuntu:18.04" or "bioconda/bioconda-utils-build-env"
2. Create Dockerfile to explain how the image will be created (bunch of bash script)
- Install third party app directly following their manual ([samtool example](https://github.com/tengfei/docker-demo/tree/master/samtools-bioconda-install) or more complicated [arcasHLA example](https://github.com/tengfei/docker-demo/tree/master/arcasHLA))
- Or add your own script to your docker image ([IEHC WGBS bamstats.py exmaple](https://github.com/tengfei/docker-demo/tree/master/ihec) )
3. (optional) Build docker image locally and test the image make sure you can execute the script
- code example to build 
```
docker build --tag bamstats:1.0 .
```
- code example to run your docker image interactively 
```
docker run -ti bioconda/bioconda-utils-build-env /bin/bash
```
4. Push to dockerhub 
- Link your github repo that contaning dockerfile for autobuild on dockerhub
- Or use command line to push it manually. Example 
```
docker push bamstats:1.0
```