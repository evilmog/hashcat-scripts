#!/bin/bash
workpath="/opt/evilmog/tmp"
packpath="/opt/utils/pack"
pps="160000000"
rt="360"

python $packpath/maskgen.py --pps=$pps --minlength=3 --maxlength=8 -t $rt -o $workpath/hybrid.hcmask $workpath/cand.lst
python $packpath/maskgen.py --pps=$pps --minlength=3 --maxlength=8 -t $rt -o $workpath/hybrid.exp.hcmask $workpath/cand.exp.mask
python $packpath/maskgen.py --pps=$pps --minlength=3 --maxlength=8 -t $rt -o $workpath/hybrid.cutb.hcmask $workpath/cand.cutb.mask
python $packpath/maskgen.py --pps=$pps --minlength=3 --maxlength=8 -t $rt -o $workpath/hybrid.cutb.exp.hcmask $workpath/cand.cutb.exp.mask

cat $workpath/hybrid*.hcmask | sort -u > $workpath/hybrid.sorted.hcmask
