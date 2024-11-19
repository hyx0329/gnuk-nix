#!/usr/bin/env bash
BUILDER_WORKING_DIRECTORY=${BUILDER_WORKING_DIRECTORY:-$(readlink -f ../build)}
[ -d "$BUILDER_WORKING_DIRECTORY" ] || mkdir -p "$BUILDER_WORKING_DIRECTORY"

set -e

cd "$BUILDER_WORKING_DIRECTORY"
uv venv venv
source venv/bin/activate
uv pip install pytest nose freshen pyusb cffi

echo "Done! You can now activate the environment by sourcing $BUILDER_WORKING_DIRECTORY/venv/bin/activate"
