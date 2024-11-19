#!/usr/bin/env bash
BUILDER_WORKING_DIRECTORY=${BUILDER_WORKING_DIRECTORY:-$(readlink -f ../build)}
[ -d "$BUILDER_WORKING_DIRECTORY" ] || mkdir -p "$BUILDER_WORKING_DIRECTORY"

cd "$BUILDER_WORKING_DIRECTORY"
if [ -d gnuk ]; then
    if [ -d gnuk/.git ]; then
        echo "The repo exists! At $BUILDER_WORKING_DIRECTORY/gnuk"
    else
        echo "The directory($BUILDER_WORKING_DIRECTORY/gnuk) is occupied! Please rename or delete it!"
    fi
else
    git clone --recursive https://salsa.debian.org/gnuk-team/gnuk/gnuk.git gnuk
    echo Done! Repo cloned to $BUILDER_WORKING_DIRECTORY/gnuk
    echo Remember to checkout the desired branch/revision!
fi
