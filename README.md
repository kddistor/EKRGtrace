EKRGtrace
=========

Script and GUI to trace cell movement from a tiff image stack

## Read Me Cell Tracking And Analysis

Dependencies:
* All scripts/functions must be in the folder path. To put in path, right click the EKRGtrace Folder --> Add folders/subfolders to path.
* Go to the folder where you want to run the analysis and run the code.

### EKRGTraceGui.m

Usage:
`EKRGTraceGUI`

The EKRG Trace GUI is an easy to use GUI for cell tracking and analysis.
Requires a picked points(point picker file) before running.

Input your file criteria and the point picker file in the specifying fields and click run to run the analysis.

### Overlaytracks.m

Usage:
`OverlayTracksObjects (namelist, cbound, r1, c1)`

This creates a video of the tracked cells. 

### EKRGtraceWithSeed.m

This script is what runs after value are put in the GUI.
