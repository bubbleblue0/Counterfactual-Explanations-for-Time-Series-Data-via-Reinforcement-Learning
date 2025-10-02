#!/bin/bash


GPUS=(0 1 2 3 4 5 6 7)

DATASETS=(Chinatown Coffee ECG200 GunPoint GunPointAgeSpan GunPointMaleVersusFemale GunPointOldVersusYoung TwoLeadECG HandOutlines)


for i in "${!DATASETS[@]}"; do
  DATASET=${DATASETS[$i]}
  GPU=${GPUS[$i % ${#GPUS[@]}]} # Cycle through GPUs if there are more datasets than GPUs

  # Set the environment variable for the GPU
  export CUDA_VISIBLE_DEVICES=$GPU

  # Run the Python script with the specified dataset
  nohup python3 mainRL_time0.py --dataset $DATASET > RL_logs_32_final/${DATASET}_gpu${GPU}.log 2>&1 &

  echo "Started training for dataset $DATASET on GPU $GPU"
done
