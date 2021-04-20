#!/usr/bin/env bash

### Deblur denoising (adjust parameters as necessary)

deblur_main(){
	
	run_deblur
}

run_deblur(){

cd ${ANALYSIS_FOLDER}
mkdir -p ${ANALYSIS_FOLDER}/deblur

#4 jobs run in parellel 

qiime deblur denoise-16S \
  --i-demultiplexed-seqs ${ANALYSIS_FOLDER}/QC_reads/QC_demux_trimmed-joined.qza \
  --p-trim-length 250  \
  --o-representative-sequences ${ANALYSIS_FOLDER}/deblur/rep-seqs-deblur.qza \
  --o-table ${ANALYSIS_FOLDER}/deblur/table-deblur.qza \
  --p-jobs-to-start 4 \
  --p-sample-stats \
  --o-stats ${ANALYSIS_FOLDER}/deblur/deblur-stats.qza  

}

deblur_main
