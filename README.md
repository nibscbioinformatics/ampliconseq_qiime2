## 16S amplcon sequencing using QIMME2


## Requirements

- Conda (if not installed see instructions [here](https://conda.io/projects/conda/en/latest/user-guide/install/index.html) )

## Data 
Data sourced from folder on HPC:
`/usr/share/sequencing/miseq/output/210326_M01745_0309_000000000-JK55H/Data/Intensities/BaseCalls`


## Running the Pipeline

Clone the github directory and `cd` into it:
```
git clone https://github.com/nibscbioinformatics/ampliconseq_qiime2.git \
cd ampliconseq_qiime2/
``` 

Download the pre-trained classifer [here](https://data.qiime2.org/2021.2/common/silva-138-99-515-806-nb-classifier.qza) and place in docs folder:

```
wget https://data.qiime2.org/2021.2/common/silva-138-99-515-806-nb-classifier.qza
mv silva-138-99-515-806-nb-classifier.qza docs/
```

Acitvate conda & build the conda qiime2 environment:
```
conda3 #conda activate
conda env create -n qiime2 --file qiime2.yml
```

Activate the Qiime2 environment:
```
conda activate qiime2
```

Edits the `reads` variable in the `run_amplionseq.sh` script and provide full path to your reads:

```
#!/usr/bin/env bash
### Workflow for amplicon sequencing analysis pipeline

## Root folder name
NAME=nibsc_ampliconseq

echo "Please Check File Paths in run_ampliconseq.sh"

## data file locations
READS='/FULL/PATH/TO/DIR/'
```

 
Run the pipeline:
```
./run_ampliconseq.sh
```
