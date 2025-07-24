
# ykpass

(Y)ubi(K)ey (Pass)word ; Generate passwords with YubiKey.

***This is currently in pre-alpha, it is not recommended for production-use.***

---

    # Generate a password
    ykpass show "your username" "the website"

    # Copy to clipboard
    ykpass show -C "your username" "the website"

    # Also copy username to clipboard to avoid retyping
    ykpass show -Cn "your username" "the website"

## Description

This tool allows you to generate passwords using a YubiKey. The passwords are
not one-time use, as long as the input is the same, the output is the same.

YubiKey is not a suitable password manager - there is accessible plaintext and
confined storage. YubiKey is a suitable password *generator*, however - there is
on-board computation and seed management. This means that, as long as there is a
consistent algorithm, the YubiKey can be used to re-generate a password. This is
where ykpass(1) comes in.

The generation algorithm is inspired by [Master Password](https://spectre.app),
which may be an alternative.

## Installation

These dependencies are required:

- awk
- openssl (with SHA256 support)
- sh (with POSIX support)

These dependencies are optional:

- wl-clipboard

To install, run:

    make install

***Do not use this in production. The algorithm is not stable and the seed is
stored on disk (and may be compromised). This is in the extremely early phases
of development; this point cannot be stressed enough.***

## Why use this before it's stable?

Your bugs and usage patterns are an important part of getting this project
stable. Please submit an email, issue, or pull-request.
