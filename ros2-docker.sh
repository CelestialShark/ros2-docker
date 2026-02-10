#! /usr/bin/env bash

COMMANDS=' start | stop | shell '
P=$0
COMMAND=$1
B="$(basename ${P})"
SCRIPT_NAME="$(cd "$(dirname "${P}")" && pwd)/$(basename "${P}")"
PKG_PATH="$(dirname ${SCRIPT_NAME})"
USAGE="$B ${COMMANDS}"

start() {    
    xhost +local:docker
    docker compose -f docker-compose.linux.yml up -d --build
}

stop() {
    docker compose -f docker-compose.linux.yml down
}

shell() {
    echo "Launching the ROS 2 environment, type 'exit' to leave once you're done."
    docker exec -it ros2-docker /bin/bash
}

case $COMMAND in 
  start|stop|shell)
    ${COMMAND}
    ;;
  *) 
    echo "Invalid Input..."
    echo "$USAGE"
    exit 0
    ;;
esac
