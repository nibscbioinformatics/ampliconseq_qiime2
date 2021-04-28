#!/usr/bin/env bash

## Filter the deblur feature table to keep only featues present in all samples
## Adjust p-min-samples to your number of samples

tfilter_main(){
	
	filter_table
}

filter_table(){

cd ${ANALYSIS_FOLDER}
# change this function for final (min samples = 5)

qiime feature-table filter-features  \
--i-table ${ANALYSIS_FOLDER}/deblur/table-deblur.qza  \
--p-min-samples 2  \
--o-filtered-table  ${ANALYSIS_FOLDER}/deblur/sample-contingency-filtered-table.qza

}

tfilter_main
