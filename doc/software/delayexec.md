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

