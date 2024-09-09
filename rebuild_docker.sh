#!/bin/bash -e

docker remove -f omni-container 
docker build -t omni .  
docker run --name=omni-container omni bash submit_run_as_arg.sh "isaac-sim-basic-example-1" "Users/NTU/test.py" "Users/NTU/result/result.txt" 10
