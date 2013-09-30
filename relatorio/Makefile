# the parameters
#

LATEX    := pdflatex
TEXFLAGS := -output-directory=../gh-pages/

# the magic
#

sources  := $(wildcard *.tex)

all: $(sources)
	@echo sources are: $(sources)
	yes "" | $(LATEX) $(TEXFLAGS) $(sources)
	#$(LATEX) $(TEXFLAGS) $(sources)
