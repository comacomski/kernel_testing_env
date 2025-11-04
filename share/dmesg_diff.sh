# !/bin/bash
#
#SPDX-License-Identifier: GPL-2.0
# Copyright(c) Shuah Khan <skhan@linuxfoundation.org>
#
# License: GPLv2​

OUT_DIR="/mnt/hostshare"

if [ "$1" == "" ]; then
    echo "$0 " <old name -r>
    exit -1
fi

release=`uname -r`
echo "Start dmesg regression check for $release" > $OUT_DIR/dmesg_checks_results

echo "--------------------------" >> $OUT_DIR/dmesg_checks_results

dmesg -t -l emerg > $OUT_DIR/$release.dmesg_emerg
echo "dmesg emergency regressions" >> $OUT_DIR/dmesg_checks_results
echo "--------------------------" >> $OUT_DIR/dmesg_checks_results
diff $OUT_DIR/$1.dmesg_emerg $OUT_DIR/$release.dmesg_emerg >> $OUT_DIR/dmesg_checks_results
echo "--------------------------" >> dmesg_checks_results

dmesg -t -l crit > $OUT_DIR/$release.dmesg_crit
echo "dmesg critical regressions" >> $OUT_DIR/dmesg_checks_results
echo "--------------------------" >> $OUT_DIR/dmesg_checks_results
diff $OUT_DIR/$1.dmesg_crit $OUT_DIR/$release.dmesg_crit >> $OUT_DIR/dmesg_checks_results 
echo "--------------------------" >> $OUT_DIR/dmesg_checks_results

dmesg -t -l alert > $OUT_DIR/$release.dmesg_alert
echo "dmesg alert regressions" >> $OUT_DIR/dmesg_checks_results
echo "--------------------------" >> $OUT_DIR/dmesg_checks_results
diff $OUT_DIR/$1.dmesg_alert $OUT_DIR/$release.dmesg_alert >> $OUT_DIR/dmesg_checks_results
echo "--------------------------" >> $OUT_DIR/dmesg_checks_results

dmesg -t -l err > $OUT_DIR/$release.dmesg_err
echo "dmesg err regressions" >> $OUT_DIR/dmesg_checks_results
echo "--------------------------" >> $OUT_DIR/dmesg_checks_results
diff $OUT_DIR/$1.dmesg_err $OUT_DIR/$release.dmesg_err >> $OUT_DIR/dmesg_checks_results
echo "--------------------------" >> $OUT_DIR/dmesg_checks_results

dmesg -t -l warn > $OUT_DIR/$release.dmesg_warn
echo "dmesg warn regressions" >> $OUT_DIR/dmesg_checks_results
echo "--------------------------" >> $OUT_DIR/dmesg_checks_results
diff $OUT_DIR/$1.dmesg_warn $OUT_DIR/$release.dmesg_warn >> $OUT_DIR/dmesg_checks_results
echo "--------------------------" >> $OUT_DIR/dmesg_checks_results

dmesg -t > $OUT_DIR/$release.dmesg
echo "dmesg regressions" >> $OUT_DIR/dmesg_checks_results
echo "--------------------------" >> $OUT_DIR/dmesg_checks_results
diff $OUT_DIR/$1.dmesg $OUT_DIR/$release.dmesg >> $OUT_DIR/dmesg_checks_results
echo "--------------------------" >> $OUT_DIR/dmesg_checks_results

dmesg -t -k > $OUT_DIR/$release.dmesg_kern
echo "dmesg_kern regressions" >> $OUT_DIR/dmesg_checks_results
echo "--------------------------" >> $OUT_DIR/dmesg_checks_results
diff $OUT_DIR/$1.dmesg_kern $OUT_DIR/$release.dmesg_kern >> $OUT_DIR/dmesg_checks_results
echo "--------------------------" >> $OUT_DIR/dmesg_checks_results

echo "--------------------------" >> $OUT_DIR/dmesg_checks_results

echo "End dmesg regression check for $release" >> $OUT_DIR/dmesg_checks_results
