#!/usr/bin/env bash

### Cutadapt adapter trimming (adjust parameters as necessary)

join_main(){
	
        activate_conda_env
	join_pairs

}

activate_conda_env(){
	
        eval "$(conda shell.bash hook)" #conda initilization - more generalisable dont specify conda.sh location
	conda activate qiime2
	
}

join_pairs(){

cd ${ANALYSIS_FOLDER}

qiime vsearch join-pairs \
 --i-demultiplexed-seqs  ${ANALYSIS_FOLDER}/cutadapt_trimmed_reads/trimmed_sequences.qza \
 --output-dir ${ANALYSIS_FOLDER}/joined_reads

}

join_main
