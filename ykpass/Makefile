.POSIX:
.PRECIOUS: seed

# This makefile is POSIX compliant. If any variable from the
# environment should take priority, use `make -e <target>`
BINDIR = /usr/local/bin
GENDIR = /var/lib/ykpass

# PHONY TARGETS
all: src/ykpass seed
	@if ! command -v sh; then echo "sh(1) is missing."; false; fi
	@if ! command -v awk; then echo "awk(1) is missing."; false; fi
	@if ! command -v openssl; then echo "openssl(1) is missing."; false; fi

install: all
	mkdir -p $(BINDIR) $(GENDIR)
	cp src/ykpass $(BINDIR)
	cp -i seed $(GENDIR)

clean:
	rm -f src/ykpass

distclean:
	rm -f src/ykpass seed

uninstall:
	rm -f $(BINDIR)/ykpass $(GENDIR)/seed
	rmdir $(GENDIR)

# REAL TARGETS
src/ykpass: src/ykpass.sh

seed:
	@# Prefer hexadecimal, it is very portable
	@head -n 8 /dev/urandom | tr -Cd [:xdigit:] > seed
