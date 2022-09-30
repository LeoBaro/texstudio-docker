# texstudio-docker

This Docker image contains all latex packages and the TeXstudio editor. 

## Based on
* Ubuntu 22.04
* TeX
* TeXstudio 

## How to use the image

Run the service with docker-compose:
```
export MOUNT_DIR=/host/path/to/tex/sources
./start_texstudio.sh
```

## How to build the image
```
docker build -t texstudio:latest .
```
