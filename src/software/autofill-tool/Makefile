.POSIX:
# The Makefile is aligned with the POSIX standard, and uses the GNU standard for
# extensions. Any conflict between this implementation and the POSIX standard is
# unintentional. The Makefile defers to the POSIX standard.

prefix = /usr/local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin

# Not POSIX nor GNU.
bins = src/autofill-tool

# No install(1) for POSIX compat.
INSTALL = cp -f

all: build

build: $(bins)

clean:
	rm -f $(bins)

install: build
	$(INSTALL) $(bins) $(DESTDIR)$(bindir)
