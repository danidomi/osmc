# (c) 2014-2015 Sam Nazarko
# email@samnazarko.co.uk

#!/bin/bash

. ../common.sh

echo -e "Building package rbp-bootloader"
BOOT="files/boot"
FWFILES="LICENCE.broadcom
start_x.elf
fixup_x.dat
bootcode.bin"
make clean

mkdir -p "${BOOT}"

for file in $FWFILES
do
	wget --no-check-certificate https://raw.githubusercontent.com/raspberrypi/firmware/master/boot/"${file}" -O "${BOOT}"/"${file}"
	if [ $? != 0 ]; then echo "Download failed" && exit 1; fi
done

dpkg_build files/ rbp-bootloader-osmc.deb
