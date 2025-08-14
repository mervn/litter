
# sutools

This was an attempt to make common operations (i.e read/write a file) safer to
perform as root - by spending as much time as possible outside of root.

The maintainer should use su(1) instead of alternative, like sudo(1), to have
a more portable package.

## Notes

suedit (EDITOR), sumesg(LOG), suopen(XDG-OPEN), and suprobe(CD/LS)

./suedit
rw -> pass file
r  -> pass tmpfile then priveleged write
w  -> pass tmpfile after priveleged read
   -> pass tmpfile after priveleged read then priveleged write

[Build options]
--disable-pam           : do not use PAM as an authentication method
--enable-su             : install su implementation
[Runtime options]
-x,--one-file-system    : stay in filesystem when creating files

* May be able to lower needed checks for same result
* No SUID/SGID, use CAP\_SET\_{G/U}ID with safesetid-LSM
* tmpfile = suedit.{path} ; it can now also be a lockfile
* tmpfile special chars (/\?#) must be remapped
* use 0077 umask, without this, unauthorized access is possible
