#!/bin/sh -e
progname="autofill-tool"
version="0.2.5"

# The default character(s) used to separate secret-service attribute definition.
define_separator='attribute\056'

# The default character(s) used to separate secret-service attribute-value pair.
keyval_separator=' \075 '

# The default character(s) used to separate program outputs.
output_separator='\n'

# The default character(s) used to separate target structure.
struct_separator='\037'

# The default character(s) used to separate targets.
target_separator='\036'

# The default attribute(s) to extract.
target_default='secret'

search() {
	# As of libsecret-0.21.4, secret-tool(1) does not return an error when a
	# search fails. This wrapper ensures an error is returned.

	# The stderr must be captured, as attribute.* is output there.
	local data="$(secret-tool search --unlock -- "$@" 2>&1)"

	[ -n "$data" ] && echo "$data"
}

usage() {
	echo "usage: $progname -h | -v | -0Ee [--] <attribute value> ..." >&2
}

version() {
	echo "$progname $version" >&2
}

while getopts 0E:e:hv option
do
	case $option in
	0)
		output_separator='\0'
		;;

	E)
		target="${target:+$target$target_separator}${OPTARG}${struct_separator}"
		;;

	e)
		target="${target:+$target$target_separator}${OPTARG}"
		;;

	h)
		usage
		exit 0
		;;

	v)
		version
		exit 0
		;;

	\?)
		usage
		exit 2
		;;

	esac
done
shift $(( $OPTIND - 1 ))

# Resolve non-printable characters.
target="$( printf "${target:-$target_default}" )"

# CAPITAL represents builtin vars; CamelCase represents custom vars.
search "$@" | awk	-v FS="$keyval_separator"	\
			-v ORS="$output_separator"	\
			-v DefineSep="$define_separator"\
			-v StructSep="$struct_separator"\
			-v TargetSep="$target_separator"\
			-v Target="$target"		\
'
	      {
		k = $1
		sub(DefineSep, "", k)

		# Value must not be modified in any way.
		v = $2

		# All sanitization must be complete before this point!
		secrets[k] = v
	}

	END   {
		len = split (Target, fields, TargetSep)

		for (i = 1; i <= len; i++) {
			query = fields[i]
			shell = gsub(StructSep, "", query)

			# All sanitization must be complete before this point!
			value = secrets[query]

			if      (shell) {
				system (value)

			}
			else if (value) {
				print value

			}
			else {
				# This should be treated as an error, but will
				# not be an error in processing.

				print ""

			}
		}
	}
'
