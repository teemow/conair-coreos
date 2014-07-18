#!/bin/sh

BIN_PATH=/home/core/bin

mkdir -p $BIN_PATH
wget http://conair.teemow.com/bin/conair -O $BIN_PATH/conair

chmod 755 $BIN_PATH/conair
alias conair=$BIN_PATH/conair

conair init
conair pull base
git clone https://github.com/teemow/conair-coreos
cd conair-coreos
conair build coreos
conair run coreos coreos-01
