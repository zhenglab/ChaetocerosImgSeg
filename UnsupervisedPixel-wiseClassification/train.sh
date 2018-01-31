#!/usr/bin/env sh

# Modified version from https://bitbucket.org/deeplab/deeplab-public
# Martin Kersner, m.kersner@gmail.com
# 2016/04/05

CAFFE_BIN=../Caffe/.build_release/tools/caffe.bin
EXP=exper
DATA_ROOT=exper/data
GPU_ID=1

# Specify number of classes
NUM_LABELS=2        # 1 class + 1 background

LIST_SUFFIX=        

# Specify which model to train
NET_ID=DeepLab-LargeFOV

# Run
RUN_TRAIN=1
RUN_TEST=0
RUN_TRAIN2=1
RUN_TEST2=0

# Create directories ###########################################################
CONFIG_DIR=${EXP}/config/${NET_ID}
MODEL_DIR=${EXP}/model/${NET_ID}
LOG_DIR=${EXP}/log/${NET_ID}

for DIR in $CONFIG_DIR $MODEL_DIR $LOG_DIR; do 
  mkdir -p ${DIR}
done

export GLOG_log_dir=${LOG_DIR}

# Training #1 (on train_aug) ###################################################
if [ ${RUN_TRAIN} -eq 1 ]; then
  LIST_DIR=${EXP}/list${LIST_SUFFIX}
  TRAIN_SET=train

  MODEL=${EXP}/model/${NET_ID}/init.caffemodel

  echo "Training net ${EXP}/${NET_ID}"
  for pname in train solver; do
	  sed "$(eval echo $(cat sub.sed))" \
	    ${CONFIG_DIR}/${pname}.prototxt > ${CONFIG_DIR}/${pname}_${TRAIN_SET}.prototxt
  done

  CMD="${CAFFE_BIN} train \
    --solver=${CONFIG_DIR}/solver_${TRAIN_SET}.prototxt \
    --gpu=${GPU_ID}"

	if [ -f ${MODEL} ]; then
	    CMD="${CMD} --weights=${MODEL}"
	fi

	echo Running ${CMD} && ${CMD}
fi

# Test #1 specification (on val or test) #######################################
if [ ${RUN_TEST} -eq 1 ]; then
  for TEST_SET in val; do
	  TEST_ITER=`cat exper/list${LIST_SUFFIX}/${TEST_SET}.txt | wc -l`
	  MODEL=${EXP}/model/${NET_ID}/test.caffemodel

	  if [ ! -f ${MODEL} ]; then
	      MODEL=`ls -t ${EXP}/model/${NET_ID}/train_iter_*.caffemodel | head -n 1`
	  fi
	  
	  echo "Testing net ${EXP}/${NET_ID}"
	  FEATURE_DIR=${EXP}/features/${NET_ID}
	  mkdir -p ${FEATURE_DIR}/${TEST_SET}/fc8
	  mkdir -p ${FEATURE_DIR}/${TEST_SET}/crf

	  sed "$(eval echo $(cat sub.sed))" \
	      ${CONFIG_DIR}/test.prototxt > ${CONFIG_DIR}/test_${TEST_SET}.prototxt

	  CMD="${CAFFE_BIN} test \
      --model=${CONFIG_DIR}/test_${TEST_SET}.prototxt \
      --weights=${MODEL} \
      --gpu=${GPU_ID} \
      --iterations=${TEST_ITER}"

	  echo Running ${CMD} && ${CMD}
  done
fi

# Training #2 (finetune on trainval_aug) #######################################
if [ ${RUN_TRAIN2} -eq 1 ]; then
  LIST_DIR=${EXP}/list${LIST_SUFFIX}
  TRAIN_SET=train2

  MODEL=${EXP}/model/${NET_ID}/init2.caffemodel

  if [ ! -f ${MODEL} ]; then
	  MODEL=`ls -t ${EXP}/model/${NET_ID}/train_iter_*.caffemodel | head -n 1`
  fi
    
  echo "Training2 net ${EXP}/${NET_ID}"
  for pname in train solver2; do
	  sed "$(eval echo $(cat sub.sed))" \
	    ${CONFIG_DIR}/${pname}.prototxt > ${CONFIG_DIR}/${pname}_${TRAIN_SET}.prototxt
  done
  
  CMD="${CAFFE_BIN} train \
    --solver=${CONFIG_DIR}/solver2_${TRAIN_SET}.prototxt \
    --weights=${MODEL} \
    --gpu=${GPU_ID}"

	echo Running ${CMD} && ${CMD}
fi

# Test #2 on official test set #################################################
if [ ${RUN_TEST2} -eq 1 ]; then
  for TEST_SET in val; do
	  TEST_ITER=`cat exper/list${LIST_SUFFIX}/${TEST_SET}.txt | wc -l`
	  MODEL=${EXP}/model/${NET_ID}/test2.caffemodel

	  if [ ! -f ${MODEL} ]; then
	    MODEL=`ls -t ${EXP}/model/${NET_ID}/train2_iter_*.caffemodel | head -n 1`
	  fi
	  
	  echo "Testing2 net ${EXP}/${NET_ID}"
	  FEATURE_DIR=${EXP}/features2/${NET_ID}
	  mkdir -p ${FEATURE_DIR}/${TEST_SET}/fc8
	  mkdir -p ${FEATURE_DIR}/${TEST_SET}/crf
	  sed "$(eval echo $(cat sub.sed))" \
	    ${CONFIG_DIR}/test.prototxt > ${CONFIG_DIR}/test_${TEST_SET}.prototxt

	  CMD="${CAFFE_BIN} test \
      --model=${CONFIG_DIR}/test_${TEST_SET}.prototxt \
      --weights=${MODEL} \
      --gpu=${GPU_ID} \
      --iterations=${TEST_ITER}"

	  echo Running ${CMD} && ${CMD}
  done
fi
