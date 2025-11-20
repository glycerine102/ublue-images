#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Set variables
LUDUSAVI_URL=https://github.com/mtkennerly/ludusavi/releases/download/v0.30.0/ludusavi-v0.30.0-linux.tar.gz
TEMP_DIR=$(mktemp -d)
BINARY_DIR=/usr/bin

# Download the tar.gz file
curl -L -o "$TEMP_DIR/ludusavi.tar.gz" "$LUDUSAVI_URL"

# Extract the tar.gz file to the temporary directory
tar -xzvf "$TEMP_DIR/ludusavi.tar.gz" -C "$TEMP_DIR"

# Copy the binary to /usr/bin/
cp "$TEMP_DIR/ludusavi" "$BINARY_DIR/ludusavi"

# Perform chmod and chown on the newly copied file
chmod 0755 "$BINARY_DIR/ludusavi"
chown root:root "$BINARY_DIR/ludusavi"

# Clean up temporary directory
rm -rf "$TEMP_DIR"
