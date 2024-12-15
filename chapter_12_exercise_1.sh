#!/bin/bash

# Define variables
boot_image=$1
save_device=$2

# Check arguments
# "$#" holds the number of arguments, -ne 2 means "not equal to 2" i.e. there has to be 2 arguments
if [ "$#" -ne 2 ]; then
    echo "How to: $0 <BOOT_IMAGE.IMG> <SAVE DEVICE>"
    exit 1
fi

# Set trap before the write process
noquit_trap() {
    echo -e "\n*** This action will render the disk unusable!"
    echo -e "*** Let the process finish to avoid harming the device.\n"
}

# Define what type of signal to trap, SIGINT = CTRL+C.
# trap checks for SIGINT and refers to the noquit_trap() function if a SIGINT is detected.
trap noquit_trap SIGINT

# Start the writing process using dd
echo "Starting the write process..."
echo "-----------------------------"
echo "> Writing $boot_image to $save_device."

if dd if="$boot_image" of="$save_device" status=progress; then
    echo -e "\n$boot_image was written to $save_device successfully!"
else
    echo "Writing process failed!"
    exit 1
fi

# Below is how I tested the script.
# 
# Create a fake boot image with a small file size:
# dd if=/dev/zero of=dummy_boot.img count=10
# Use /dev/zero to use its stream of zeros to fill the dummy_boot image.
#
# Run the script:
# ./chapter_12_exercise_1.sh dummy_boot.img dummy_save.img
