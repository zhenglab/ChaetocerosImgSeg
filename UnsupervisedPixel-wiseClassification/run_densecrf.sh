#!/bin/bash 

###########################################
# You can either use this script to generate the DenseCRF post-processed results
# or use the densecrf_layer (wrapper) in Caffe
###########################################
LOAD_MAT_FILE=1

MODEL_NAME=DeepLab-LargeFOV

TEST_SET=val        #val, test

# specify the parameters
MAX_ITER=10

Bi_W=4
Bi_X_STD=49
Bi_Y_STD=49
Bi_R_STD=5
Bi_G_STD=5 
Bi_B_STD=5

POS_W=3
POS_X_STD=3
POS_Y_STD=3


#######################################
# MODIFY THE PATY FOR YOUR SETTING
#######################################
SAVE_DIR=exper/res/${MODEL_NAME}/${TEST_SET}

echo "SAVE TO ${SAVE_DIR}"

CRF_DIR=../Caffe/densecrf


IMG_DIR_NAME=exper/data


# NOTE THAT the densecrf code only loads ppm images
IMG_DIR=${IMG_DIR_NAME}/testppm #PPMImages

if [ ${LOAD_MAT_FILE} == 1 ]
then
    # the features are saved in .mat format
    CRF_BIN=${CRF_DIR}/prog_refine_pascal_v4
    FEATURE_DIR=exper/temp
fi

mkdir -p ${SAVE_DIR}

# run the program
${CRF_BIN} -id ${IMG_DIR} -fd ${FEATURE_DIR} -sd ${SAVE_DIR} -i ${MAX_ITER} -px ${POS_X_STD} -py ${POS_Y_STD} -pw ${POS_W} -bx ${Bi_X_STD} -by ${Bi_Y_STD} -br ${Bi_R_STD} -bg ${Bi_G_STD} -bb ${Bi_B_STD} -bw ${Bi_W}
