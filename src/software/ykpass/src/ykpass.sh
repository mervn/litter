#!/bin/sh -Ce

while getopts hv option
do
	case $option in
	h | \? )
		echo Usage: ykpass [OPTIONS] COMMAND ARGS
		echo
		echo Commands:
		echo '  show	Print secret information'
		echo
		echo Options:
		echo '  -h	Print help'
		echo '  -v	Print version'

		exit 0 ;;

	v)
		echo YubiKey Password \(ykpass\) version: 0.0.0

		exit 0 ;;

	esac
done
shift $(( $OPTIND - 1 ))

### THIS IS A STUB! In future versions, setup will be unnecessary.

seed="${XDG_STATE_HOME:-$HOME/.local/state}/ykpass/seed"
cmd="${1:-[none]}"

### END OF STUB.

case "$cmd" in
show)
	# Remove command for getopts(1)
	shift 1

	while getopts Chn showoption
	do

	case $showoption in
	C)
		clipboard="wl-copy --foreground --paste-once" ;;

	h | \? )
		echo Usage: ykpass show [OPTIONS] [NAME] [SALT]
		echo
		echo Options:
		echo '  -C	Copy result to clipboard'
		echo '  -h	Print help'
		echo '  -n	Print name, first'
		echo
		echo Parameters:
		echo '  NAME	Login name of the account'
		echo '  SALT	String to enhance password'

		exit 0 ;;

	n)
		printname=1 ;;

	esac

	done
	shift $(( $OPTIND - 1 ))

	# To simplify the display process, clipboard is always set.
	clipboard="${clipboard:-cat}"
	name="$1"
	salt="$2"

	### THIS IS A STUB! In future versions, ykpass_core.py will handle this.

	secret=$( echo "$name" "$salt" | openssl sha256 -hex -mac HMAC -macopt hexkey:"$( cat $seed )" | awk '{ print $NF }' )

	### END OF STUB.

	# Use the ubiquitous order of 'NAME > PASSWORD'.
	[ -n "$printname" ] && echo "$name" | $clipboard
	echo "$secret" | $clipboard

	;;

*)
	echo Try \'ykpass -h\' for help.
	echo
	echo Error: No such command \'$cmd\'.

	exit 127 ;;

esac
