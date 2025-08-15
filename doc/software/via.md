### via

Edit a file, then chmod atomically. Here is the flow:

1. Create a temporary copy of the file.
2. Edit the temporary file.
3. Change the permission of the original location to be writable.
4. Move the temporary file to the original location.
5. Change the permission of the original location to its previous state.

Steps 3-5 should happen at the same time, to prevent a race with an outside
editor process.

