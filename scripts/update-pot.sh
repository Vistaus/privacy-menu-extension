#!/bin/bash
#This script scans the source code for any translatable strings and updates the po/messages.pot file accordingly

#Change to repository root and exit on failure
set -e
cd "$( cd "$( dirname "$0" )" && pwd )/.." || exit 1
cd "extension" || exit 1

#Update the template file with the strings from the source files
xgettext --from-code=UTF-8 \
         --add-comments=Translators \
         --copyright-holder="Stuart Hayhurst" \
         --package-name="privacy-menu-extension" \
         --output=po/messages.pot \
         -- *.js ui/*/*.ui

#Replace some lines of the header with our own
sed -i '1s/.*/# <LANGUAGE> translation for the Privacy Quick Settings GNOME Shell Extension./' po/messages.pot
sed -i "2s/.*/# Copyright (C) $(date +%Y) Stuart Hayhurst/" po/messages.pot
sed -i '17s/CHARSET/UTF-8/' po/messages.pot

echo "Generated translation list"
