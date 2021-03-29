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

# \ doc
.PHONY: doc
doc: \
	doc/Erlang/LYSE_ru.pdf doc/Erlang/Armstrong_ru.pdf \
	doc/Erlang/beam-book.pdf \
	doc/NimInAction.pdf

doc/Erlang/LYSE_ru.pdf:
	$(CURL) $@ https://github.com/mpyrozhok/learnyousomeerlang_ru/raw/master/pdf/learnyousomeerlang_ru.pdf
doc/Erlang/Armstrong_ru.pdf:
	$(CURL) $@ https://github.com/dyp2000/Russian-Armstrong-Erlang/raw/master/pdf/fullbook.pdf
doc/Erlang/beam-book.pdf:
	$(CURL) $@ https://github.com/happi/theBeamBook/releases/download/0.0.14/beam-book.pdf

doc/NimInAction.pdf:
	$(CURL) $@ https://nim.nosdn.127.net/MTY3NjMzODI=/bmltd18wXzE1NzYxNTc0NDQwMTdfMWU4MDhiODUtZDM0Ni00OWFlLWJjYzUtMDg2ODIxMmMzMTIw
# / doc

# \ install
.PHONY: install
install: $(OS)_install js doc
	$(MAKE) update
.PHONY: update
update: $(OS)_update
	nimble install nimble
	nimble refresh

.PHONY: Linux_install Linux_update
Linux_install Linux_update:
	sudo apt update
	sudo apt install -u `cat apt.txt apt.dev`

.PHONY: js
js:
# / install
# \ merge
MERGE += README.md Makefile .gitignore apt.txt apt.dev LICENSE $(S)
MERGE += .vscode bin doc tmp src test
MERGE += $(MODULE).nimble

.PHONY: main
main:
	git push -v
	git checkout $@
	git pull -v
	git checkout shadow -- $(MERGE)
.PHONY: shadow
shadow:
	git push -v
	git checkout $@
	git pull -v
.PHONY: release
release:
	git tag $(NOW)-$(REL)
	git push -v && git push -v --tags
	$(MAKE) shadow
.PHONY: zip
zip:
	git archive \
		--format zip \
		--output $(TMP)/$(MODULE)_$(NOW)_$(REL).src.zip \
	HEAD
# / merge
