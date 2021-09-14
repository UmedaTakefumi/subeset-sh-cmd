#!/bin/bash

<<OVERVIEW

## パケットキャプチャスクリプト

* パケットキャプチャするときに以下の作業をやってくれるスクリプトです
  * パケットファイルを保存するディレクトリを作成します。
  * パケットファイルのファイル名に実行日時を付与します。
  * パケットファイルのローテーションの設定を行います。

* 以前Qiitaに記載した記事をスクリプト化しました。
* Qiita記事URL: https://qiita.com/UmedaTakefumi/items/d27edbef7a5475157a98

OVERVIVE

## networksetup -listallhardwareports | grep Device: | awk '{ print $2 }'

brew install wireshark
mkdir -p ~/Temp/pkt
cd ~/Temp/pkt

tshark -i en0 -w testcap_$(date +%Y-%m-%d_%H-%M-%S).pcap

