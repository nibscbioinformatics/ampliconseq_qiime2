<img src="https://static.wixstatic.com/media/e40e76_52d2db31e5264d31aaea0319cb583acf~mv2.png/v1/fill/w_380,h_358,al_c,q_85,usm_0.66_1.00_0.01/NIBSC%20square.webp" alt="Logo of the project" align="right">

# NIBSC 16S Amplicon Sequencing Pipeline  &middot; 
[![Build Status](https://img.shields.io/travis/npm/npm/latest.svg?style=flat-square)](https://travis-ci.org/npm/npm) 
> QIIME2 16S Taxonomic Classification  

This pipeline takes raw Illumina paired-end fastq reads as input, performs adapter & primer trimming, read merging, quality trimming, deblur feature identification and taxonomic classification of features using a Naive Bayes Classifer trained on the SILVA 138 release.

## Prerequisites

The following is required to run this pipeline:
- x86_64 Linux OS
- Conda ((If not installed see [here](https://conda.io/projects/conda/en/latest/user-guide/install/index.html) ))
- Paired-end Illumina fastq files 

## Getting Started

1. Clone the github directory and `cd` into it:
```
git clone https://github.com/nibscbioinformatics/ampliconseq_qiime2.git \
cd ampliconseq_qiime2/
``` 

2. Download the pre-trained classifer and place in docs folder:

```
wget https://data.qiime2.org/2021.2/common/silva-138-99-515-806-nb-classifier.qza
mv silva-138-99-515-806-nb-classifier.qza docs/
```

3. Acitvate conda & build the conda qiime2 environment:
```
conda activate
conda env create -n qiime2 --file docs/qiime2.yml
```

4. Activate the Qiime2 environment:
```
conda activate qiime2
```

5. Provide the full path to your reads folder by editing the READS variable in the `run_ampliconseq.sh` script :

**IMPORTANT! Please only edit `READS`and uncomment `test_data` function (if you want to test pipeline) as shown - do not alter other sections of the `run_ampliconseq.sh` script!**

```
#!/usr/bin/env bash
### Workflow for amplicon sequencing analysis pipeline

## Root folder name
NAME=nibsc_ampliconseq

echo "Please Check File Paths in run_ampliconseq.sh"

## data file locations
READS='/FULL/PATH/TO/DIR/' #plug in the full path to your data 
```

6. Modify the `metadata.txt` template in the `docs` directory and record your file names and final sample names (*Keep as is if running the test_data*)
For instructions on using QIIME2 metadata see guidelines [here](https://docs.qiime2.org/2021.2/tutorials/metadata/)

Please fill out the `metadata.txt` as follows:
SampleID  | Sample
------------- | -------------
fastq_file_name (\*_R\*_001.fastq.gz)  | Recommended_file_name e.g LAB30_M2R_sample_A_2

## Test data

To test if the pipeline is working correctly, please edit the `run_ampliconseq.sh` script and uncomment the `test_data` function

**IMPORTANT: When running pipeline with your own data, please ensure test data funciton is commented**

```bash

ampliconseq_analysis_main(){
   create_folders 
   set_variables # -> Never comment this function
#   test_data # -> remove '#' before `test_data` to test pipeline
   import_data 
   run_cutadapt 
   run_joinpairs  
   run_qualityfiltering 
   run_deblur 
   run_classification 
   run_conditionalfilter 
   run_barplot
   echo $LINKPATH_DB
}

```

This will download a small test dataset and execute the pipeline to ensure everything is working correctly.
The data sourced from folder on HPC:
`/usr/share/sequencing/miseq/output/210326_M01745_0309_000000000-JK55H/Data/Intensities/BaseCalls`

## Running the Pipeline

```
./run_ampliconseq.sh
```

## Accessing the Output

The taxonomy barplot `barplots.qzv` will be located in the `nibsc_ampliconseq/analysis/deblur` folder.

1. Download `barplots.qzv` and upload this table to QIIME2 VIEW [here](https://view.qiime2.org/).

2. Select level 6 from the 'Taxonomic Level' dropdown menu

3. Select 'CSV' from the 'Downloads' table to download the taxa abundance estimates

**IMPORTANT: Please refer to the CS690 protocol for guidance on the final abundance table layout**


## Pipeline Execution & Parameters

The pipeline scripts are located within `nibsc_ampliconseq/scripts` directory.
*NB* Please adapt the parameters based on your data type/quality etc.

**Import Data** *Parameters*

- --type : input data (Paired end demultiplexed Illumina)
- --input-path : input directory path
- --output-path : output diretory path
- --input-format : FASTQ data in the Casava 1.8 demultiplexed format

**Cutadapt** *Parameters*

*NB* Amplicon primer trimming settings. See linked primer format in cutadapt [manual](https://cutadapt.readthedocs.io/en/stable/recipes.html?highlight=linked%20adapter#trimming-amplicon-primers-from-both-ends-of-paired-end-reads)
  
- --i-demltiplexed-sequences : input file (*.qza)
- --p-cores : CPU to use for trimming
- --p-adapter-f : forward primer sequence and reverse complement of reverse primer
- --p-adapter-r : reverse primer sequence and reverse complement of forward primer
- --verbose : verbose stdout 
- --output-dir : output directory location

**VSEARCH Join Pair** *Parameters*

- --i-demultiplexed-seqs: input file (*.qza)
- --output-dir : output directory location

**quality-filter q-score** *Parameters*

- --i-demux: input file (*.qza)
- --o-filtered-sequences : output name and location 
- --o-filter-stats : output location & name of filtering statistics
- *--p-min-quality : default q-score threshold is 4; change if sequences low quality*

**deblur denoise-16S** *Parameters*

- --i-demultiplexed-seqs : input file
- --p-trim-length : specify sequence trim length 
- --o-representative-sequences  : the resulting feature sequences
- --o-table : output feature table
- --p-jobs-to-start  : number of jobs to run in parellel
- --p-sample-stats : gather stats per sample
- --o-stats : output location of sample stats

**feature-classifier classify-sklearn** *Parameters*

- --i-classifier : Path to pre-trained classifier
- --i-reads : Feature data to be classified
- --o-classification : Classification results
- --p-n-jobs : The maximum number of concurrently worker processes

**feature-table filter-features** *Parameters*

- --i-table : The feature table for filtering
- --p-min-frequency : Abundance threshold for feature filtering 
- --o-filtered-table : Output filtered table
- --p-min-samples : Minimum number of samples for feature retention

**feature-table summarize** *Parameters*

--i-table : input table (*.qza)
--o-visualization : output visualisation object (*.qzv) 

## Acknowledgements
Developing standards for the microbiome field Gregory C. A. Amos, Alastair Logan, Saba Anwar, Martin Fritzsche, Ryan Mate, Thomas Bleazard & Sjoerd Rijpkema Gregory Microbiome Journal, 2020 (in press,https://microbiomejournal.biomedcentral.com/articles/10.1186/s40168-020-00856-3 )

Current Challenges and Best Practice Protocols for Microbiome Analysis Richa Bharti, Dominik G Grimm Briefings in Bioinformatics (BIB), 2019 (in press, https://doi.org/10.1093/bib/bbz155)
