#!/bin/bash

find . -type d -name .git -prune -o -type f -exec file {} \; | \
awk -F: '{ print $2 }' | env LANG=c sort | uniq -c | env LANG=c sort -nr
