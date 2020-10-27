#!/bin/bash

EXIT_CODE=0

display_usage() {
    echo "Usage:"
    echo "    $0 ARCHITECTURE TAG"
    echo "Example: $0 linux_amd64 mydockeruser/repository:latest"
}

if [ -z "$1" ]; then
    echo "Architecture must be provided!" 1>&2
    EXIT_CODE=1
else
    if [ ! -d "$1" ]; then
        echo "No such files locally for architecture: $1" 1>&2
        EXIT_CODE=2
    fi
fi

if [ -z "$2" ]; then
    echo "Tag must be provided!" 1>&2
    EXIT_CODE=3
fi

if [ $EXIT_CODE -ne 0 ]; then
    display_usage
    exit $EXIT_CODE
fi

copy_binaries() {
    ARCH=$@
    echo "Copying binaries from $ARCH to ."
    cp $ARCH/prometheus .
    cp $ARCH/promtool .
}

cleanup_binaries() {
    echo "Cleaning up"
    rm prometheus
    rm promtool
}

build_docker() {
    TAG=$1
    echo "Building Docker image with tag: $TAG"
    docker build -t $TAG .
}

ARCH="$1"
TAG="$2"
echo "Building Docker image for architecture: $ARCH"
copy_binaries $ARCH
build_docker $TAG
cleanup_binaries

exit $EXIT_CODE
