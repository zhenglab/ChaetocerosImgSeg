#!/bin/bash

INPUTDIR="../../Dataset/Image"
OUTPUTDIR="./eg_result"
EXE="./segment"
sigma="0.5"
k="500"
min="20"

mkdir $OUTPUTDIR

INPUTLIST=$(ls $INPUTDIR)

for INPUTIMAGE in $INPUTLIST
do
	$EXE $sigma $k $min $INPUTDIR/$INPUTIMAGE $OUTPUTDIR/${INPUTIMAGE%.ppm}.ppm
done

