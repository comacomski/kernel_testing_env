#!/bin/bash
#
# SPDX-License-Identifier: GPL-2.0
# Copyright(c) Mico Antonic <coma.comski@gmail.com>
#
# License: GPLv2

release_sha="$(uname -r)"
release=$(echo "$release_sha" | sed -E 's/(.*-rc).*/\1/')
OUT_DIR="/mnt/hostshare/logs/${release}"

mkdir -p "${OUT_DIR}"

echo "Generating dmesg logs in: ${OUT_DIR}"

dmesg -t -l emerg > $OUT_DIR/$release.dmesg_emerg
dmesg -t -l crit > $OUT_DIR/$release.dmesg_crit
dmesg -t -l alert > $OUT_DIR/$release.dmesg_alert
dmesg -t -l err > $OUT_DIR/$release.dmesg_err
dmesg -t -l warn > $OUT_DIR/$release.dmesg_warn
dmesg -t > $OUT_DIR/$release.dmesg
dmesg -t -k > $OUT_DIR/$release.dmesg_kern
