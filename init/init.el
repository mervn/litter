#!/bin/execlineb -P
# Bring up critical components of the system in a, sane, synchronous process.
# Keep in mind, non-critical components can be brought up in prepare-service.
#
# Start with mounts, as almost all other services rely on this.
# /proc and /sys must be mounted first, see mount(8).
#
ifthenelse { mountpoint -q /proc } { } { mount -t proc  none /proc }
ifthenelse { mountpoint -q /sys  } { } { mount -t sysfs none /sys }
ifthenelse { mountpoint -q /run  } { } { mount -t tmpfs none /run }
ifthenelse { mountpoint -q /tmp  } { } { mount -t tmpfs none /tmp }

# /dev is usually mounted by initrd or kernel.
# This may fail, but attempt to handle unmounted case.
#
ifthenelse { mountpoint -q /dev  }

# then
#
{
mount -t devpts -o X-mount.mkdir none /dev/pts
mount -t tmpfs  -o X-mount.mkdir=1777 none /dev/shm
}

# else
#
{
mount -t devtmpfs none /dev

mount -t devpts -o X-mount.mkdir none /dev/pts
mount -t tmpfs  -o X-mount.mkdir=1777 none /dev/shm
}



# Next, activate multigenlru, the memory management optimization.
# This is called early for performance benefits at boot.
#
foreground
{
redirfd -w 1 /sys/kernel/mm/lru_gen/enabled
echo y
}

foreground
{
redirfd -w 1 /sys/kernel/mm/lru_gen/min_ttl_ms
echo 1000
}



# Now, load modules. The system may be unable to boot if modules are missing.
#
elglob modules /etc/modules-load.d/*.conf
ifthenelse { eltest -n \\$modules }

# then
#
{
backtick load { cat $modules }
importas -ius load load

modprobe -a $load
}

# else
#
{ }



# Then, perform fstab(5) procedures. This may have critical mounts (i.e. /home).
# fsck => dump (SKIPPED) => swapon => mount => remount.
#
foreground { fsck -A -P -T }
foreground { swapon -a }
foreground { mount -a }
foreground { mount -o remount,rw / }



# Create tmpfiles, without them, many system services may become inoperable.
# Begin by generating any necessary tmpfiles.
#
foreground { mkdir /run/tmpfiles.d }
foreground { kmod static-nodes -f tmpfiles -o /run/tmpfiles.d/kmod.conf }
foreground { systemd-tmpfiles --boot --create --remove }



# End with sysctl. Often modifies system to perform in a specific way.
# On occassion, without sysctl, a system is effectively unusable.
#
foreground { sysctl -p /etc/sysctl.conf }
