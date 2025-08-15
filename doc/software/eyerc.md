### eyerc

A driver program which simulates an IRC client. Users must supply **all**
components - including connection management (i.e ncat).

The program will simply send the output of one program to the input of another
in a sane way. Here is an example:

- Get password (gnome-keyring) and send to IRC (ncat).
- Send IRC responses (ncat) to a filter (ansifilter).
- Send filtered text (ansifilter) to a frontend (lchat).

Users can swap out a program from any example with their desired choice.

