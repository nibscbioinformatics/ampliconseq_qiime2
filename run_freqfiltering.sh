#!/usr/bin/env bash

### frequency filtering (adjust parameters as necessary)

freqfilter_main(){
	
    activate_conda_env
	abundance_filter
    summarise_table
   # view_table #activate when x11 forwarding sorted

}

activate_conda_env(){
	
    eval "$(conda shell.bash hook)" #conda initilization - more generalisable dont specify conda.sh location
	conda activate qiime2
	
}

abundance_filter(){

#change the filter value to remove features < 0.05% total abundance

cd ${ANALYSIS_FOLDER}

qiime feature-table filter-features \
  --i-table ${ANALYSIS_FOLDER}/deblur/sample-contingency-filtered-table.qza \
  --p-min-frequency 1610 \
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

