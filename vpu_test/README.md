VPU Tests: A collection of scripts and video scenes for testing VPU encoding/decoding on iMX.5X
===============================================================================================

Testing gstreamer pipelines with `generate_pipeline.sh'
-------------------------------------------------------
Run the following command to make sure you can use this script

	sudo apt-get install gstreamer0.10-tools graphviz

To use this script, run it in the vpu_test directory with a video filename to test, e.g.

	./generate_pipeline.sh $(pwd)/clips/big_buck_bunny_720p_surround.clip.avi

(Unfortunately, relative paths to files are not currently supported, so specify a full path for the time being)

This script runs gst-launch-0.10 on the file given, using the playbin2 option.
Before this, it sets an environment variable GST_DEBUG_DUMP_DOT_DIR to the pipeline_output directory. 
Setting this variable to $PATH tells gstreamer to dump all of its '.dot' files (standard syntax for directed graphs) in $PATH.

After gst-launch finishes, the script runs the program dot on the .dot file representing media player state transition from READY to PAUSED (this one seems to have the most information available).
dot generates a .png file representing the pipeline gstreamer automatically created.

Finally, as a bit of cleanup, the script runs through the .dot files recently generated and helpfully renames them, based on the file used and the date the script was run.

Graphviz: Genereal Usage for gstreamer
======================================

dot
---

In order to use dot to view gstreamer pipelines, first tell gstreamer to place its .dot output files in $PATH with

	export GST_DEBUG_DUMP_DOT_DIR=$PATH

Then, run a gstreamer pipeline using gst-launch-0.10
This will produce several .dot files in $PATH
Select the one you wish to view ($DOTFILE) and create an image for it with

	dot -Tpng 		-o"$OUTFILE_NAME.png" 	$DOTFILE
	#   output png		name of output file	name of input file

Attribution
===========
http://lists.freedesktop.org/archives/gstreamer-devel/2011-September/033052.html
