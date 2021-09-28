#!/bin/bash
root=/media/simone/
#root=/home/spliced/biolab_sshfs/media/biolab/
n=$(( $(cat /proc/cpuinfo | grep processor | wc -l) -1)) #number of processor
for gruppo  in $(ls $root/Elements/SRA/Alzheimer); do
	mkdir $root/Elements/SRA/aligned/$gruppo
	for run in $(ls $root/Elements/SRA/Alzheimer/$gruppo); do
		echo "******************"
		echo "****** $run ******"
		echo "******  :D  ******"
		echo "******************"
        	x=$(ls $root/Elements/SRA/Alzheimer/$gruppo/$run | grep -E .*.fastq.gz$ | awk -F \. '{print $1}')
        	echo $run
        	if [ ! -d $root/Elements/SRA/aligned/$gruppo/$run ]; then
            		mkdir $root/Elements/SRA/aligned/$gruppo/$run
            		$root/Elements/allineamento/STAR-2.7.3a/source/STAR  --runThreadN $n --genomeDir $root/Elements/allineamento/GRCh38  --readFilesIn $x'_T_bash.fq' --outSAMtype BAM SortedByCoordinate --quantMode GeneCounts --outFileNamePrefix $root/Elements/SRA/aligned/$gruppo/$run/STAR
            		echo "l'allineamento n. $run è stato effettuato"
        	fi
    	done  
done
