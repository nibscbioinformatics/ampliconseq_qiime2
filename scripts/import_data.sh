#!/usr/bin/env bash

# QIIME2 - Import data into QIMME2 framework as an artifact (.qza)
# Data types are artifacts (data + metadata - `.qza` extension) or visualisations (plots, tables etc. - `.qvz` extension).
#input data: Illumina demultiplexed PE fastq (see docs for other input type options)

input_main(){
	
	import_data

}


import_data(){

cd ${ANALYSIS_FOLDER}
mkdir -p ${ANALYSIS_FOLDER}/import_data

qiime tools import  \
 --type 'SampleData[PairedEndSequencesWithQuality]' \ 
 --input-path ${RAWDATA_FOLDER}  \
 --output-path ${ANALYSIS_FOLDER}/import_data/demux.qza 
   
}

input_main
