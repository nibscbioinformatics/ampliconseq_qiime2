#!/usr/bin/env bash

# filter out features present low abundance (< 0.005) features

condfilter_main(){
	
	conditional_filter
	summarise_table
}

conditional_filter(){

cd ${ANALYSIS_FOLDER}
mkdir -p ${ANALYSIS_FOLDER}/deblur/filtered_frequency_table/

qiime feature-table filter-features-conditionally \
 --i-table ${ANALYSIS_FOLDER}/deblur/table-deblur.qza \
 --p-prevalence 0 \
 --p-abundance 0.00005 \
 --o-filtered-table ${ANALYSIS_FOLDER}/deblur/filtered_frequency_table/filtered_table.qza 

}

summarise_table(){

cd ${ANALYSIS_FOLDER}

qiime feature-table summarize \
--i-table ${ANALYSIS_FOLDER}/deblur/filtered_frequency_table/filtered_table.qza  \
--o-visualization ${ANALYSIS_FOLDER}/deblur/filtered_frequency_table/filtered_table.qzv 

}

condfilter_main
