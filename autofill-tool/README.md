# autofill-tool

A libsecret front-end to automate attribute extraction

## Usage

`autofill-tool <attribute value> ...`

Match the first entry where issuer="codeberg.org", then print the secret.

`autofill-tool issuer codeberg.org`

Match the first entry where issuer="codeberg.org", then print the username;
then print the secret.

`autofill-tool -e username -e secret -- issuer codeberg.org`

> WARNING! This is unstable. Do not use in production.

## Install

### Default

`make install`

Runtime depends on:

- POSIX awk
- POSIX sh
- libsecret

## Status

- success (0)
- unknown option (2)
- missing runtime dependency (127)
