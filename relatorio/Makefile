# the parameters
#

OUTDIR   := ../gh-pages
LATEX    := pdflatex
TEXFLAGS := -output-directory=$(OUTDIR)

# the magic
#

sources  := $(wildcard *.tex)

all: $(sources)
	@[ -d $(OUTDIR) ] || mkdir -p $(OUTDIR)
	@echo sources are: $(sources)
	yes "" | $(LATEX) $(TEXFLAGS) $(sources)
	#$(LATEX) $(TEXFLAGS) $(sources)
