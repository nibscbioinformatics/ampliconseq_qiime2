# filter features not present in all reps and low abundance (< 0.005) features

condfilter_main(){
	
	conditional_filter
	summarise_table
}

conditional_filter(){

cd ${ANALYSIS_FOLDER}
mkdir -p ${ANALYSIS_FOLDER}/deblur/conditional_ftest/

qiime feature-table filter-features-conditionally \
 --i-table ${ANALYSIS_FOLDER}/deblur/table-deblur.qza \
 --p-prevalence 0.999 \
 --p-abundance 0.005 \
 --o-filtered-table ${ANALYSIS_FOLDER}/deblur/conditional_ftest/cond_filtered.qza 

}

summarise_table(){

cd ${ANALYSIS_FOLDER}

qiime feature-table summarize \
--i-table ${ANALYSIS_FOLDER}/deblur/conditional_ftest/cond_filtered.qza \
--o-visualization ${ANALYSIS_FOLDER}/deblur/conditional_ftest/cond_filtered.qzv

}

condfilter_main