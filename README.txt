DIRECTORY STRUCTURE

finals/ -- composited or raw footage which is ready for editing
frames/ -- raw footage split into frames
reviewed/ -- labeled raw footage we want to keep
tosplit/ -- raw footage to be split into frames
unreviewed/ -- unreviewed raw footage -- if it is junk throw it out;
	if not move it to reviewed or leave it alone

FILENAMES

All footage should be named with the form 'SceneXTakeY' for a scene X take Y.

For the make script to work it expects all footage has the extension 'MTS' (it
was the default extension for the camera).

WANT TO SPLIT LOTS OF FRAMES SIMULTANEOUSLY?

Be smart! Don't bork your computer!

'make -j' tells make to do lots of jobs at once.

NEED TO SPLIT RAW FOOTAGE?

Put it in 'tosplit' and type 'make'.

IS A SHOT CORRUPTED/MISSING FRAMES?

Just delete the corresponding frames folder for that shot and type 'make'.
