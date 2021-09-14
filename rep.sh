#!/bin/bash

<<OVERVIEW

## レポジトリチェックスクリプト

* リポジトリディレクトリ内部のファイル構造を簡易的に集計し画面に出力するシェルスクリプトです。

* 以前Qiitaに記載した記事をスクリプト化しました。
* Qiita記事URL: https://qiita.com/UmedaTakefumi/items/4947fa2494a1f726bc2b

OVERVIEW

## レポジトリチェックスクリプト

check_dirname=$(pwd | awk -F/ '{ print $NF }')
date=$(LANG=C date)

echo -e "# -- $date --"
echo -e "# check repository DIR:$check_dirname\n"

find . -type d -name .git -prune -o -type f -exec file {} \; | \
awk -F: '{ print $2 }' | env LANG=c sort | uniq -c | env LANG=c sort -nr
