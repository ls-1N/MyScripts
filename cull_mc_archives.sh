#!/bin/bash
#caveat! This script messes up if there are symlinks in the folder.


#archive_number=$( find /var/games/minecraft/archive/FortP/ -maxdepth 1 -type f -exec echo \; | wc -l ); 
#echo $archive_number;
#if [ $archive_number -gt 30 ]; then
cd /var/games/minecraft/archive/FortP
ls -tp | grep -v '/$' | tail -n +31 | xargs -I {} rm -- {}
#fi