#!/bin/sh

die () {
    echo >&2 "$0"
    exit 1
}

[ $EUID = 0 ] || die "This script must be run as root"

DEFAULT_CLUSTER=cluster
CLUSTER=${1:-$DEFAULT_CLUSTER}

./destroy.sh

conair build $CLUSTER
conair destroy && conair init

for i in 1 2 3; do
    sleep 1
    echo "Starting container $CLUSTER-0$i"
    conair run $CLUSTER $CLUSTER-0$i
done

