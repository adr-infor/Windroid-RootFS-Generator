#!/bin/bash

showHelp()
{
	echo "Usage: $0 [ROOTFS_FILE] [OUTPUT_DIR]"
	echo ""
	echo "Extracts individual .rat packages from an existing Windroid RootFS .rat file"
	echo ""
	echo "Example: $0 Windroid-RootFS-(abc123)-x86_64.rat built-pkgs/"
}

if [ $# -lt 2 ]; then
	showHelp
	exit 1
fi

ROOTFS_FILE="$1"
OUTPUT_DIR="$2"

# Check if input file exists
if [ ! -f "$ROOTFS_FILE" ]; then
	echo "Error: RootFS file '$ROOTFS_FILE' not found"
	exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Create temporary directory
TMP_DIR=$(mktemp -d)
echo "Using temporary directory: $TMP_DIR"

echo "Extracting RootFS file..."
tar -xf "$ROOTFS_FILE" -C "$TMP_DIR"

# Function to copy .rat files
copyRatFiles()
{
	local src_dir="$1"
	if [ -d "$src_dir" ]; then
		echo "Copying packages from $(basename "$src_dir")..."
		cp -f "$src_dir"/*.rat "$OUTPUT_DIR"/ 2>/dev/null || true
	fi
}

# Copy packages from known subdirectories
copyRatFiles "$TMP_DIR/vulkanDrivers"
copyRatFiles "$TMP_DIR/adrenoTools"
copyRatFiles "$TMP_DIR/box64"
copyRatFiles "$TMP_DIR/wine"

# Cleanup
echo "Cleaning up temporary directory..."
rm -rf "$TMP_DIR"

echo ""
echo "Done! Extracted packages to: $OUTPUT_DIR"
echo "Available packages:"
ls -1 "$OUTPUT_DIR"/*.rat 2>/dev/null || echo "  No .rat packages found"

