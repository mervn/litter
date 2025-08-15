### least

A pager that displays "chunks" of a file.
For example, "chunk A" is line 0-10 and "chunk B" is line 11-20.

The program can pass a chunk to an editor, then replace with the edited version.
The program is also aware when the input is from a pipe, and when text on stdin.
The program will redraw on every chunk.

This is primarily for consoles and dumb-terminals.

