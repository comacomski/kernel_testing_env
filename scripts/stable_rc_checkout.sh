#!/bin/bash

STABLE_DIR="$(realpath "$(dirname "$0")")/../linux_stable"
rc=$1

if [ -z "$rc" ]; then
	echo "usage: $0 rc_version"
	echo "example: $0 5.2"
    exit 1
fi

cd "$STABLE_DIR"
git reset --hard
git clean -fdx
git fetch stable-rc
git checkout -b stable-rc-$rc stable-rc/linux-$rc.y
