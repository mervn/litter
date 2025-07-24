# litter

This repo is an archive of code that I have abandoned.

The goal is to get these lines-of-code a new maintainer.
Code may be removed if it's old, poor-quality, redundant, or unabandoned.

## Navigate

Code exists in sub-directories - which are titled by the *project* name.
Filenames with "README" are manuals. Filenames ending with "-v<#>" are versions.

Pseudo-ish code exists in **Blueprint** - the section below.

## Blueprint

### RAAC

The painfully simple ISA.

RAAC is to RISCV, as MUSL is to GLIBC.
It is a reduced instruction-set that is not extensible in any way.

Name means (R)educe (A)t (A)ll (C)osts.

### androp

Android program that handles Apple's AirDrop using opendrop's reverse-engineered
implementation.

This may require root and specific WiFi features.

### classified

CLI that is daemonless, deeply integrated with the (linux) keyring, and has
smartcard support. It does not keep its data(base) unencrypted during operation.

It must has a secret-service dbus interface, as this is its primary use-case.

### cname-cloaking-blocklist

Fork of "next-dns/cname-cloaking-blocklist" intended for unbound(8).

### coin

A barebone implementation of envelope-budgeting and reactive-spending. In
particular, this will both gather (i.e from banks) and interpret financial-data.

Has an API via libcoin.

### delayexec

A shell-builtin that replaces the shell-process with a background-process.
Here is the flow:

1. run a longrun process in the background (via delayexec)
2. run arbitrary commands
3. call delayexec and replace the current shell with the background-process

Here is an example:

    # Handoff to dbus-daemon at the shell's request
    delayexec dbus-daemon --nofork --print-address

    # Run arbitrary commands
    echo $DBUS_SESSION_BUS_ADDRESS is here

    # The shell will now handoff to sleep!!!
    delayexec sleep inf

    # Handoff control to longrun process
    delayexec

### deliver

A barebone implementation of personal-information-management. In particular,
this will combine minimal functions of mbsync(1), vdirsyncer(1), khal(1),
khard(1), and mutt(1).

Has an API via libdeliver.

### eyerc

A driver program which simulates an IRC client. Users must supply **all**
components - including connection management (i.e ncat).

The program will simply send the output of one program to the input of another
in a sane way. Here is an example:

- Get password (gnome-keyring) and send to IRC (ncat).
- Send IRC responses (ncat) to a filter (ansifilter).
- Send filtered text (ansifilter) to a frontend (lchat).

Users can swap out a program from any example with their desired choice.

### hope

Secure data without hardware, password, or physical access.

The purpose is to only allow data access with "where you are" and "who you are".

The implementation of this is admittedly very difficult and hard to keep viable.

### ifconfig

An equivalent of OpenBSD ifconfig(1), in Linux. Attempt non-daemon WPA config.

### irssi (pkcs\#11 patch)

An IRC client that can use CertFP with a smartcard.

### joy

A game-development toolkit targeting embedded systems.

The library has an emphasis for using portable C - for its ABI stability and
support of static linking.

Has an API via libjoy.

### least

A pager that displays "chunks" of a file.
For example, "chunk A" is line 0-10 and "chunk B" is line 11-20.

The program can pass a chunk to an editor, then replace with the edited version.
The program is also aware when the input is from a pipe, and when text on stdin.
The program will redraw on every chunk.

This is primarily for consoles and dumb-terminals.

### mv (regex patch)

Rename files after a regex substitution in the PATH.

Currently, mv(1) does not support `mv something.txt fak*/dir*/anything.txt`.

### netsurf (mujs patch)

For extremely limited systems, use mujs; instead of duktape, as the embedded-js.

### pam\_ccid

This is pam\_unix(8) for smartcards, with an emphasis on "account", "password",
and "session" contexts - since most ccids handle "auth".

### pam\_servd

User-service management from PAM. Starts service-manager on login (via PAM) and
kills it on logout.

### pwnd

Pipewire session manager with a focus of one system-wide process handling audio
multiplexing, also without lua

Name means (P)ipe(W)ire (N)' (D)aemon.

### revolve

Set a file as stdin and stdout.

### sfar

A program that sets resume-swap from userspace via SNAPSHOT\_SET\_SWAP\_AREA.

The purpose is to allow hibernation for systems without a dedicated swapspace.

Name means (S)wap(F)ile (A)nd (R)esume.

### sheriff

Sheriff is to TOMOYO, as SMACK is to SELinux. For cleaner and simpler codebase
and tools. And also to use git(1) as the version control system.

The modes are:

- enforce: policy applied
- learn: policy created
- spy: activity logged

In learn and spy mode, every process is sandboxed. This program can be tweaked
by non-priveleged users.

### spider

Browser as a filesystem. Here are the conversions:

- HTML: Directory
- Form: Pseudo-file (like sysfs)
- Link: Symlink
- Script: Pipe
- Text: File
- Web-socket: Socket

This is intended to have the same effect git(1) had for VCS, as now programs
can act on internals like filesystem-objects.

### sweep

A driver program that uses curl(1) as browser navigation. Here is the flow:

1. Fetch HTML (via curl)
2. Render HTML without loading remote content
3. When click on remote-content, use user-defined command and refresh
4. When click on link, use user-defined command and repeat from step1

The program should be portable (POSIX C or Shell) and use commonly installed
libraries/programs.

### vdisks

Fork of "storaged-project/udisks" intended for systems without polkit(8).

Use fine-grained DBus interface, along with DBus policy, to grant device access.

There may be a ranking which allows "more priveleged" users to have priority for
synchronous-operations and locks.

### via

Edit a file, then chmod atomically. Here is the flow:

1. Create a temporary copy of the file.
2. Edit the temporary file.
3. Change the permission of the original location to be writable.
4. Move the temporary file to the original location.
5. Change the permission of the original location to its previous state.

Steps 3-5 should happen at the same time, to prevent a race with an outside
editor process.

### voidfs

The /dev/null filesystem. If an operation is performed, it is discarded.

### xdg-desktop-portal-byo

Redirects all xdg-desktop-portal requests to user-defined commands.
A logical extension of "xdg-desktop-portal-termfilechooser".

Name means xdg-desktop-portal-(b)ring(y)our(o)wn.

### xdg-desktop-portal-camera

The camera implementation should be separate from any particular organization.

### y

An arithmetic program that parses the math-subset of C syntax.
