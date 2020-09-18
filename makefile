
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

ALL = sb sbv ssb

.POSIX:

all: $(ALL)

install: all
	cp -P -t $(BINDIR) $(ALL)

install-sb: sb
	cp sb $(BINDIR)

clean:
	rm -f $(ALL)

uninstall:
	cd $(BINDIR) && rm -f $(ALL)

sbv: sb
	ln -s sb sbv
