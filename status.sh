#!/bin/bash
# *****************************************************************************
# * (c) 2012 Derrik Walker v2.0                                               *
# * status.sh                                                                 *
# *                                                                           *
# * This will report the btrfs status for each volume                         * 
# *                                                                           *
# * This is one of the scripts referenced in the blog post:                   *
# * http://www.doomd.net/2014/03/some-testing-with-btrfs.html                 *
# *                                                                           *
# * This is licensed for use under the GNU General Pulbic License v2          *
# *                                                                           *
# * 2013-12-22	DW2	Initial Version                                       *
# * 2015-05-18	DW2	Initial Release                                       *
# *                                                                           *
# *****************************************************************************

vols=$( df -h -t btrfs | grep -v ^Filesystem | awk '{print $NF}' )

for vol in $vols
do
        echo "--- stats for $vol ---"
        btrfs device stats $vol 

        echo

        echo "--- subvolumes of $vol ---"
        btrfs subvolume list $vol 
done
