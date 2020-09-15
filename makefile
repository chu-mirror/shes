
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

ALL = sb

.POSIX:

all: $(ALL)

install: all
	cp -t $(BINDIR) $(ALL)

clean:
	rm $(ALL)

uninstall:
	cd $(BINDIR) && rm $(ALL)

