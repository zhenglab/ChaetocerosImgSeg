#!/bin/bash

INPUTDIR="../../Dataset/Image"
OUTPUTDIR1="./gsdam_output/x"
OUTPUTDIR2="./gsdam_output/y"
OUTPUTDIR3="./gsdam_output/z"
OUTPUTDIR4="./gsdam_output/xz"
OUTPUTDIR5="./gsdam_output/yz"
OUTPUTDIR6="./gsdam_output/open/"
OUTPUTDIR7="./gsdam_output/close"
OUTPUTDIR8="./gsdam_output/max"
OUTPUTDIR="./gsdam_output/final"
EXE="./gsdam"

INPUTLIST=$(ls $INPUTDIR)

for INPUTIMAGE in $INPUTLIST
do

$EXE $INPUTDIR/$INPUTIMAGE -x $OUTPUTDIR1/$INPUTIMAGE -y $OUTPUTDIR2/$INPUTIMAGE -z $OUTPUTDIR3/$INPUTIMAGE -xz $OUTPUTDIR4/$INPUTIMAGE -yz $OUTPUTDIR5/$INPUTIMAGE -k $OUTPUTDIR6/$INPUTIMAGE -b $OUTPUTDIR7/$INPUTIMAGE -c $OUTPUTDIR8/$INPUTIMAGE -o $OUTPUTDIR/$INPUTIMAGE

done
