#!/bin/bash

## レポジトリチェックスクリプト

check_dirname=$(pwd | awk -F/ '{ print $NF }')
date=$(LANG=C date)

echo -e "# -- $date --"
echo -e "# check repository DIR:$check_dirname\n"

find . -type d -name .git -prune -o -type f -exec file {} \; | \
awk -F: '{ print $2 }' | env LANG=c sort | uniq -c | env LANG=c sort -nr
