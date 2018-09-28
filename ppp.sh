#!/bin/bash
pppath="/opt/utils/princeprocessor/src"
hupath="/opt/utils/hashcat-utils/src"
hcpath="/opt/cracken2/hashcat"
workpath="/opt/evilmog/tmp"

echo "[+] Prince Processor"
shuf $workpath/cand.cutb | $pppath/pp64.bin | $pppath/pp64.bin
