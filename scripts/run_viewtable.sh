#!/usr/bin/env bash

### View Filter Table Output (use to inform threshold for )
### Old script -replaced by run_conditionalfilter.sh


viewfilter_main(){
	
	summarise_table
    #view_table #turn this off as stalls the process
}

summarise_table(){

#create visualisation artifact to view output of filtering

cd ${ANALYSIS_FOLDER}

qiime feature-table summarize  \
--i-table ${ANALYSIS_FOLDER}/deblur/sample-contingency-filtered-table.qza  \
--o-visualization ${ANALYSIS_FOLDER}/deblur/sample-contingency-filtered-table.qzv

}

view_table(){

qiime tools view ${ANALYSIS_FOLDER}/deblur/sample-contingency-filtered-table.qzv

}

viewfilter_main
