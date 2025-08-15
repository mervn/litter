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

