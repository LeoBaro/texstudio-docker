#! /bin/bash

export UID=$(id -u)
export GID=$(id -g)

if [ -z "$MOUNT_DIR" ]; then
    echo "MOUNT_DIR is not set. Please set it to the directory you want to mount."
    exit 1
fi

docker-compose up -d texstudio