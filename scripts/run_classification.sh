#!/usr/bin/env bash

### Strain Classification Using Pre-trained Classifier 

classification_main(){

	run_classification
}

run_classification(){

#Provide classifier to the end users 
# -1 all CPUs used for this step

cd ${ANALYSIS_FOLDER}
mkdir -p ${ANALYSIS_FOLDER}/deblur/classification_output

qiime feature-classifier classify-sklearn  \
 --i-classifier ${TOOLS_FOLDER}/silva-138-99-515-806-nb-classifier.qza  \
 --i-reads ${ANALYSIS_FOLDER}/deblur/rep-seqs-deblur.qza  \
 --o-classification ${ANALYSIS_FOLDER}/deblur/classification_output/taxonomy.qza  \
 #--output-dir ${ANALYSIS_FOLDER}/deblur/classification_output  \
 --p-n-jobs -1 

}

classification_main
