#!/usr/bin/env bash

### Cutadapt adapter trimming (adjust parameters as necessary)

cutadapt_main(){
	
	cutadapt_trim
}

cutadapt_trim(){

cd ${ANALYSIS_FOLDER}
mkdir -p ${ANALYSIS_FOLDER}/cutadapt_trimmed_reads

qiime cutadapt  trim-paired  \
 --i-demultiplexed-sequences ${ANALYSIS_FOLDER}/import_data/demux.qza \
 --p-cores 4 \
 --p-adapter-f GTGYCAGCMGCCGCGGTAA...ATTAGAWACCCBNGTAGTCC \
 --p-adapter-r GGACTACNVGGGTWTCTAAT...TTACCGCGGCKGCTGRCAC \
 --o-trimmed-sequences ${ANALYSIS_FOLDER}/cutadapt_trimmed_reads/trimmed_sequences.qza

}

cutadapt_main
