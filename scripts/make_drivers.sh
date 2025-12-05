#!/bin/bash

ROOT_DIR="$(realpath "$(dirname "$0")")/../"
DRIVERS_DIR="${ROOT_DIR}/driver_projects/"
SHARED_DIR="${ROOT_DIR}/share/"

cd $DRIVERS_DIR

for d in $(find . -name Makefile | xargs -n1 dirname); do
	cd $d
	make
	test $? -eq 0  || {echo "Build failed!"}
	cp *.ko $SHARED_DIR
	cd -
done

echo "Drivers built!"
