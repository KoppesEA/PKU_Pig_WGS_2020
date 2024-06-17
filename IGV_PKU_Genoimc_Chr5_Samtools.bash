#!/bin/bash
#
#SBATCH -N 1
#SBATCH -t 1-00:00
#SBATCH -J SamRIP
#SBATCH --output=PKU_BAMprep
#SBATCH --cpus-per-task=4


##Script to extract smallRNA_UMI and then index .bam files for IGV 

WKDIR=/bgfs/rnicholls/PKU_Sus_2019_genomic/30-276888615/bam
OUTDIR=$WKDIR/wiggle

module load gcc/8.2.0
module load samtools/1.9

for bamfile in ${WKDIR}/*.bam
do
echo $bamfile

filebase=`basename $bamfile .bam`
echo $filebase

#index sorted BAM files (Genewiz Enesemble Sscrofa 11.1 Alignment)
#samtools index $bamfile

#extract all chr1 alignments from sorted BAM file and redirect output to IGV-chr1 folder
samtools view -@ 4 -b -o $OUTDIR/${filebase}_Chr5.bam $bamfile "5"
samtools view -@ 4 -b -o $OUTDIR/${filebase}_PAH.bam $bamfile "5:133550000-134700000"


#index extract alignment files
samtools index -@ 4 $OUTDIR/${filebase}_Chr5.bam
samtools index -@ 4 $OUTDIR/${filebase}_PAH.bam

done
