# +----------------------------------------------------------------------------+
# | MMAPI 0.1 * Application programming interface for MMxD device              |
# | Copyright (C) 2019 Pozsár Zsolt <pozsar.zsolt@.szerafingomba.hu>           |
# | Makefile                                                                   |
# | Make file for FreePascal source.                                           |
# +----------------------------------------------------------------------------+

include ../Makefile.global

srcfiles = mmapi.pas
binfiles = libmmapi.so

all:
	@echo "- Compiling source code..."
	@mkdir -p ./lib/$(architecture)-$(os)/
	@for x in $(srcfiles); do \
	  if [ -e $$x ]; then ppc386 $(fpflag) $$x; echo ""; fi; \
	done
	@echo "done."

clean:
	@echo -n "- Cleaning source code..."
	@$(rm) ./lib/$(architecture)-$(os)/*
	@echo "done."

install:
	@echo -n "- Installing binary files..."
	@$(install) -d $(libdir)
	@for x in $(binfiles); do \
	  if [ -e ./lib/$(architecture)-$(os)/$$x ]; then $(install) -m $(binmode) ./lib/$(architecture)-$(os)/$$x $(libdir); fi; \
	done
	mv $(libdir)/$(name).so $(libdir)/$(name).so.$(version).0
	ln -s $(libdir)/$(name).so.$(version).1 $(libdir)/$(name).so.0
	ln -s $(libdir)/$(name).so.$(version).1 $(libdir)/$(name).so
	ldconfig
	@echo "done."

uninstall:
	@echo -n "- Removing binary files..."
	@for x in $(binfiles); do $(rm) $(libdir)/$$x; done
	$(rm) $(libdir)/$(name).so.$(version).0
	$(rm) $(libdir)/$(name).so.0
	ldconfig
	@echo "done."
