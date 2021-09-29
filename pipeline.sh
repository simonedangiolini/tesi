#!/bin/bash

root=/media/simone/
#root=/home/spliced/biolab_sshfs/media/biolab/
#echo $(date +%s) ' ' $(date +%N)
n=$(( $(cat /proc/cpuinfo | grep processor | wc -l) -1)) #number of processor
for gruppo  in $(ls $root/Elements/SRA/Alzheimer); do
	cd $root/Elements/SRA/Alzheimer/$gruppo
	for run in $(ls $root/Elements/SRA/Alzheimer/$gruppo); do
		echo "******************"
		echo "****** $run ******"
		echo "******  :D  ******"
		echo "******************"
		#run è la cartella es 433
		#for gz in $(ls $root/Elements/SRA/Alzheimer/$gruppo/$run);do
		#  	if [[ $gz =~ ^.*.fastq.gz$ ]]; then
		#		echo $gz
		#	fi
		#	# prende solo le corse di mio interesse in ~0,2s
		#done  #funziona ma è inutile quando abbiamo un grep 
		x=$(ls $root/Elements/SRA/Alzheimer/$gruppo/$run | grep -E .*.fastq.gz$ | awk -F \. '{print $1}') #si può usare anche grep -o
		##########################parte in cui si fa il fastqc e il trimming delle corse####
		cd $root/Elements/SRA/Alzheimer/$gruppo/$run
		#gunzip $x'_T_bash.fq.gz'
		#fastqc $x'.fastq.gz'
		#java -jar '/home/simone/Scrivania/Trimmomatic-0.39/trimmomatic-0.39.jar'  SE -threads 5 -phred33 $x.'fastq.gz' $x'_T_bash.fq.gz' ILLUMINACLIP:'/home/simone/Scrivania/Trimmomatic-0.39/adapters/adapters.fa':2:30:10 SLIDINGWINDOW:5:20 LEADING:3 (magari eliminiamolo sto leading) MINLEN:15 
		#fastqc $x'_T_bash.fq.gz'
		$root/Elements/allineamento/STAR-2.7.3a/source/STAR  --runThreadN $n --genomeDir $root/Elements/allineamento/GRCh38  --readFilesIn $x'_T_bash.fq' --outSAMtype BAM SortedByCoordinate --quantMode GeneCounts --outFileNamePrefix $root/Elements/SRA/Alzheimer/aligned/$run/STAR
	done
done
#echo $(date +%s) ' ' $(date +%N)


