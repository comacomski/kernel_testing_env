#!/bin/bash
#
# SPDX-License-Identifier: GPL-2.0
# Copyright(c) Mico Antonic <coma.comski@gmail.com>
#
# License: GPLv2

OUT_DIR="/mnt/hostshare"

echo "Generating dmesg logs!"

release="$(uname -r)"

dmesg -t -l emerg > $OUT_DIR/$release.dmesg_emerg
dmesg -t -l crit > $OUT_DIR/$release.dmesg_crit
dmesg -t -l alert > $OUT_DIR/$release.dmesg_alert
dmesg -t -l err > $OUT_DIR/$release.dmesg_err
dmesg -t -l warn > $OUT_DIR/$release.dmesg_warn
dmesg -t > $OUT_DIR/$release.dmesg
dmesg -t -k > $OUT_DIR/$release.dmesg_kern
