#!/bin/sh
# Install the amber theme(s) into the user's theme directory.
#
# Usage: ./install.sh [-b]
#   -b   rebuild the themes (make clean && make) before installing
#
# Set THEMES_DIR to install somewhere other than ~/.themes.

set -eu

cd "$(dirname "$0")"

THEMES_DIR="${THEMES_DIR:-$HOME/.themes}"
BUILD_DIR="usr/share/themes"

if [ "${1:-}" = "-b" ] || ! ls -d "$BUILD_DIR"/*Amber >/dev/null 2>&1; then
    echo "Building themes..."
    make clean
    make
fi

mkdir -p "$THEMES_DIR"

for theme in "$BUILD_DIR"/*Amber; do
    name="$(basename "$theme")"
    # Remove the old copy first so stale files don't linger
    rm -rf "${THEMES_DIR:?}/$name"
    cp -r "$theme" "$THEMES_DIR/"
    echo "Installed $name to $THEMES_DIR"
done
