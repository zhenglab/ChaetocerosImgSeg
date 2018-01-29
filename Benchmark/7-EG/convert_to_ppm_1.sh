#!/bin/bash

INPUTDIR="../../Dataset/Image"
OUTPUTDIR="./dataset_ppm"
mkdir $OUTPUTDIR

INPUTLIST=$(ls $INPUTDIR)

for INPUTIMAGE in $INPUTLIST
do
	convert $INPUTDIR/$INPUTIMAGE $OUTPUTDIR/${INPUTIMAGE%.*}.ppm
done

