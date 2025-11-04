#!/bin/bash

mkdir -p /mnt/hostshare
mount -t 9p -o trans=virtio,version=9p2000.L,access=client hostshare /mnt/hostshare

sudo ip link set enp0s3 up
sudo dhclient
