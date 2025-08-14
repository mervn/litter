#!/bin/sh

# PCI ports affected by quirk:
echo 1 >/sys/devices/pci0000\:00/0000\:00\:1b.0/remove

# Fix quirk.
echo 1 >/sys/bus/pci/rescan
