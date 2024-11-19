#!/usr/bin/env bash
BUILDER_WORKING_DIRECTORY=${BUILDER_WORKING_DIRECTORY:-$(readlink -f ../build)}
PATCH_FILE=$(readlink -f "$(dirname $0)/../patches/0001-add-pa5-as-switch-pin-for-st-dongle.patch")

[ -d "$BUILDER_WORKING_DIRECTORY/gnuk" ] || { echo "Please prepare the repo first!"; exit 1; }

pushd "$BUILDER_WORKING_DIRECTORY/gnuk/chopstx"
patch -Np1 < "${PATCH_FILE}"
popd

echo "Done!"
