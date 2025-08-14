#!/bin/execlineb -s0
# Setup basic environment.
#
/bin/export PATH /bin:/sbin

# Ensure devtmpfs is mounted.
# Since mountpoint(1) will fail (no /proc), check if console exists.
#
ifthenelse
{ eltest -c /dev/console }
{ }
{ mount -o mode=755,nosuid -t devtmpfs none /dev }

# Take control of the console.
#
define console /dev/console
redirfd -u 0 $console
redirfd -u 1 $console
redirfd -u 2 $console

getpid -EP pid
ifelse -n
{ eltest $pid -eq 1 }
{ echo "The PID of this process is not 1. Reboot the machine." }

# Mount necessary filesystems.
# proc and sysfs must be mounted first, see mount(8).
#
foreground
{ mount -o X-mount.mkdir=555 -t proc none /proc }

foreground
{ mount -o X-mount.mkdir=555 -t sysfs none /sys }

foreground
{ mount -o remount,rw / }

foreground
{ mount -o X-mount.mkdir=755,nodev,noexec,nosuid -t tmpfs none /run }

# Create necessary files.
#
foreground
{ mkdir -m 750 -p /run/initramfs }

# Load modules.
# Modules should be loaded in "waves" to avoid unnecessary external calls.
# A "wave" is a bundle of modules that have all of their dependecies loaded.
#
