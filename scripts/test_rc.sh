# !/bin/bash
#
# SPDX-License-Identifier: GPL-2.0
# Copyright(c) Mico Antonic <coma.comski@gmail.com>
#
# License: GPLv2

if [ -z "$1" ] || [ -z "$2" ]; then
    exit 1
fi

SCRIPTS_DIR="$(realpath $(dirname $0))"

$SCRIPTS_DIR/stable_stable_checkout.sh $1
$SCRIPTS_DIR/make_linux.sh stable ./configs/.config-qemu-x86-basic

# run dmesg checks from qemu

$SCRIPTS_DIR/stable_rc_checkout.sh $2
$SCRIPTS_DIR/make_linux.sh stable ./configs/.config-qemu-x86-basic

# run dmesg checks from qemu

# run dmesg_diff.sh from host (need to find names of files to compare)


