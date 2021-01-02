
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

ALL = ref dowork gotemp push

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

uninstall:
	cd $(BINDIR) && rm -f $(ALL)

