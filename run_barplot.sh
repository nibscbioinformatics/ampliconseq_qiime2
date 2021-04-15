### barplot of abundances (adjust parameters as necessary)

barplot_main(){
	
    activate_conda_env
	plot_abundances
    #view_plot

}

activate_conda_env(){
	
    eval "$(conda shell.bash hook)" #conda initilization - more generalisable dont specify conda.sh location
	conda activate qiime2
	
}

plot_abundances(){

#where is this metadata file

cd ${ANALYSIS_FOLDER}

qiime taxa barplot \
 --i-table ${ANALYSIS_FOLDER}/deblur/final-filtered-table.qza \
 --i-taxonomy ${ANALYSIS_FOLDER}/deblur/taxonomy.qza \
 --o-visualization ${ANALYSIS_FOLDER}/deblur/barplots.qzv \
 #--m-metadata-file ${ANALYSIS_FOLDER}/metadata.txt get this file

}

view_plot(){

qiime tools view ${ANALYSIS_FOLDER}/deblur/barplots.qzv

}

barplot_main