#!/bin/bash

# modifyed of well knowed script `qcom-firmware-extract` it's a over-simplified targeting files of potential interest to be extracted form running win 11 on Dell Latitude 7455 Snapdragon x12-80-100-

set -e
set -u

# We force model directly
device_path="dell/latitude-7455"

# Path of the FileRepository mounted from Windows
WIN_FW_PATH="/mnt/c/Windows/System32/DriverStore/FileRepository"

# Output folders
other_files="$HOME/dumps/other_dump/"
outdir="$HOME/dumps/firmware-dump/$device_path"
mkdir -p "$other_files"
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
    cp -r "$dir" "$other_files"
done

find "$WIN_FW_PATH" -type f \( \
    -iname "adsp_dtbs.elf" -o \
    -iname "adspr.jsn" -o \
    -iname "adsps.jsn" -o \
    -iname "adspua.jsn" -o \
    -iname "battmgr.jsn" -o \
    -iname "cdsp_dtbs.elf" -o \
    -iname "cdspr.jsn" -o \
    -iname "qcadsp8380.mbn" -o \
    -iname "qccdsp8380.mbn" -o \
    -iname "qcdxkmsuc8380.mbn" \
    \) | while read -r fwdir; do
    echo "[+] Copying from: $fwdir"
    cp -r -f "$fwdir" "$outdir"
done

find /home/annie/dumps/ -type d -exec chmod 744 {} \;
find /home/annie/dumps/ -type f -exec chmod 644 {} \;

echo "[✓] Firmware copied to: $outdir"
