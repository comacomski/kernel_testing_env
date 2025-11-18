#!/bin/bash

STABLE_DIR="$(realpath "$(dirname "$0")")/../linux_stable"
rc=$1
BRANCH_NAME="stable-rc-$rc"
REMOTE_BRANCH="stable-rc/linux-$rc.y"

if [ -z "${rc}" ]; then
	echo "usage: $0 rc_version"
	echo "example: $0 5.2"
    exit 1
fi

cd "$STABLE_DIR"
git reset --hard
git clean -fdx
git fetch stable-rc
git checkout master
git branch -D ${BRANCH_NAME}
echo "Creating branch: ${BRANCH_NAME} from: ${REMOTE_BRANCH}"
git checkout -b $BRANCH_NAME $REMOTE_BRANCH
