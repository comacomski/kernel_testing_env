#!/bin/bash

LINUX_STABLE="$(realpath "$(dirname "$0")")/../linux_stable"
LINUX_MAINLINE="$(realpath "$(dirname "$0")")/../linux_mainline"
LINUX=""
OUT_DIR="$(realpath "$(dirname "$0")")/../out"

set -e

function usage
{
	echo "Usage: $0 <stable | mainline> <absolute/path/to/config | menuconfig | defconfig | done> "
	echo "Example: $0 stable defconfig"
	exit 1
}

if [ -f "$2" ]; then
	CONFIG_FILE="$(realpath $2)"
fi

if [ "$1" == "stable" ]; then
	cd "$LINUX_STABLE" || exit 2
	LINUX=$LINUX_STABLE
elif [ "$1" == "mainline" ]; then
	cd "$LINUX_MAINLINE" || exit 3
	LINUX=$LINUX_MAINLINE
else
	usage
fi
variant=$1
shift

if [ ! -z "$CONFIG_FILE" ]; then
	cp ${CONFIG_FILE} ./.config
	make olddefconfig
	echo "$1 copied to $(realpath .config)"
elif [ "$1" == "menuconfig" ]; then
	make menuconfig
elif [ "$1" == "defconfig" ]; then
	make defconfig
elif [ "$1" == "done" ]; then
	echo "Config already there, proceeding to build!"
else
	usage	
fi

make -j$(nproc)
err=$?
if [ $err != 0 ]; then
	echo "error while compiling!"
	exit $err
fi

mkdir -p "$OUT_DIR"
cp "$LINUX/arch/x86/boot/bzImage" "$OUT_DIR/bzImage"
cd ../
$(realpath $(dirname $0))/run_qemu.sh
