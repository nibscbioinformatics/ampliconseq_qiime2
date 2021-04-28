#!/usr/bin/env bash

### Cutadapt adapter trimming (adjust parameters as necessary)

cutadapt_main(){
	
	cutadapt_trim
}

cutadapt_trim(){

cd ${ANALYSIS_FOLDER}

qiime cutadapt  trim-paired  \
 --i-demultiplexed-sequences ${ANALYSIS_FOLDER}/import_data/demux.qza \
 --p-cores 4 --verbose  \
 --p-adapter-f GTGYCAGCMGCCGCGGTAA...ATTAGAWACCCBNGTAGTCC  \
 --p-adapter-r GGACTACNVGGGTWTCTAAT...TTACCGCGGCKGCTGRCAC \
 --output-dir ${ANALYSIS_FOLDER}/cutadapt_trimmed_reads

}

cutadapt_main
