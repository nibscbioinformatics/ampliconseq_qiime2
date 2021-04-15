#!/usr/bin/env bash

### quality filtering (adjust parameters as necessary)

qfilter_main(){
	
        activate_conda_env
	quality_filter

}

activate_conda_env(){
	
        eval "$(conda shell.bash hook)" #conda initilization - more generalisable dont specify conda.sh location
	conda activate qiime2
	
}

quality_filter(){

cd ${ANALYSIS_FOLDER}
mkdir -p ${ANALYSIS_FOLDER}/QC_reads

qiime quality-filter q-score  \
 --i-demux ${ANALYSIS_FOLDER}/joined_reads/joined_sequences.qza \
 --o-filtered-sequences ${ANALYSIS_FOLDER}/QC_reads/QC_demux_trimmed-joined.qza \
 --o-filter-stats ${ANALYSIS_FOLDER}/QC_reads/qc_demux_stats.qza 

}

qfilter_main
