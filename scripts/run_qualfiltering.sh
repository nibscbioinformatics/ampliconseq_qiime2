#!/usr/bin/env bash

### quality filtering (adjust parameters as necessary)

qfilter_main(){
	
	quality_filter
}

quality_filter(){

cd ${ANALYSIS_FOLDER}
mkdir -p ${ANALYSIS_FOLDER}/QC_reads

qiime quality-filter q-score \
 --i-demux ${ANALYSIS_FOLDER}/joined_reads/joined_sequences.qza \
 --o-filtered-sequences ${ANALYSIS_FOLDER}/QC_reads/QC_demux_trimmed-joined.qza \
 --o-filter-stats ${ANALYSIS_FOLDER}/QC_reads/qc_demux_stats.qza 

}

qfilter_main
