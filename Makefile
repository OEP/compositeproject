# get system type
UNAME = $(shell uname)
TOP = $(CURDIR)

# executable paths
FFMPEG = ffmpeg
DPAFFMPEG = dpaffmpeg
NUKE = Nuke

ifeq ("$(UNAME)", "Darwin")
  NUKE = /Applications/Nuke6.3v4/Nuke6.3v4.app/Contents/MacOS/Nuke6.3v4
endif

# Project directories
RAW = tosplit
FRAMES = frames
COMPOSITEFRAMES = composite-frames
FINALS = finals
NKSCRIPTS = nuke-finalscripts

# Preferences
FILETYPE = tif
FPS = 30

# Input enumeration
RAWVIDEO = $(wildcard $(RAW)/*.MTS)
NKFILES = $(wildcard $(NKSCRIPTS)/*.nk)
JOINFRAMES = $(wildcard $(COMPOSITEFRAMES)/*)

# Outputs
FRAMEDIRS = $(patsubst $(RAW)/%.MTS, $(FRAMES)/%, $(RAWVIDEO))
NKFRAMES = $(patsubst $(NKSCRIPTS)/%.nk, $(COMPOSITEFRAMES)/%, $(NKFILES))
COMPOSITEFINALS = $(patsubst $(COMPOSITEFRAMES)/%, $(FINALS)/%.mov, $(JOINFRAMES))


help:
	@echo "Use this script to help do boilerplate stuff faster."
	@echo ""
	@echo "make [-j] split -- splits frames of movies in tosplit/ into frames/"
	@echo "make [-j] nukes -- render ALL out-of-date nuke scripts into composite-frames/"
	@echo "make [-j] join -- joins the frames located in composite-frames/ into finals/"
	@echo "     using the -j flag will split/join several videos at once"
	@echo ""
	@echo "If you're a Bad Enough Dude, you can use screen so the splitting will happen in the"
	@echo "background while you go get yourself some lunch."
	@echo "Example: screen -S <some-name> make -j split"
	@echo "Example: screen -S <some-name> make -j join"
	@echo "   where <some-name> is some name of your choice, like Scene28"

split: $(FRAMEDIRS)

nukes: $(NKFRAMES)

join: $(COMPOSITEFINALS)

printvars:
	@echo $(RAWVIDEO)
	@echo $(FRAMEDIRS)
	@echo $(NUKE)
	@echo $(TOP)

$(FINALS)/%.mov: $(COMPOSITEFRAMES)/%
	$(eval BASENAME = $(patsubst $(COMPOSITEFRAMES)/%, %, $<))
	cd $<; $(DPAFFMPEG) -base $(BASENAME) -output $(TOP)/$@

$(COMPOSITEFRAMES)/%: $(NKSCRIPTS)/%.nk
	@mkdir -p $@
	$(NUKE) -x $<

$(FRAMES)/%: $(RAW)/%.MTS
	mkdir -p $@
	$(eval BASENAME = $(patsubst $(FRAMES)/%, %, $@))
	$(FFMPEG) -i $< -f image2 -r $(FPS) $(FRAMES)/$(BASENAME)/$(BASENAME).%07d.$(FILETYPE)

$(FRAMES):
	mkdir -p $(FRAMES)

