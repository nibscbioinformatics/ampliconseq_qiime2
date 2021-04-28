#!/usr/bin/env bash

### Join paired reads

join_main(){
	
	join_pairs
}


join_pairs(){

cd ${ANALYSIS_FOLDER}
mkdir -p ${ANALYSIS_FOLDER}/joined_reads

qiime vsearch join-pairs \
 --i-demultiplexed-seqs  ${ANALYSIS_FOLDER}/cutadapt_trimmed_reads/trimmed_sequences.qza \
 --o-joined-sequences ${ANALYSIS_FOLDER}/joined_reads/joined_sequences.qza

}

join_main
