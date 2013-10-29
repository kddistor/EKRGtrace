#!/bin/bash 
padding=3
ifpadded=1
firsttime=1
lasttime=20
separator_pos=1
order_pos=2
slideposition=xy10
CFPB=214
YFPB=206
basename=2012-03-10-ekrg
ch1n=c1
ch2n=c2
ch3n=c3
ch4n=c4
extension=tif
sizeThres=[7,25]
maxI=4095
invertLog=1
# for i in ~/folder/.tif*;
# do cd "$i"
if [ $invertLog = 1 ]; then
echo 'EKAR Tracking'
matlab -nojvm -nodisplay -nosplash -r "[namePre, namePost, tstr, CFPB, YFPB, sizeThres] = getNames($padding, $ifpadded, $firsttime, $lasttime, $separator_pos, $order_pos, '$slideposition', $CFPB, $YFPB, '$basename', '$ch1n', '$ch2n', '$ch3n', '$ch4n', '$extension', $sizeThres); [namelist, cbound, valcube, r1, c1] = EKRGtraceWithSeed(namePre, namePost, tstr, CFPB, YFPB, sizeThres, $maxI, $invertLog); exit"
else
echo 'Nuclear cell tracking'
matlab -nojvm -nodisplay -nosplash -r "[namePre, namePost, tstr, CFPB, YFPB, sizeThres] = getNames($padding, $ifpadded, $firsttime, $lasttime, $separator_pos, $order_pos, '$slideposition', $CFPB, $YFPB, '$basename', '$ch1n', '$ch2n', '$ch3n', '$ch4n', '$extension', $sizeThres); [namelist, cbound, valcube, r1, c1] = NCtraceWithSeed(namePre, namePost, tstr, CFPB, YFPB, sizeThres, $maxI, $invertLog); exit"
# matlab -nojvm -nodisplay -nosplash -r "[namePre, namePost, tstr, CFPB, YFPB, sizeThres] = getNames(1, 2, 1, 20, 3, 5, 's12', 650, 1225,'2010-02-04_', 'w1CFP', 'w2YFP', 'w3mRFP1-mCherry', 'c4', 'TIF', [7 25]); [namelist, cbound, valcube, r1, c1] = EKRGtraceWithSeed(namePre, namePost, tstr, CFPB, YFPB, sizeThres); exit"
fi
# done
