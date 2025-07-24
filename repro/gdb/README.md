# gdb

Here are files and steps to reproduce some bugs. Keep the *version* in mind.

## 01-core-dump

Version: 15.2

1. Run gdb
2. In  gdb, run `file [Some Wayland application that siezes input (i.e fuzzel)]`
3. Set a breakpoint after input has been siezed (i.e scan\_dir)
4. In  gdb, run `run`
5. **If you get a core dump, the bug has been reproduced**
