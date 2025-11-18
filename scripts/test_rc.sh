# !/bin/bash
#
# SPDX-License-Identifier: GPL-2.0
# Copyright(c) Mico Antonic <coma.comski@gmail.com>
#
# License: GPLv2

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <stable_version> <rc_version>"
    echo "Example: $0 5.10 5.10"
    exit 1
fi

SCRIPTS_DIR="$(realpath $(dirname $0))"
CONFIG_DIR="$(realpath $(dirname $0))/../configs"
CONFIG=".config-qemu-x86-basic"

echo "stable_stable checkout to $1"
$SCRIPTS_DIR/stable_stable_checkout.sh $1
$SCRIPTS_DIR/make_linux.sh stable "${CONFIG_DIR}/${CONFIG}"
$SCRIPTS_DIR/run_qemu.sh -t


echo "stable_rc checkout to $2"
$SCRIPTS_DIR/stable_rc_checkout.sh $2
$SCRIPTS_DIR/make_linux.sh stable "${CONFIG_DIR}/${CONFIG}"  
$SCRIPTS_DIR/run_qemu.sh -t

# run dmesg_diff.sh from host (need to find names of files to compare)


