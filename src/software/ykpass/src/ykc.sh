#!/bin/sh -Ce
# This is a stub script for "Yubico KeyChain".
# NOTE: This is an alternate and older implementation of ykpass.sh .

while getopts Chosv option
do
	case $option in
	C)
		clipboard=1 ;;

	h | \? )
		echo Usage: ykc [OPTIONS] secret
		echo
		echo Options:
		echo '  -C	Copy result to clipboard'
		echo '  -h	Print help'
		echo '  -o	Print one-time password (OTP)'
		echo '  -s	Print password'
		echo '  -v	Print version'

		exit ;;

	o)
		cmdlist="$cmdlist otp" ;;

	s)
		cmdlist="$cmdlist show" ;;

	v)
		echo Yubico KeyChain \(ykc\) version: 0.0.0

		exit ;;

	esac
done
shift $(( $OPTIND - 1 ))

# ykc(1) aims to be a keychain metaphor.
# Commands are done synchronously, and in succession, similar to handling a key.
#
# If no other command is requested, show the password; similar to viewing a key.
for cmd in ${cmdlist:=show}
do
	case $cmd in
	otp)
		ykman oath accounts code -h ;;

	show)
		awk -h ;;

	*)
		echo Not Implemented.

	esac
done
