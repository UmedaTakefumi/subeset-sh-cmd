#!/bin/bash

<<OVERVIEW

## レポジトリチェックスクリプト

* リポジトリディレクトリ内部のファイル構造を簡易的に集計し画面に出力するシェルスクリプトです。

* 以前Qiitaに記載した記事をスクリプト化しました。
* Qiita記事URL: https://qiita.com/UmedaTakefumi/items/4947fa2494a1f726bc2b

OVERVIEW

## コマンドの使い方を画面に出力します
function print_how_to_use () {

  echo    "  -b  --binary-files"
  echo -e "      バイナリファイルを存在するか簡易的に集計確認し、画面に出力します\n"

  echo    "  -c  --check-files"
  echo -e "      簡易的にファイルをチェックしたのちにファイルの種類単位で集計し、画面に出力します\n"

  echo    "  -h  --help"
  echo -e "      コマンドの使い方を画面に出力します。\n"

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

## バイナリファイル(executable, Mach-O, ELF)が存在するか簡易的に集計し画面に出力します
function check_binary_files () {

  bin_exe=($(find . -type d -name .git -prune -o -type f -exec file {} \;   | grep executable | grep -v text | awk -F: '{print $1}'))
  bin_macho=($(find . -type d -name .git -prune -o -type f -exec file {} \; | grep Mach-O     | grep -v text | awk -F: '{print $1}'))
  bin_elf=($(find . -type d -name .git -prune -o -type f -exec file {} \;   | grep ELF        | grep -v text | awk -F: '{print $1}'))

  if [ ${#bin_exe[@]} == 0 ]; then
    echo -e "## Exe\n"
    echo -e "[good] count: ${#bin_exe[@]}\n"
  else
    echo -e "## Exe\n"
    echo -e "[need to confirm] count: ${#bin_exe[@]}\n"
    for filepath in ${bin_exe[@]}; do
      echo -e "  $filepath"
    done
    echo -e "\n" 
  fi

  if [ ${#bin_macho[@]} == 0 ]; then
    echo -e "## Mach-O\n"
    echo -e "[good] count: ${#bin_macho[@]}\n"
  else
    echo -e "## Mach-O\n"
    echo -e "[need to confirm] count: ${#bin_macho[@]}\n"
    for filepath in ${bin_macho[@]}; do
      echo -e "  $filepath"
    done
    echo -e "\n" 
  fi

  if [ ${#bin_elf[@]} == 0 ]; then
    echo -e "## ELF\n"
    echo -e "[good] count: ${#bin_elf[@]}\n"
  else
    echo -e "## ELF\n"
    echo -e "[need to confirm] count: ${#bin_elf[@]}\n"
    for filepath in ${bin_elf[@]}; do
      echo -e "  $filepath"
    done
    echo -e "\n" 
  fi

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
    -b | --binary-files)
        print_header
        check_binary_files
        shift 1
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

