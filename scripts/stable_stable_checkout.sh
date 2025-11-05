#!/bin/bash

STABLE_DIR="$(realpath "$(dirname "$0")")/../linux_stable"
stable=$1

if [ -z "$stable" ]; then
    echo "usage: $0 stable_version"
    echo "example: $0 5.15"
    exit 1
fi

cd "$STABLE_DIR"
git reset --hard
git clean -fdx
git fetch origin
git checkout -b stable-$stable origin/linux-$stable.y

