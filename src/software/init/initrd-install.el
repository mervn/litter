#!/bin/execlineb -S2
# Generate initrd, from a template, for the incoming kernel.
#
importas -i generator INSTALLKERNEL_INITRD_GENERATOR
if
{ eltest $generator = template }

ifelse -n
{ eltest -d /lib/modules/${1} }
{ echo "The initrd cannot be generated. The modules for $1 are not installed." }

define template /usr/local/src/template-initrd
ifelse -n
{ eltest -f ${template}/init }
{ echo "The initrd cannot be generated. The file ${template}/init is missing." }

# Stage initrd from template.
#
define buildtmp /var/tmp/initramfs-${1}
foreground
{ rm -Rf $buildtmp }

foreground
{ cp -HR $template $buildtmp }

# Add requested modules to staging.
#
foreground
{
	# The file MODULES.conf is reserved for module selection.
	# Beware, if files do not end with '\n', the last line will be ignored.
	#
	forbacktickx -CE mod
	{ cat ${buildtmp}/MODULES.conf }

	pipeline
	{ modprobe -S ${1} --show-depends $mod }

	pipeline
	{ sed "s/.* \\//\\//" }

	# Comments about this approach:
	#	* can be substituted with execlineb (forstdin)
	#	* not POSIX compliant (cp --parents -t)
	#	* should be POSIX compliant. GNU-coreutils are not guaranteed.
	#
	xargs cp --parents -t $buildtmp
}

# Define installation path.
# The kernel path ($2) is [rel]ative to the **starting** working directory.
# If the [dir]ectory was changed before this point, the following will fail.
#
backtick -E rel
{ dirname $2 }

getcwd -E dir

# Build initrd and install.
#
execline-cd $buildtmp
pipeline
{ find . -print0 }

pipeline
{ cpio -0 -H newc -o }

zstd -9fo ${dir}/${rel}/initrd
