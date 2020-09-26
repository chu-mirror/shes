
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

ALL = sb sbv ssb

.POSIX:
.SUFFIXES:

.SUFFIXES: .sh

.sh:
	cp $< $@
	chmod +x $@

all: $(ALL)

install: all
	cp -P $(ALL) $(BINDIR)

install-sb: sb
	cp sb $(BINDIR)

clean:
	rm -f $(ALL)

uninstall:
	cd $(BINDIR) && rm -f $(ALL)

sbv: sb
	ln -s sb sbv
