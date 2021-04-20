# filter features not present in all reps and low abundance (< 0.005) features


condfilter_main(){
	
	conditional_filter
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