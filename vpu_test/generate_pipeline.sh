#!/bin/bash

#requires gstreamer0.10-tools graphviz

if [ $# -ne 1 ] #Expects one file - input video file 
then
	echo "Usage: $0 <input-vid-file>"
	exit 65 # bad arguments
fi

VID_FILE_BASENAME=$(basename $1)
echo $VID_FILE_BASENAME

OUTDIR="$(pwd)/pipeline_output"

export GST_DEBUG_DUMP_DOT_DIR=$OUTDIR

gst-launch-0.10 playbin2 uri=file://$1

DATESTR=$(date)
DATESTR="${DATESTR// /_}"
dot -Tpng -o"$OUTDIR/$VID_FILE_BASENAME"'.READY_PAUSED'".$DATESTR"'.png' $(ls "$OUTDIR/"* | grep gst-launch.READY_PAUSED)

for f in $(ls $OUTDIR/* | grep "gst-launch")
do
	mv $f "$OUTDIR/$DATESTR.$VID_FILE_BASENAME."$(echo $(basename $f) | rev | cut -d"." -f-2 | rev)
done
