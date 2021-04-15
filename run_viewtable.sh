### View Filter Table Output (use to inform threshold for )

viewfilter_main(){
	
    activate_conda_env
	summarise_table
    #view_table #turn this off as stalls the process

}

activate_conda_env(){
	
    eval "$(conda shell.bash hook)" #conda initilization - more generalisable dont specify conda.sh location
	conda activate qiime2
	
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
