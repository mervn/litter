# fuzzel

Here are files and steps to reproduce some bugs. Keep the *version* in mind.

## 01-desktop-fallthrough:

Version: 1.11.1 +cairo +png +svg(librsvg) -assertions

If a user-defined .desktop file contains a key that fuzzel cannot interpret, it
will use the global .desktop file instead. **This is done without warning**.

1. Copy 01-desktop-fallthrough/firefox.desktop to global-location/firefox.desktop
2. Copy 01-desktop-fallthrough/firefox.desktop.bad to user-location/firefox.desktop
3. Run fuzzel
4. Search for Firefox
5. **If Firefox appears, the bug has been reproduced**

global-location = $XDG\_DATA\_DIRS/applications *or* /usr/local/share/applications
user-location = $XDG\_DATA\_HOME/applications *or* $HOME/.local/share/applications
