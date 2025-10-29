# vars
WORKDIR="$(realpath "$(dirname "$0")")/../qemu-rootfs"
IMG=$WORKDIR/ubuntu-rootfs.img
MNT=$WORKDIR/mnt
DIST=jammy          # ubuntu release, change if you prefer
SIZE=10G

apt install update
apt install debootstrap
mkdir -p $WORKDIR $MNT

# create sparse image & format
qemu-img create -f qcow2 "$IMG" $SIZE
# attach to loop via qemu-nbd to partition & format
sudo modprobe nbd max_part=8
sudo qemu-nbd --connect=/dev/nbd0 "$IMG"

# create a single partition (sda1), ext4
sudo parted -s /dev/nbd0 mklabel msdos
sudo parted -s /dev/nbd0 mkpart primary ext4 1MiB 100%
sudo mkfs.ext4 /dev/nbd0p1

# mount and debootstrap
sudo mount /dev/nbd0p1 $MNT
sudo debootstrap --arch amd64 $DIST $MNT http://archive.ubuntu.com/ubuntu

# minimal chroot setup
sudo mount --bind /dev $MNT/dev
sudo mount --bind /proc $MNT/proc
sudo mount --bind /sys $MNT/sys
sudo cp /etc/resolv.conf $MNT/etc/

sudo chroot $MNT /bin/bash -c "
set -e
echo 'ubuntu-rootfs' > /etc/hostname
apt update
DEBIAN_FRONTEND=noninteractive apt install -y systemd-sysv sudo ssh net-tools iproute2 \
    ifupdown iputils-ping dialog locales less wget curl gnupg lsb-release \
    build-essential linux-headers-generic
# enable root password or create user
echo 'root:root' | chpasswd
useradd -m -s /bin/bash dev && echo 'dev:dev' | chpasswd && adduser dev sudo
"
# cleanup
sudo umount $MNT/dev $MNT/proc $MNT/sys
sudo umount $MNT
sudo qemu-nbd --disconnect /dev/nbd0
sudo rmmod nbd || true

