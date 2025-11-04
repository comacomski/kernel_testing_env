#!/bin/bash

LINUX_STABLE="$(realpath "$(dirname "$0")")/../linux_stable"
LINUX_MAINLINE="$(realpath "$(dirname "$0")")/../linux_mainline"

git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git $LINUX_STABLE
cd $LINUX_STABLE
git remote add stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git

echo "Stable repo cloned, with origin and stable-rc remotes added."
