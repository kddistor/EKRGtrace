#!/bin/bash 
padding=3						#eg t001=3, t1 = 1
ifpadded=1						#eg t0001=1, t1=2,
firsttime=1						#first timepoint
lasttime=20						#last timepoint
separator_pos=1					#1 = none, 2 = -, 3 = _
order_pos=5						#1=txyc, 2=tcxy, 3=xytc, 4=xyct, 5=cxyt, 6=ctxy
slideposition=xy02				#eg xy10, s12
CFPB=258						#CFP Background
YFPB=256						#YFP Background
basename=20130226onix2			#eg 2010-03-10-ekrg_
ch1n=c1							#eg CFP, w1CFP
ch2n=c2							#eg YFP, w2YFP
ch3n=c3							#eg RFP, w3mRFP1-mCherry
ch4n=c4							#eg c4, w4DTIC
extension=tif					#eg tif, TIF
sizeThres=[7,25]				#[minNucDiameterSize, maxNucDiameterSize]
maxI=4095						#eg 4095 for 12bit
invertLog=1						#1 if EKAR/cells with nucleus and boundaries, 2 for full cells
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
