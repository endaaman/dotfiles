#!/bin/bash

# export CUDA_PATH=~/.virtualenvs/ml/lib/python3.11/site-packages/nvidia
# export CUDNN_PATH=~/.virtualenvs/ml/lib/python3.11/site-packages/nvidia
# export CUDA_PATH=$HOME/.miniconda3/envs/cu11/
# export CUDNN_PATH=$HOME/.miniconda3/envs/cu11/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.miniconda3/envs/cu11/lib
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/.virtualenvs/ml/lib/python3.11/site-packages/nvidia/cufft


python -c 'import tensorflow as tf; print(tf.config.list_physical_devices("GPU"))'
python -c 'import torch; print(torch.cuda.is_available())'
