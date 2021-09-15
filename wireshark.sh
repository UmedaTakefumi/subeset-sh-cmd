#!/bin/bash

<<OVERVIEW

## パケットキャプチャスクリプト

* パケットキャプチャするときに以下の作業をやってくれるスクリプトです
  * パケットファイルを保存するディレクトリを作成します。
  * パケットファイルのファイル名に実行日時を付与します。
  * パケットファイルのローテーションの設定を行います。

* 以前Qiitaに記載した記事をスクリプト化しました。
* Qiita記事URL: https://qiita.com/UmedaTakefumi/items/d27edbef7a5475157a98

OVERVIEW

function print_how_to_use () {

  echo "未定"

}

## networksetup -listallhardwareports | grep Device: | awk '{ print $2 }'

brew install wireshark
mkdir -p ~/Temp/pkt
cd ~/Temp/pkt

tshark -i en0 -w testcap_$(date +%Y-%m-%d_%H-%M-%S).pcap

## copy and paste
## 
## ref: https://qiita.com/b4b4r07/items/dcd6be0bb9c9185475bb
for OPT in "$@"
do
  case $OPT in
    -h | --help)
        print_how_to_use
        exit 1
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

if [ -z "$param" ]; then
    echo "$PROGNAME: too few arguments" 1>&2
    echo "Try '$PROGNAME --help' for more information." 1>&2
    exit 1
fi
