### sheriff

Sheriff is to TOMOYO, as SMACK is to SELinux. For cleaner and simpler codebase
and tools. And also to use git(1) as the version control system.

The modes are:

- enforce: policy applied
- learn: policy created
- spy: activity logged

In learn and spy mode, every process is sandboxed. This program can be tweaked
by non-priveleged users.

