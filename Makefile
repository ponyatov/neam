# \ var
MODULE  = $(notdir $(CURDIR))
OS      = $(shell uname -s)
MACHINE = $(shell uname -m)
NOW     = $(shell date +%d%m%y)
REL     = $(shell git rev-parse --short=4 HEAD)
CORES   = $(shell grep processor /proc/cpuinfo| wc -l)
# / var

# \ dir
CWD     = $(CURDIR)
BIN     = $(CWD)/bin
DOC     = $(CWD)/doc
TMP     = $(CWD)/tmp
SRC     = $(CWD)/src
TEST    = $(CWD)/test
GZ      = $(HOME)/gz
# / dir

# \ tool
CURL    = curl -L -o
NIMB    = nimble
NIMP	= nimpretty
# / tool

# \ src
N      += src/$(MODULE).nim src/config.nim src/metainfo.nim
S      += $(Y) $(N) $(E) $(X) $(C) $(LL)
# / src

# \ all
.PHONY: all
all: $(S)
	time nimble build --usenimcache --nimcache:$(TMP)/nim
	file bin/$(MODULE)
	time nimble run
	$(MAKE) test
	$(MAKE) format

.PHONY: web
web: $(S)
	$(NIMB) run $@

.PHONY: test
test: $(S)
	nimble test

.PHONY: format
format: $(N)
	$(NIMP) --indent:2 $<
# / all



