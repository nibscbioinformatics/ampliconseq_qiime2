#!/usr/bin/env bash

### barplot of taxon abundances (adjust parameters as necessary)

barplot_main(){
	
	plot_abundances

}

plot_abundances(){

#need metadata file

cd ${ANALYSIS_FOLDER}

qiime taxa barplot \
 --i-table ${ANALYSIS_FOLDER}/deblur/filtered_frequency_table/filtered_table.qza \
 --i-taxonomy ${ANALYSIS_FOLDER}/deblur/classification_output/taxonomy.qza \
 --o-visualization ${ANALYSIS_FOLDER}/deblur/barplots.qzv \
 --m-metadata-file  ${TOOLS_FOLDER}/metadata.txt 
}

view_plot(){

qiime tools view ${ANALYSIS_FOLDER}/deblur/barplots.qzv

}

barplot_main