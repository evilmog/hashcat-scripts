#!/bin/bash
hu_path="/opt/utils/hashcat-utils/src"
work_path="/opt/cutb"

for i in {1..8}; do
 $hu_path/cutb.bin 0 $i < $1 | sort -u > $work_path/$i-first.txt
done

for i in {1..8}; do
  $hu_path/cutb.bin -$i < $1 | sort -u > $work_path/$i-last.txt
done

cat $work_path/*-first.txt $work_path/*-last.txt | sort -u > $work_path/cand.cutb
