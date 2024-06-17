#!/bin/bash
#
#SBATCH -N 1
#SBATCH -t 1-00:00
#SBATCH -J DeepToolz
#SBATCH --output=PKU_wiggleprep
#SBATCH --cpus-per-task=1


##Script to extract convert .bam to .bw

WKDIR=/bgfs/rnicholls/PKU_Sus_2019_genomic/30-276888615/bam
OUTDIR=$WKDIR/wiggle

module load deeptools/3.3.0

for bamfile in ${WKDIR}/*.bam
do
echo $bamfile

filebase=`basename $bamfile .bam`
echo $filebase

bamCoverage -b $OUTDIR/${filebase}_Chr5.bam -o $OUTDIR/${filebase}_Chr5.bw
bamCoverage -b $OUTDIR/${filebase}_PAH.bam -o $OUTDIR/${filebase}_PAH.bw
bamCoverage -b $WKDIR/${filebase}.bam -o $WKDIR/${filebase}.bw

done
