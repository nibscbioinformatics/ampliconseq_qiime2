# filter features not present in all reps and low abundance (< 0.005) features


condfilter_main(){
	
    activate_conda_env
	conditional_filter

}

activate_conda_env(){
	
    eval "$(conda shell.bash hook)" #conda initilization - more generalisable dont specify conda.sh location
	conda activate qiime2
	
}

conditional_filter(){

cd ${ANALYSIS_FOLDER}
mkdir -p ${ANALYSIS_FOLDER}/deblur/conditional_ftest/

qiime feature-table filter-features-conditionally  \
 --i-demux ${ANALYSIS_FOLDER}/deblur/joined_sequences.qza \
 --o-filtered-sequences ${ANALYSIS_FOLDER}/deblur/conditional_ftest/QC_demux_trimmed-joined.qza \
 --o-filter-stats ${ANALYSIS_FOLDER}/deblur/conditional_ftest/qc_demux_stats.qza 

}

condfilter_main