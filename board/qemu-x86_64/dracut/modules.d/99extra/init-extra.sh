#!/bin/sh

# Enable strict shell mode
set -euo pipefail

PATH=/sbin:/bin:/usr/sbin:/usr/bin

MOUNT="/bin/mount"
UMOUNT="/bin/umount"

INIT="/sbin/init"
ROOT_MOUNT="/mnt"


early_setup() {
	mkdir -p /proc
	mkdir -p /sys
	$MOUNT -t proc proc /proc
	$MOUNT -t sysfs sysfs /sys
	grep -w "/dev" /proc/mounts >/dev/null || $MOUNT -t devtmpfs none /dev
}

read_args() {
	[ -z "${CMDLINE+x}" ] && CMDLINE=`cat /proc/cmdline`
	for arg in $CMDLINE; do
		# Set optarg to option parameter, and '' if no parameter was
		# given
		optarg=`expr "x$arg" : 'x[^=]*=\(.*\)' || echo ''`
		case $arg in
			root=*)
				ROOT_DEVICE=$optarg ;;
			init=*)
			INIT=$optarg ;;
		esac
	done
}

error() {
	echo " $1" >$CONSOLE
	echo >$CONSOLE
	exec sh
}

log() {
	echo "  $1" >$CONSOLE
}

wait_for_device() {
    counter=0
    while [ ! -b $1 ]; do
        sleep .100
        counter=$((counter + 1))
        if [ $counter -ge 50 ]; then
            error "$1 is not availble"
            exit
        fi
    done
}

early_setup

[ -z "${CONSOLE+x}" ] && CONSOLE="/dev/console"

read_args

mount_and_boot() {
	mkdir -p $ROOT_MOUNT
    wait_for_device ${ROOT_DEVICE}


	# Mount root file system to new mount-point, if unsuccessful, try bind
	# mounting current root file system.
	if ! $MOUNT $ROOT_DEVICE "$ROOT_MOUNT" 2>/dev/null ; then
		error "Could not mount $ROOT_DEVICE..."
	fi

	$MOUNT -n --move /proc ${ROOT_MOUNT}/proc
	$MOUNT -n --move /sys  ${ROOT_MOUNT}/sys
	$MOUNT -n --move /dev  ${ROOT_MOUNT}/dev

	# openssl || true
	# cryptsetup --help || true
	# bmap-writer --help || true
	
	cd $ROOT_MOUNT

	# Switch to actual init in the overlay root file system
	exec switch_root $ROOT_MOUNT $INIT ||
		error "Couldn't chroot, dropping to shell"

}

mount_and_boot
