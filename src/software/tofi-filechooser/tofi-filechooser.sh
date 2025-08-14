#!/bin/sh -eu
# This wrapper script is invoked by xdg-desktop-portal-termfilechooser.
#
# Inputs:
# 1. "1" if multiple files can be chosen, "0" otherwise.
# 2. "1" if a directory should be chosen, "0" otherwise.
# 3. "1" if file-write was requested, "0" if file-open.
#    When uploading files in Firefox, this will be "0".
#    When saving a web page in Firefox, this will be "1".
#
# 4. If writing to a file, this is recommended path.
#    When saving a web page in Firefox, this will be the recommended
#    path Firefox provided, such as "~/Downloads/webpage_title.html".
#
#    Note that if the path already exists, we keep appending "_" to it
#    until we get a path that does not exist.
#
# 5. The output path, to which results should be written.
#
# Output:
# The script should print the selected paths to the output path (argument #5),
# one path per line.
#
# If nothing is printed, then the operation is assumed to have been canceled.
#
multiple="$1"
directory="$2"
save="$3"
path="$4"
out="$5"

# Alert the user of relevant process information.
#
prompt=$(test "$directory" -eq 0 && echo "file: " || echo "dir: ")
retain=$(test "$save" -eq 0 && echo "open " || echo "write ")
sout=""

# File selection loop ; Main loop .
#
while true;
do
	# Generally, using ls(1p) non-interactively is bad practice.
	# However, here it is viable:
	#
	#	* For efficiency/speed, only one directory's content is visible.
	#	This is more difficult in find(1p).
	#
	#	* It is helpful to include `.` and `..` directories to traverse.
	#	This is significantly more difficult in find(1p).
	#
	#	* It is helpful to visually differentiate directories and files.
	#	This is not natively supported in find(1p).
	#
	#	* tofi(1) cannot handle sanitized filenames with a newline.
	#
	selection=$(ls -1 -a -p | tofi	--history=false \
					--placeholder-text="${path}" \
					--prompt-text="${retain}${prompt}" \
					--require-match=false \
		   )

	if test -n "$selection" ;
	then
		accept=""
		case "$selection" in
		./)
			test "$directory" -eq 0 || accept=yes
			;;
		*/)
			cd "$selection"
			;;

		# All remaining patterns are interpreted as files.
		#
		*)
			test "$directory" -eq 0 && accept=yes
			;;
		esac

		# Only accept selections of the requested filetype (d or f).
		#
		if test -n "$accept" ;
		then
			sout="$(pwd)/${selection%/}\n${sout}"

			#  Multi-selection mode: Continue and discard default
			# Single-selection mode: Exit
			#
			test "$multiple" -eq 0 && break || path=""
		fi
	else
		if test -n "$path" ;
		then
			usedef=$(echo "no\nyes" | tofi \
					--history=false \
					--prompt-text="${retain}${path} ?" \
					--placeholder-text="" \
					--require-match=true \
				)

			# Sanitation unneeded, appended lines are not expected.
			#
			test "$usedef" = yes && sout="$path"
		fi

		# Main loop should always end on empty selection.
		#
		break
	fi
done

# Send all selected entries to the processor.
#
echo -n "$sout" > "$out"
