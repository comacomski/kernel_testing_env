#!/bin/bash

STABLE_DIR="$(realpath "$(dirname "$0")")/../linux_stable"
rc=$1

if [ -z "$rc" ]; then
	echo "usage: ./stable_rc checkout rc_version"
	echo "example: ./stable_rc checkout 5.2"
fi

cd "$STABLE_DIR"
git fetch stable-rc
git checkout -b stable-rc-$rc stable-rc/linux-$rc.y
