#!/bin/bash
workpath="/opt/evilmog/tmp"
hupath="/opt/utils/hashcat-utils/src"

$hupath/combinator.bin $workpath/hybrid.sorted.hcmask $workpath/hybrid.sorted.hcmask | sort -u > $workpath/hybrid.raw.hcmask
$hupath/len.bin 16 20 < $workpath/hybrid.raw.hcmask | sort -u > $workpath/hybrid.cutb.hcmask
