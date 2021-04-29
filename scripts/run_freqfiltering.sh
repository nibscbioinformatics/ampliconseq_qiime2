#!/usr/bin/env bash

## frequency filtering (adjust parameters as necessary)
## remove features < 0.005% total abundance
## Old script - replaced by run_conditionalfilter.sh


freqfilter_main(){
	
	abundance_filter
    summarise_table
   # view_table #uncomment if X11 forwarding enabled

}

abundance_filter(){

cd ${ANALYSIS_FOLDER}

qiime feature-table filter-features \
  --i-table ${ANALYSIS_FOLDER}/deblur/sample-contingency-filtered-table.qza \
  --p-min-frequency  \
  --o-filtered-table ${ANALYSIS_FOLDER}/deblur/final-filtered-table.qza

}

summarise_table(){

#create visualisation artifact to view output of filtering

cd ${ANALYSIS_FOLDER}

qiime feature-table summarize  \
--i-table ${ANALYSIS_FOLDER}/deblur/final-filtered-table.qza  \
--o-visualization ${ANALYSIS_FOLDER}/deblur/final-filtered-table.qzv

}

view_table(){

qiime tools view ${ANALYSIS_FOLDER}/deblur/final-filtered-table.qzv

}

freqfilter_main

