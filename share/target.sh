#!/bin/bash

sudo mkdir -p /mnt/hostshare
sudo mount -t 9p -o trans=virtio,version=9p2000.L hostshare /mnt/hostshare

sudo ip link set enp0s3 up
sudo dhclient
