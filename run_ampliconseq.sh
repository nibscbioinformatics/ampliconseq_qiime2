#!/usr/bin/env bash


### Workflow for amplicon sequencing analysis pipeline

## Root folder name
NAME=nibsc_ampliconseq

echo "Please Check File Paths in run_ampliconseq.sh"

## data file locations
READS='/home/AD/mgordon/ampliconseq_qiime2/data/' #change path to you data directory... use $1 for CL input?

## Comment out to remove individual process

ampliconseq_analysis_main(){
   create_folders 
   set_variables # -> Never comment this function
   #fetch_example_data # -> Uncomment this function if you want to run pipeline on test data
   copy_rawdata #large files.. create sys link instead?
   activate_conda 
   import_data 
   run_cutadapt 
   run_joinpairs  
   run_qualityfiltering 
   run_deblur 
   run_classification 
   run_filterfeatures #change to num of samples in your data
   run_viewfeatures #commands work but issues with X11 forwarding for me...
   run_filterabundance
   run_barplot #need metadata file from Chrysi
   echo $LINKPATH_DB
}


create_folders(){

   echo "Creating sub-folders..."

   # Sub-folders in the root folder
   for FOLDER in analysis tools rawdata scripts docs reference
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
   export REFERENCE_FOLDER=$(pwd)/$ROOT_FOLDER_NAME/reference
   export DOCS_FOLDER=$(pwd)//$ROOT_FOLDER_NAME/docs
   export SCRIPT_FOLDER=$(pwd)//$ROOT_FOLDER_NAME/scripts
   export LINKPATH_DB=$LINKPATH_DB

   # soft link classifier to tools folder
   ln -s $(pwd)/docs/silva-138-99-515-806-nb-classifier.qza  ${TOOLS_FOLDER}/

   echo "DONE setting variables for paths!"

}

# copy raw data.. (create link instead to save space?)

copy_rawdata(){

   lst=$(ls -d ${READS}/*.fastq.gz) #make this more robust?
   for file in $lst
   do
      echo "Copying ${file}"
      cp ${file} ${RAWDATA_FOLDER}/
   done
   echo "DONE copying rawdata!"
}

# run pipeline using test data (find suitable test data)

fetch_example_data(){

   mkdir -p $NAME/example_data

   cd $NAME/example_data

   #change eg data
   #wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR114/039/SRR11487939/SRR11487939_1.fastq.gz
   #wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR114/039/SRR11487939/SRR11487939_2.fastq.gz

   SRC_RAWDATA=$NAME/example_data
   cd -
}

# Import data into qiime2

import_data(){
   echo "Importing data to QIMME2"

   . ./scripts/import_data.sh

   echo "DONE Importing!"
   cd -

}


activate_conda(){

   eval "$(conda shell.bash hook)" #conda initilization - more generalisable dont specify conda.sh location
	conda3
   conda activate qiime2

}

# Run qiime2 cutadapt adapter trimming

run_cutadapt(){
   echo "Running Cutadapt Adapter Trimming"

   . ./scripts/run_cutadapt.sh

   echo "DONE Trimming!"
   cd - #prob dont need these if running in analysis folder

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

# Filter the feature table produced by deblur to keep only features appearing in mutiple replicates

run_filterfeatures(){
   echo "Running Feature Filter"

   . ./scripts/run_filtertable.sh

   echo "DONE Feature Filter!"
   cd -
}

# View feature table 

run_viewfeatures(){
   echo "Produce Filter Table"

   . ./scripts/run_viewtable.sh

   echo "DONE Filter Table!"
   cd -
}

# Filter features below 0.05% total abundance 
# this is 1610 for the two samples used but hard coded!!! need to change something here
# try the other filtering function and compare

run_filterabundance(){
   echo " Filter Table Abundances"

   . ./scripts/run_freqfiltering.sh

   echo "DONE Filter Table!"
   cd -
}


run_barplot(){
   echo " Visualising Abundances"

   . ./scripts/run_barplot.sh

   echo "DONE!"
   cd -
}

ampliconseq_analysis_main
