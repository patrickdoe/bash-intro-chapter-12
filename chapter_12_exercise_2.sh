#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Variables
download_url="https://github.com/fastfetch-cli/fastfetch/archive/refs/tags/2.31.0.tar.gz"
build_dir="/tmp/fastfetch_test_build"

# Make sure that the user is using "sudo": EUID 0 = root
if [[ $EUID -ne 0 ]]; then
  echo "Oops! You must run this script as root."
fi

# Create the temporary build directory
echo -e "\n> Creating temporary build directory: $build_dir\n"
mkdir -p "$build_dir"
cd "$build_dir"
sleep 1

# Download the application: -q for "quiet" and -O for "output file"
echo -e "> Downloading Fastfetch...\n"
wget -q "$download_url" -O "2.31.0.tar.gz"
sleep 1

# Decompress the tarball: -xzf for 1. "extract", using "gzip" and "file"
echo -e "> Decompressing tarball...\n"
tar -xzf "2.31.0.tar.gz"
cd "fastfetch-2.31.0"
sleep 1

# Compile the extracted source code: 
echo -e "> Compiling source code...\n"
cmake -B build				# Separate build files from source code by creating a "build" directory
cmake --build build			# Build and store files in the "build" directory
sleep 1

# Install the package
echo -e "\n> Installing Fastfetch...\n"
cmake --install build		# Install from the compiled files in the "build" directory
sleep 1

# Remove the temporary build directory, -rf = recursive + forced.
echo -e "\n> Removing temporary build directory...\n"
rm -rf "$BUILD_DIR"
sleep 1

# Confirm installation
echo -e "> Fastfetch has been installed successfully!\n"

