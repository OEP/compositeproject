DIRECTORY STRUCTURE

finals/ -- composited or raw footage which is ready for editing
frames/ -- raw footage split into frames
reviewed/ -- labeled raw footage we want to keep
tosplit/ -- raw footage to be split into frames
unreviewed/ -- unreviewed raw footage -- if it is junk throw it out;
	if not move it to reviewed or leave it alone

MAKING SINGLE TARGETS

You can make single targets rather than all of them. For example, say your
nuke script is nuke-finalscripts/Scene28.nk and you want to both render the
frames from Nuke and create the final move. All you need to do is:

$> make finals/Scene28.mov

Maybe you just want to render the frames from Nuke:

$> make composite-frames/Scene28

It is a similar idea for splitting frames. If your source video is located at
tosplit/Scene28Take1.MTS, then:

$> make frames/Scene28Take1

FILETYPES

After Effects and perhaps other packages may not be able to work with TIF
images. You can split into any file type that ffmpeg supports. If you need
your images in PNG, you can also try this:

$> make FILETYPE=png split

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
