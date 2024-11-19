#!/usr/bin/env bash
BUILDER_WORKING_DIRECTORY=${BUILDER_WORKING_DIRECTORY:-$(readlink -f ../build)}
GNUK_ELF=${BUILDER_WORKING_DIRECTORY}/gnuk/src/build/gnuk.elf

if [ ! -f "$GNUK_ELF" ]; then
    echo "Missing gnuk.elf($GNUK_ELF), make sure you've built it."
    exit 1
fi

set -e

openocd -f interface/stlink.cfg -f target/stm32f1x.cfg \
            -c "program '$GNUK_ELF' verify reset exit"
