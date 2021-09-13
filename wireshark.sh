#!/bin/bash

## networksetup -listallhardwareports | grep Device: | awk '{ print $2 }'

brew install wireshark
mkdir -p ~/Temp/pkt
cd ~/Temp/pkt

tshark -i en0 -w testcap_$(date +%Y-%m-%d_%H-%M-%S).pcap

