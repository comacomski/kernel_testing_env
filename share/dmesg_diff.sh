# !/bin/bash
#
#SPDX-License-Identifier: GPL-2.0
# Copyright(c) Shuah Khan <skhan@linuxfoundation.org>
# Copyright(c) Mico Antonic <coma.comski@gmail.com>
#
# Modified version: Reworked for comparing already existing dmesg logs from 2 kernel versions
# License: GPLv2​

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 v1 v2"
    echo "Example: $0 5.15.195 5.15.196"
    exit 1
fi

V1="$1"
V2="$2"
LOGS_DIR="/mnt/hostshare/logs"
OUT_FILE="${LOGS_DIR}/${V1}_vs_${V2}"

mkdir -p "${LOGS_DIR}"

echo "Start diff check for $V1 and $V2" > $OUT_FILE

echo "--------------------------" >> $OUT_FILE

echo "dmesg emergency regressions" >> $OUT_FILE
echo "--------------------------" >> $OUT_FILE
diff $OUT_DIR/$1/$1.dmesg_emerg $OUT_DIR/$2/$2.dmesg_emerg >> $OUT_FILE
echo "--------------------------" >> $OUT_FILE

echo "dmesg critical regressions" >> $OUT_FILE
echo "--------------------------" >> $OUT_FILE
diff $OUT_DIR/$1/$1.dmesg_crit $OUT_DIR/$2/$2.dmesg_crit >> $OUT_FILE
echo "--------------------------" >> $OUT_FILE

echo "dmesg alert regressions" >> $OUT_FILE
echo "--------------------------" >> $OUT_FILE
diff $OUT_DIR/$1/$1.dmesg_alert $OUT_DIR/$2/$2.dmesg_alert >> $OUT_FILE
echo "--------------------------" >> $OUT_FILE

echo "dmesg err regressions" >> $OUT_FILE
echo "--------------------------" >> $OUT_FILE
diff $OUT_DIR/$1/$1.dmesg_err $OUT_DIR/$2/$2.dmesg_err >> $OUT_FILE
echo "--------------------------" >> $OUT_FILE

echo "dmesg warn regressions" >> $OUT_FILE
echo "--------------------------" >> $OUT_FILE
diff $OUT_DIR/$1/$1.dmesg_warn $OUT_DIR/$2/$2.dmesg_warn >> $OUT_FILE
echo "--------------------------" >> $OUT_FILE

echo "dmesg regressions" >> $OUT_FILE
echo "--------------------------" >> $OUT_FILE
diff $OUT_DIR/$1/$1.dmesg $OUT_DIR/$2/$2.dmesg >> $OUT_FILE
echo "--------------------------" >> $OUT_FILE

echo "dmesg_kern regressions" >> $OUT_FILE
echo "--------------------------" >> $OUT_FILE
diff $OUT_DIR/$1/$1.dmesg_kern $OUT_DIR/$2/$2.dmesg_kern >> $OUT_FILE
echo "--------------------------" >> $OUT_FILE

echo "--------------------------" >> $OUT_FILE

echo "End diff check for $V1 and $V2" >> $OUT_FILE
