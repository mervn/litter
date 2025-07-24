#!/bin/execlineb -s0
# This wrapper script is invoked by xdg-desktop-portal-termfilechooser.
#
# Inputs:
# 1. "1" if multiple files can be chosen, "0" otherwise.
# 2. "1" if a directory should be chosen, "0" otherwise.
# 3. "0" if opening files was requested, "1" if writing to a file was
#    requested. For example, when uploading files in Firefox, this will be "0".
#    When saving a web page in Firefox, this will be "1".
# 4. If writing to a file, this is recommended path provided by the caller. For
#    example, when saving a web page in Firefox, this will be the recommended
#    path Firefox provided, such as "~/Downloads/webpage_title.html".
#    Note that if the path already exists, we keep appending "_" to it until we
#    get a path that does not exist.
# 5. The output path, to which results should be written.
#
# Output:
# The script should print the selected paths to the output path (argument #5),
# one path per line.
# If nothing is printed, then the operation is assumed to have been canceled.#
#
multidefine $@
{ multiple directory save path out }

# Alert the user of the required filetype.
#
ifthenelse
{ eltest directory = 0 }
{ define prompt file }
{ define prompt dir  }

# tofi(1) does not interpret 0/1 as false/true.
# Convert `save` (input 3) since `--require-match` is dependent on it.
#
ifthenelse
{ eltest save = 0 }
{ define saveguard true  }
{ define saveguard false }

# Alert the user of the default PATH.
# `path = ""` is used for consistency, `-z path` can be used instead.
#
ifthenelse
{ eltest path = "" }
{ define pathresolv "no default" }
{ define pathresolv "default: $path" }

# Generally, ls(1p) is not recommended for scripting use, but it is viable here.
# tofi(1) cannot handle filenames with \n , so it is not removing functionality.
# It is also helpful to include './..' and have a trailing-slash on directories.
#
backtick -E list
{ ls -1 -a -p }

backtick -E selection
{
	heredoc 0 $list
	tofi --placeholder-text=${pathresolv} --prompt=${prompt}
	--require-match=${saveguard}
}

case -s $selection
{
}
