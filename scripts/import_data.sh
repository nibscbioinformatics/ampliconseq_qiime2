#!/usr/bin/env bash

# QIIME2 - Import data into QIMME2 framework
# Data types: .qza & .qzv 

input_main(){
	
	import_data

}


import_data(){

#

cd ${ANALYSIS_FOLDER}
mkdir -p ${ANALYSIS_FOLDER}/import_data

qiime tools import  \
 --type 'SampleData[PairedEndSequencesWithQuality]'  \
 --input-format CasavaOneEightSingleLanePerSampleDirFmt  \
 --input-path ${RAWDATA_FOLDER}  \
 --output-path ${ANALYSIS_FOLDER}/import_data/demux.qza 
   
}

input_main
