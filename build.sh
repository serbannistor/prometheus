#!/bin/bash

EXIT_CODE=0

if [ -z "$1" ]; then
    echo "Architecture must be provided!" 1>&2
    EXIT_CODE=1
else
    if [ ! -d "$1" ]; then
        echo "No such files locally for architecture: $1" 1>&2
        EXIT_CODE=2
    fi
fi

if [ $EXIT_CODE -ne 0 ]; then
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
echo "Building Docker image for architecture: $ARCH"
copy_binaries $ARCH
build_docker serbannistor/prometheus:latest
cleanup_binaries

exit $EXIT_CODE
