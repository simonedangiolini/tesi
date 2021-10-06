!/bin/bash

path_to_group=$1
path_to_trimmomatic=$2
path_to_adapters=$3
path_to_star=$4
num_thread=$5
path_to_reference_genome=$6
path_to_output=$7

for group in $(ls $path_to_group); do #groups is our 3 groups young/old/dis
group_path=$path_to_group/$group
cd $group_path
for sample in $(ls $group_path); do #sample is every sample of our groups
echo "******************"
echo "****** $sample ******"  
echo "******************"
sample_path=$group_path/$sample
for gz in $(ls $sample_path); do #every file for my samples had .gz extension
x=$(ls $sample_path | grep -E .*.fastq.gz$ | awk -F \. '{print $1}')    #we put in X the name of the SAMPLE so during the analysis we can use the name and change the extension for every file that we'll create connected to that sample
cd $sample_path
gunzip $x'_T_bash.fq.gz'
fastqc $x'.fastq.gz'
java -jar $path_trimmomatic SE -threads n -phred33 $x.'fastq.gz' $x'_T_bash.fq.gz' ILLUMINACLIP:$path_to_adapters:2:30:10 SLIDINGWINDOW:5:20 MINLEN:15  #trimming process
fastqc $x'_T_bash.fq.gz'
star_output=$sample_path/STAR
$path_to_star --runThreadN $num_thread --genomeDir $path_to_reference_genome --readFilesIn $x'_T_bash.fq' --outSAMtype BAM SortedByCoordinate --outFileNamePrefix $star_output    #alignment process
htseq-count -f bam -s reverse $star_outputAligned.sortedByCoord.out.bam $path_to_reference_genome > $sample_path/$x_htseqcount.txt #we'll have a file with name of sample analysed and its genetic counts
done
done
