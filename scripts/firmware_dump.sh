#!/bin/bash

set -e
set -u


# We force model directly
device_path="dell/latitude-7455"

# Path of the FileRepository mounted from Windows
WIN_FW_PATH="/mnt/c/Windows/System32/DriverStore/FileRepository"

# Output folder
outdir="$HOME/firmware-dump/$device_path"
mkdir -p "$outdir"

echo "[*] Searching for firmware in: $WIN_FW_PATH"

# Search for relevant folders (you can refine patterns according to device)
find "$WIN_FW_PATH" -type d \( \
    -iname "*qcom*" -o \
    -iname "*qualcomm*" -o \
    -iname "*wifi*" -o \
    -iname "*bt*" -o \
    -iname "*bluetooth*" \
\) | while read -r dir; do
    echo "[+] Copying from: $dir"
    cp -r "$dir" "$outdir/"
done

echo "[✓] Firmware copied to: $outdir"

