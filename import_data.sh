#!/usr/bin/env bash

### QIIME2 - Import data into QIMME2 framework
## First activate conda environment (perhaps do in parent script just the once?)

input_main(){
	
        activate_conda_env
	import_data

}

activate_conda_env(){
	
        eval "$(conda shell.bash hook)" #conda initilization - more generalisable dont specify conda.sh location
	conda activate qiime2
	
}

import_data(){

#qiime2 seems very simple - just provide path to data

cd ${ANALYSIS_FOLDER}
mkdir -p ${ANALYSIS_FOLDER}/import_data

qiime tools import  \
 --type 'SampleData[PairedEndSequencesWithQuality]'  \
 --input-format CasavaOneEightSingleLanePerSampleDirFmt  \
 --input-path ${RAWDATA_FOLDER}  \
 --output-path ${ANALYSIS_FOLDER}/import_data/demux.qza 
   
}

input_main
