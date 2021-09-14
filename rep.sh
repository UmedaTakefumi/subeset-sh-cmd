#!/bin/bash

<<OVERVIEW

## レポジトリチェックスクリプト

* リポジトリディレクトリ内部のファイル構造を簡易的に集計し画面に出力するシェルスクリプトです。

* 以前Qiitaに記載した記事をスクリプト化しました。
* Qiita記事URL: https://qiita.com/UmedaTakefumi/items/4947fa2494a1f726bc2b

OVERVIEW

##

function print_how_to_use () {

  echo "  -c  --check-files"
  echo "      簡易的にファイルをチェックしたのちにファイルの種類単位で集計し、画面に出力します"

  echo "  -h  --help"
  echo "      コマンドの使い方を画面に出力します。"
}

## コマンド実行時に出力されるヘッダー出力
function print_header () {

  check_dirname=$(pwd | awk -F/ '{ print $NF }')
  date=$(LANG=C date)
  
  echo -e "# -- $date --"
  echo -e "# check repository DIR:$check_dirname\n"
}

## 簡易的にファイルをチェックしたのちにファイルの種類単位で集計し、画面に出力します
function check_files () {

  find . -type d -name .git -prune -o -type f -exec file {} \; | \
  awk -F: '{ print $2 }' | env LANG=c sort | uniq -c | env LANG=c sort -nr

}

## copy and paste
## 
## ref: https://qiita.com/b4b4r07/items/dcd6be0bb9c9185475bb
for OPT in "$@"
do
  case $OPT in
    -h | --help)
        print_header
        print_how_to_use
        exit 1
        ;;
    -c | --check-files)
        print_header
        check_files
        shift 1
        ;;
    -- | -)
        shift 1
        param+=( "$@" )
        break
        ;;
    -*)
        echo "$PROGNAME: illegal option -- '$(echo $1 | sed 's/^-*//')'" 1>&2
        exit 1
        ;;
    *)
        if [[ ! -z "$1" ]] && [[ ! "$1" =~ ^-+ ]]; then
            #param=( ${param[@]} "$1" )
            param+=( "$1" )
            shift 1
        fi
        ;;
  esac
done

