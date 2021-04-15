#!/usr/bin/env bash

### Cutadapt adapter trimming (adjust parameters as necessary)

cutadapt_main(){
	
        activate_conda_env
	cutadapt_trim

}

activate_conda_env(){
	
        eval "$(conda shell.bash hook)" #conda initilization - more generalisable dont specify conda.sh location
	conda activate qiime2
	
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
