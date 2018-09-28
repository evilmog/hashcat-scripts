#!/bin/bash
workpath="/opt/evilmog/tmp"
packpath="/opt/utils/pack"
pps="160000000000"
rt="360"

python $packpath/statsgen.py --maxlength=24 -o $workpath/cand.lst.mask --hiderare $workpath/cand.lst
python $packpath/statsgen.py --maxlength=24 -o $workpath/cand.exp.mask --hiderare $workpath/cand.exp
python $packpath/statsgen.py --maxlength=24 -o $workpath/cand.cutb.mask --hiderare $workpath/cand.cutb
python $packpath/statsgen.py --maxlength=24 -o $workpath/cand.cutb.exp.mask --hiderare $workpath/cand.cutb.exp

python $packpath/maskgen.py --pps=$pps --minlength=8 --minoccurrence=10 -t $rt -o $workpath/cand.lst.hcmask $workpath/cand.lst.mask
python $packpath/maskgen.py --pps=$pps --minlength=8 --minoccurrence=10 -t $rt -o $workpath/cand.exp.hcmask $workpath/cand.exp.mask
python $packpath/maskgen.py --pps=$pps --minlength=8 --minoccurrence=10 -t $rt -o $workpath/cand.cutb.hcmask $workpath/cand.cutb.mask
python $packpath/maskgen.py --pps=$pps --minlength=8 --minoccurrence=10 -t $rt -o $workpath/cand.cutb.exp.hcmask $workpath/cand.cutb.exp.mask
