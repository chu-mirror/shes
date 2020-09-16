
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

ALL = sb sbv

.POSIX:

all: $(ALL)

install: all
	cp -P -t $(BINDIR) $(ALL)

clean:
	rm -f $(ALL)

uninstall:
	cd $(BINDIR) && rm $(ALL)

sbv: sb
	ln -s sb sbv
