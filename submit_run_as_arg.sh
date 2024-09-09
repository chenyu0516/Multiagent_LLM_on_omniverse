#!/bin/bash -e

show_help() {
    echo ""
    echo "Usage: $0 <task_type> <pyhton_script_dir> <result_dir> <python_script_args>"
    echo "  task_type:               Type of task to submit"
    echo "  pyhton_script_dir:       The direction of python script to execute in nucleus server"
    echo "  result_dir:              The direction of .txt file for receiving result in nucleus server"
    echo "  python_script_args:      It is ok if there isn't any"
    echo ""
    echo "Environment variables required:"
    echo "  FARM_URL:        Omniverse Farm URL"
    echo "  FARM_USER:       Omniverse Farm user"
}

check_environment_variable() {
    local var_name=$1
    if [ -z "${!var_name}" ]; then
        echo "Error: Environment variable $var_name is not defined."
        show_help
        exit 1
    fi
}

check_environment_variable "FARM_URL"
check_environment_variable "FARM_USER"


# Check if $4 is "none" or empty
if [ -z "$4" ] || [ "$4" == "none" ]; then
    ARGS="\"/run.sh \
           --download-src omniverse://nucleus.tpe1.local/$2 \
           --download-dest /src/your-script.py \
           --upload-src /results/result.json \
           --upload-dest omniverse://nucleus.tpe1.local/$3 \
           './python.sh -u /src/your-script.py'\""
else
    ARGS="\"/run.sh \
           --download-src omniverse://nucleus.tpe1.local/$2 \
           --download-dest /src/your-script.py \
           --upload-src /results/result.json \
           --upload-dest omniverse://nucleus.tpe1.local/$3 \
           './python.sh -u /src/your-script.py $4'\""
fi

curl -X POST "${FARM_URL}/queue/management/tasks/submit" \
    -H "Accept: application/json" \
    -H "Content-Type: application/json" \
    -d '{
        "user": "'"${FARM_USER}"'",
        "task_type": "'"$1"'",
        "task_args": {
            "args": '"${ARGS}"'
        },
        "metadata": {
            "_retry": {
                "is_retryable": false
            }
        },
        "task_comment": "'"Task execution of NTU"'"
    }'

#Reference: https://docs.omniverse.nvidia.com/farm/latest/farm_examples.html#integrating-the-job-with-omniverse-agent-and-queue
#curl -X POST "${FARM_URL}/queue/management/tasks/submit" \
#    -H "Accept: application/json" \
#    -H "Content-Type: application/json" \
#    -d '{
#        "user": "'"${FARM_USER}"'",
#        "task_type": "'"$1"'",
#        "task_args": {
#            "args": "/run.sh \
#  --download-src 'omniverse://nucleus.tpe1.local/Users/NTU/isaac-sim-simulation-example.py' \
#  --download-dest '/src/isaac-sim-simulation-example.py' \
#  --upload-src '/results/isaac-sim-simulation-example.txt' \
#  --upload-dest 'omniverse://nucleus.tpe1.local/Users/NTU/result/result.txt' \
#  './python.sh -u /src/isaac-sim-simulation-example.py 10'" 
#        },
#        "metadata": {
#         "_retry": {
#             "is_retryable": false
#         }
#        },
#        "task_comment": "Task execution of NTU"
#    }'
