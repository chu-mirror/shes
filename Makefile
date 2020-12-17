
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

ALL = ref sb sbv ssb dowork gotemp

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

sb: sbs/* sb.sh
	echo "#!/bin/sh" > sb
	cat sbs/* sb.sh >> sb
	chmod +x sb

