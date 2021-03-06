#!/bin/bash
## on mac, need > for xxd output files
 
WORKDIR="/scratch365/zshi2/OtherImages/2015FebToDec"
DESTINATION="/scratch365/zshi2/OtherImages/fixed2015FebToDec"

cd $WORKDIR
folder="2015-02-27" # to confirm this
mkdir -p $DESTINATION/$folder

cd $folder
    for f in *.svs; do
      FCHECK=`file $f | grep "TIFF"` 
      if [ "$FCHECK" ]; then
      cp $f $DESTINATION/$folder/$f 
      else     
      xxd -p $f $f.hex
      perl -pi'original-*' -we 'BEGIN{$/="49492a00"} chomp and s/.+/49492a00/s;' "$f.hex"
      xxd -r -p $f.hex $DESTINATION/$folder/$f
      rm *.hex
      fi 
    file $DESTINATION/$folder/$f
    done 


