#!/usr/bin/env bash

set -euo pipefail # error handling

### Workflow for amplicon sequencing analysis pipeline

## Root folder name - folder to store all pipeline output
NAME=NIBSC_CS690_M2R

## PLEASE DO NOT ALTER THIS SECTION! 
## Clean-up from previous run
array=("$(pwd)/${NAME}/analysis" "$(pwd)/${NAME}/rawdata" "$(pwd)/${NAME}/example_data" "$(pwd)/${NAME}/tools")

for dir in "${array[@]}"
do
   if [ -d "$dir" ]; then
      echo "removing $dir"
      rm -r "$dir"
   fi
done 

echo "Please ensure READS filepath is correct in run_ampliconseq.sh"

## data file locations
READS='/FULL/PATH/TO/DIRECTORY' #change full path your data directory (include '/' at end of path)

## Comment out to remove individual process

ampliconseq_analysis_main(){
   create_folders 
   set_variables # -> Never comment this function
  # test_data # -> remove '#' before `test_data` to test pipeline (restore `#``to run your data)
   import_data 
   run_cutadapt 
   run_joinpairs  
   run_qualityfiltering 
   run_deblur 
   run_classification 
   run_conditionalfilter # threshold: retain features detected in all samples & above 0.005% frequency
   run_barplot
}


create_folders(){

   echo "Creating sub-folders..."

   # Sub-folders in the root folder
   for FOLDER in analysis tools rawdata
   do
      mkdir -p ${NAME}/${FOLDER}
   done

   echo "DONE creating sub-folders!"
}


# setting variable path
set_variables(){
   echo "Setting variables for paths..."

   export ROOT_FOLDER_NAME=${NAME}
   export TOOLS_FOLDER=$(pwd)/$ROOT_FOLDER_NAME/tools
   export RAWDATA_FOLDER=$(pwd)/$ROOT_FOLDER_NAME/rawdata
   export ANALYSIS_FOLDER=$(pwd)/$ROOT_FOLDER_NAME/analysis
  
   #soft link files 
   echo "Lnking Folders"
   ln -s -fs $(pwd)/docs/silva-138-99-515-806-nb-classifier.qza  ${TOOLS_FOLDER}/
   ln -s -fs ${READS}/*.fastq.gz ${RAWDATA_FOLDER}
   ln -s -fs $(pwd)/docs/metadata.txt  ${TOOLS_FOLDER}/

   #echo "DONE linking folders!"
}

# run pipeline using test data

test_data(){

   echo "Copying test data.."

   mkdir -p ${ROOT_FOLDER_NAME}/example_data
   export RAWDATA_FOLDER=$(pwd)/${ROOT_FOLDER_NAME}/example_data #change input folder to example
   cd ${RAWDATA_FOLDER}

#   cp /usr/share/sequencing/miseq/output/200325_M01745_0264_000000000-CPKV4/Data/Intensities/BaseCalls/323-FD2a_S62_L001_R1_001.fastq.gz .
#   cp /usr/share/sequencing/miseq/output/200325_M01745_0264_000000000-CPKV4/Data/Intensities/BaseCalls/323-FD2a_S62_L001_R2_001.fastq.gz .
#   cp /usr/share/sequencing/miseq/output/200325_M01745_0264_000000000-CPKV4/Data/Intensities/BaseCalls/323-FD2b_S63_L001_R1_001.fastq.gz .
#   cp /usr/share/sequencing/miseq/output/200325_M01745_0264_000000000-CPKV4/Data/Intensities/BaseCalls/323-FD2b_S63_L001_R2_001.fastq.gz .

   curl -OJL https://sra-download.ncbi.nlm.nih.gov/traces/sra18/SRZ/014462/SRR14462031/323-FD2b_S63_L001_R1_001.fastq.gz . 
   curl -OJL https://sra-download.ncbi.nlm.nih.gov/traces/sra18/SRZ/014462/SRR14462031/323-FD2b_S63_L001_R2_001.fastq.gz . 
   curl -OJL https://sra-download.ncbi.nlm.nih.gov/traces/sra9/SRZ/014462/SRR14462032/323-FD2a_S62_L001_R1_001.fastq.gz . 
   curl -OJL https://sra-download.ncbi.nlm.nih.gov/traces/sra9/SRZ/014462/SRR14462032/323-FD2a_S62_L001_R2_001.fastq.gz . 
   
   cd -

   echo "DONE copying test data"
}

# Import data into qiime2

import_data(){
   echo "Importing data to QIMME2"

   . ./scripts/import_data.sh

   echo "DONE Importing!"
   cd -

}

# Run qiime2 cutadapt adapter trimming

run_cutadapt(){
   echo "Running Cutadapt Adapter Trimming"

   . ./scripts/run_cutadapt.sh

   echo "DONE Trimming!"
   cd - 

}

# Run read pair merging using VSEARCH

run_joinpairs(){
   echo "Running Read Merging"

   . ./scripts/run_joinpairs.sh

   echo "DONE Merging!"
   cd -
}

#  Run additional quality filtering step

run_qualityfiltering(){
   echo "Running Quality Filtering"

   . ./scripts/run_qualfiltering.sh

   echo "DONE Quality Filtering!"
   cd -
}

#  Run deblur denoising method

run_deblur(){
   echo "Running Deblur"

   . ./scripts/run_deblur.sh

   echo "DONE Deblur!"
   cd -
}

#  Run classification using pretrained naive bayes classifer (SILVA DB)

run_classification(){
   echo "Running Classification"
   
   . ./scripts/run_classification.sh

   echo "DONE Classification!"
   cd -
}

# depreciated script.. see run_conditionalfilter.sh

run_filterfeatures(){
   echo "Running Feature Filter"

   . ./scripts/run_filtertable.sh

   echo "DONE Feature Filter!"
   cd -
}

 # depreciated script.. see run_conditionalfilter.sh

run_viewfeatures(){
   echo "Produce Filter Table"

   . ./scripts/run_viewtable.sh

   echo "DONE Filter Table!"
   cd -
}

# depreciated script.. see run_conditionalfilter.sh

run_filterabundance(){
   echo " Filter Table Abundances"

   . ./scripts/run_freqfiltering.sh

   echo "DONE Filter Table!"
   cd ../../
}

# Remove features not in all samples and below 0.005% total abundance 

run_conditionalfilter(){

   echo 'Conditional filter test'

   . ./scripts/run_conditionalfilter.sh

   echo 'DONE Conditional Filter!'
   cd ../../
}

# Visualise estimated abundances

run_barplot(){
   echo " Visualising Abundances"

   . ./scripts/run_barplot.sh

   echo "DONE!"
   cd -
}

ampliconseq_analysis_main
