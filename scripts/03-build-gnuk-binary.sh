#!/usr/bin/env bash
BUILDER_WORKING_DIRECTORY=${BUILDER_WORKING_DIRECTORY:-$(readlink -f ../build)}
[ -d "$BUILDER_WORKING_DIRECTORY/gnuk" ] || { echo "Please prepare the repo first!"; exit 1; }

pushd "$BUILDER_WORKING_DIRECTORY/gnuk/src"

# FIXME: it's a workaround for nix-shell
if [ -n "$PICOLIBC_SPECS" ]; then
    ln -sf "$PICOLIBC_SPECS"
fi

./configure --enable-factory-reset --target=ST_DONGLE --vidpid=234b:0000 --enable-certdo
make

popd

echo "Done! See $BUILDER_WORKING_DIRECTORY/gnuk/src/build/gnuk.bin"
