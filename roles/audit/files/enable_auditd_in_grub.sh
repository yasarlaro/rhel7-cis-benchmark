#!/usr/bin/sh
# Correct the form of default kernel command line in GRUB
GRUB_CFG="/etc/default/grub"
if grep -q '^GRUB_CMDLINE_LINUX=.*audit=.*"'  "${GRUB_CFG}" ; then
	# modify the GRUB command-line if an audit= arg already exists
	sed -i 's/\(^GRUB_CMDLINE_LINUX=".*\)audit=[^[:space:]]*\(.*"\)/\1 audit=1 \2/' "${GRUB_CFG}"
else
	# no audit=arg is present, append it
	sed -i 's/\(^GRUB_CMDLINE_LINUX=".*\)"/\1 audit=1"/' "${GRUB_CFG}"
fi

# Correct the form of kernel command line for each installed kernel in the bootloader
grubby --update-kernel=ALL --args="audit=1"