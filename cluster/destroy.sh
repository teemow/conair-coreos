#!/bin/sh

die () {
    echo >&2 "$0"
    exit 1
}

[ $EUID = 0 ] || die "This script must be run as root"

DEFAULT_CLUSTER=cluster
CLUSTER=${1:-$DEFAULT_CLUSTER}

if [ "$(conair images | grep "^$CLUSTER$")" != "" ]; then
    echo "Delete image $CLUSTER"
    conair rmi $CLUSTER
fi

if [ "$(conair ps | grep "^$CLUSTER-0.$")" != "" ]; then
    for container in $(conair ps | grep "^$CLUSTER-0.$"); do
        echo "Delete container $container"
        conair rm $container
    done
fi


