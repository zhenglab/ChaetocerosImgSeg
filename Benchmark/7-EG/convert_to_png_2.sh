#!/bin/bash

INPUTDIR="./eg_result"
OUTPUTDIR="./result"
mkdir $OUTPUTDIR

INPUTLIST=$(ls $INPUTDIR)

for INPUTIMAGE in $INPUTLIST
do
	convert $INPUTDIR/$INPUTIMAGE $OUTPUTDIR/${INPUTIMAGE%.ppm}.png
done

