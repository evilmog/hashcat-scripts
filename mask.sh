#!/bin/bash
workpath="/opt/evilmog/tmp"
packpath="/opt/utils/pack"
pps="160000000000"
rt="360"

python $packpath/maskgen.py --pps=$pps --minlength=8 --minoccurrence=10 -t $rt -o $workpath/cand.lst.hcmask $workpath/cand.lst.mask
python $packpath/maskgen.py --pps=$pps --minlength=8 --minoccurrence=10 -t $rt -o $workpath/cand.exp.hcmask $workpath/cand.exp.mask
python $packpath/maskgen.py --pps=$pps --minlength=8 --minoccurrence=10 -t $rt -o $workpath/cand.cutb.hcmask $workpath/cand.cutb.mask
python $packpath/maskgen.py --pps=$pps --minlength=8 --minoccurrence=10 -t $rt -o $workpath/cand.cutb.exp.hcmask $workpath/cand.cutb.exp.mask
