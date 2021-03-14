
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

ALL = ref dowork gotemp prevw pushg 

.POSIX:
.SUFFIXES:

.SUFFIXES: .sh

.sh:
	cp $< $@
	chmod +x $@

all: $(ALL)

install: all
	cp -P $(ALL) $(BINDIR)

clean:
	rm -f $(ALL)

clobber:
	cd $(BINDIR) && rm -f $(ALL)

