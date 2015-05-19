#!/bin/bash
# *****************************************************************************
# * (c) 2012 Derrik Walker v2.0                                               *
# * snapper.sh                                                                *
# *                                                                           *
# * This will create and rotate btrfs snapshots for a specified volume        *
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

# set this to the volume that you want to make a snapshot for ...
vols="/var/home"

ltag=btrfs_snapshot

day=$( date +%a )
number=$( date +%H )

for vol in $vols
do

        if [ $number -eq 0 ]
        then
                snapshot=$vol/.snapshot/daily.$day
        else
                snapshot=$vol/.snapshot/hourly.$number
        fi

        if [ -d $snapshot ]
        then 
                /sbin/btrfs subvolume delete $snapshot | logger -t $ltag 2>&1
                sleep 3
        fi

        /sbin/btrfs subvolume snapshot -r $vol $snapshot | logger -t $ltag 2>&1
done
