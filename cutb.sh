#!/bin/bash
pp_path="/opt/utils/princeprocessor/src"
hu_path="/opt/utils/hashcat-utils/src"
work_path="/opt/cutb"

for i in {1..8}; do
 $pp_path/cutb.bin 0 $i < $1 | sort -u > $workpath/$i-first.txt
done

for i in {1..8}; do
  $pp_path/cutb.bin -$i < $1 | sort -u > $workpath/$i-last.txt
done

cat $workpath/*-first.txt $workpath/*-last.txt | sort -u > $workpath/cand.cutb
