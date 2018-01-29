#!/bin/bash

INPUTDIR="../../Dataset/Image"
OUTPUTDIR="./result"  #输出大津法二值化图像
EXE1="./Otsu"

INPUTLIST=$(ls $INPUTDIR)

for INPUTIMAGE in $INPUTLIST
do

   $EXE1 -i $INPUTDIR/$INPUTIMAGE -o $OUTPUTDIR/$INPUTIMAGE

done
