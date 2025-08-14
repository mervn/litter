#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-or-later

check() {
    require_binaries echo || return 1
    return 0
}

depends() {
    return 0
}

install() {
    inst echo

    # Under ideal circumstances, this would be 'cmdline 01'. However, PCI is not
    # available fast enough - before 'cmdline 30' - for this to be useful. The
    # current placement keeps it out of the way of critical processes.
    inst_hook pre-mount 95 "$moddir/pci-rescan.sh"
}
