#!/bin/bash
pppath="/opt/utils/princeprocessor/src"
hupath="/opt/utils/hashcat-utils/src"
hcpath="/opt/cracken2/hashcat"
workpath="/opt/evilmog/tmp"

echo "[+] Sorting Potfile"
cut -d: -f2- < $hcpath/hashcat.potfile | sort -u > $workpath/cand.lst

echo "[+] Running Cutb"
for i in {1..8}; do
 echo "[+]  Forward Cutb segment $i"
 $hupath/cutb.bin 0 $i < $workpath/cand.lst | sort -u > $workpath/$i-first.txt
done

for i in {1..8}; do
  echo "[+]  Reverse Cutb segment $i"
  $hupath/cutb.bin -$i < $workpath/cand.lst | sort -u > $workpath/$i-last.txt
done

echo "[+] Cat Cutb"
cat $workpath/*-first.txt $workpath/*-last.txt | sort -u > $workpath/cand.cutb
echo "[+] First Expander"
$hupath/expander.bin < $workpath/cand.lst | sort -u > $workpath/cand.exp
echo "[+] Cutb Expander"
$hupath/expander.bin < $workpath/cand.cutb | sort -u > $workpath/cand.cutb.exp

