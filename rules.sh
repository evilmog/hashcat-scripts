#!/bin/bash
hupath="/opt/utils/hashcat-utils/src"
workpath="/opt/evilmog/tmp"

for i in {1..1000}; do
echo $i
$hupath/generate-rules.bin 1000 $(((RANDOM<<15)|RANDOM)) > $workpath/random.$i.rule
done

cat $workpath/random.*.rule | sort -u | rules_optimize.bin | sort -u > $workpath/random.rule


