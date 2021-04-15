## 16S amplcon sequencing using QIMME2

## Data 
Data sourced from folder on HPC:
`/usr/share/sequencing/miseq/output/210326_M01745_0309_000000000-JK55H/Data/Intensities/BaseCalls`


## Download & build QIMME2 conda env

Download the .yml file:

` curl -sL \`
`  "https://data.qiime2.org/distro/core/qiime2-2020.8-py36-linux-conda.yml" > \`
 ` "qiime2.yml"`

& build in conda:
`conda env create -n qiime2 --file qiime2.yml`
`rm qiime2.yml`

activate environment:
`conda activate qiime2`