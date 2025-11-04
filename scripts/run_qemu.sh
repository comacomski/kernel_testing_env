#!/bin/bash
# paths
IMG="$(realpath "$(dirname "$0")")/../qemu-rootfs/ubuntu-rootfs.img"
KERNEL="$(realpath "$(dirname "$0")")/../out/bzImage"     # your compiled bzImage
SHARE_DIR="$(realpath "$(dirname "$0")")/../share"

qemu-system-x86_64 \
  -m 4G -smp 4 \
  -kernel "$KERNEL" \
  -append "root=/dev/sda1 rw console=ttyS0 loglevel=3" \
  -hda "$IMG" \
  -nographic \
  -netdev user,id=net0,hostfwd=tcp::2222-:22 \
  -device virtio-net-pci,netdev=net0 \
  -fsdev local,id=fsdev0,path="$SHARE_DIR",security_model=mapped \
  -device virtio-9p-pci,fsdev=fsdev0,mount_tag=hostshare

