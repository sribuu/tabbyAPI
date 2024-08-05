MODEL_NAME=bartowski/Qwen2-7B-Instruct-exl2
REVISION=6_5
TAG=qwen2-7b
PORT=5000

if [[ $1 = "build" ]]
then
    # Build a new image
    echo "Building new Docker image..."
    docker build -t llm-on-prem:$TAG --build-arg MODEL_NAME=$MODEL_NAME --build-arg REVISION=$REVISION .
elif [[ $1 = "start" ]]
then
    # Run the new Docker container
    echo "Running new Docker container..."
    docker run -d --gpus all -it --rm --name llm_onprem -p ${PORT}:5000 llm-on-prem:$TAG

elif [[ $1 = "debug" ]]
then
    # debug Docker container
    echo "Debug inside docker container"
    docker run --gpus all -it --rm --name llm_onprem -p ${PORT}:5000 --entrypoint /bin/bash llm-on-prem:$TAG
else
    echo "Argument must be either 'build', 'start' or 'debug'"
    exit 1;
fi