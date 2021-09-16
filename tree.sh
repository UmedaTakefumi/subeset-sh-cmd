#!/bin/sh

## copy and paste code.
##
## ref: https://qiita.com/yone098@github/items/bba8a42de6b06e40983b

pwd;find . | sort | sed '1d;s/^\.//;s/\/\([^/]*\)$/|--\1/;s/\/[^/|]*/|  /g'

# brew install tree
# dnf -y install tree
