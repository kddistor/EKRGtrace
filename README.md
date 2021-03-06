EKRGtrace
=========

Script and GUI to trace cell movement from a tiff image stack

## Read Me Cell Tracking And Analysis

Dependencies:
* All scripts/functions must be in the folder path. To put in path, right click the EKRGtrace Folder --> Add folders/subfolders to path.
* Go to the folder where you want to run the analysis and run the code.

### EKRGTraceGui.m

Dependencies:
* EKRGtraceMod.m

Usage:
`EKRGTraceGUI`

The EKRG Trace GUI is an easy to use GUI for cell tracking and analysis.
Requires a picked points(point picker file) before running.

Input your file criteria and the point picker file in the specifying fields and click run to run the analysis.

### EKRGtraceMod.m

Usage:
`[namelist, cbound, rvalw, r1, c1] = EKRGtraceMod(ppoints, preT, posT, tstr, CFPB, YFPB)`

This script takes in the values from the GUI and runs the tracking and analysis.

### Overlaytracks.m

Dependencies:
* values from EKRGtraceMod.m

Usage:
`OverlayTracksObjects (namelist, cbound, r1, c1)`

This creates a video of the cells and the cell tracks. The save file will be in the folder where the analysis was done with the name 'firstframe.avi'

### getNames.m

Usage:
`[namePre, namePost, tstr, CFPB, YFPB, sizeThres] = getNames(padding, ifpadded, firsttime, lasttime, separator_pos, order_pos, slideposition, CFPB, YFPB, basename, ch1n, ch2n, ch3n, ch4n, extension, sizeThres)`

* padding: 3 = 001;
* ifpadded: 1 - padded, 2 - not padded.
* firstime: first timepoint
* lasttime: last timepoint
* separator: 1 - none, 2 - '-', 3 - '_'
* order:  1 - 't...xy...c...', 2 - 't...c...xy...', 3 - 'xy...t...c...',4 - 'xy...c...t...', 5 - 'c...xy...t...', 6 - 'c...t...xy...'
* slideposition: 's12'
* CFPB: CFP BACKGROUND
* YFPB: YFP BACKGROUND
* basename: 'basename'
* ch1n: '1st Channel'
* ch2n: '2nd Channel'
* ch3n: '3rd Channel'
* ch4n: '4th Channel'
* extension:  eg. 'tif' or 'TIF'
* sizeThres: [minNucDiameterSize, maxNucDiameterSize]

Gets the name of the files and stores into vector for analysis.

### autofindpoint.m

Modified from [SomponnatSingleCellAnalysis](https://github.com/somponnat/Somponnat_SingleCellAnalysis)

Usage:
`[binary coords] = autofindpoint(M,sizeThres)`

Segments the image by cells.

### EKRGtraceWithSeed.m

Dependencies:
* values from getNames.m
* autofindpoint.m

Usage:
`function [namelist, cbound, valcube, r1, c1] = EKRGtraceWithSeed(namePre, namePost, tstr, CFPB, YFPB, sizeThres)`

Tracks cells with visible nucleus and cytoplasm.

### NCtraceWithSeed.m

Dependencies:
* values from getNames.m
* autofindpoint.m

Usage:
`function [namelist, cbound, valcube, r1, c1] = NCTraceWithSeed(namePre, namePost, tstr, CFPB, YFPB, sizeThres)`

Tracks cells with nuclear cells.

### avgIntensityTimecourse1.m

Usage:
`[nameHCube] = avgIntensityFull(tpadding, ifpadded, tvec, separator_pos, order_pos, xys, xyvec, xypadding, basename, ch1n, ch2n, ch3n, ch4n, extension)`

* tpadding: 3 = 001;
* ifpadded: 1 - padded, 2 - not padded.
* tvec: '1:time'
* separator: 1 - none, 2 - '-', 3 - '_'
* order:  1 - 't...xy...c...', 2 - 't...c...xy...', 3 - 'xy...t...c...',4 - 'xy...c...t...', 5 - 'c...xy...t...', 6 - 'c...t...xy...'
* xys: 's' or 'xy'
* xyvec: '1:slidenumber'
* xypadding: 3 = 001
* basename: 'basename'
* ch1n: '1st Channel'
* ch2n: '2nd Channel'
* ch3n: '3rd Channel'
* ch4n: '4th Channel'
* extension:  eg. 'tif' or 'TIF'

Gets the name for Intensity processing.  

### avgIntensityTimecourse2.m

Dependencies:
* values from avgIntensityTimecourse1.m

Usage:
`[data1 data2 data3 data4]=dataAvgIntensity(nameHCube)`

Gets the average intnsity over each time point for every cell. 
