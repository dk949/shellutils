include config.mk

all: floatdump colorcheck

clean:
	rm -f floatdump.out
	rm -f colorcheck.out

floatdump: floatdump.cpp
	g++ -o floatdump.out floatdump.cpp -std=c++20 -O3 -DVERSION=$(FLOATDUMP_VERSION)

colorcheck: colorcheck.cpp
	g++ -o colorcheck.out colorcheck.cpp -O3 -DVERSION=$(COLORCHECK_VERSION)

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin/
	$(foreach file, $(wildcard *.sh), install $(file) ${DESTDIR}${PREFIX}/bin/$(basename $(file));)
	#for i in *.out; do install $$i ${DESTDIR}${PREFIX}/bin/$(basename $$i); done

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/bak
	rm -f ${DESTDIR}${PREFIX}/bin/colorcheck
	rm -f ${DESTDIR}${PREFIX}/bin/decriptdir
	rm -f ${DESTDIR}${PREFIX}/bin/dict
	rm -f ${DESTDIR}${PREFIX}/bin/double
	rm -f ${DESTDIR}${PREFIX}/bin/encriptdir
	rm -f ${DESTDIR}${PREFIX}/bin/execf
	rm -f ${DESTDIR}${PREFIX}/bin/extrename
	rm -f ${DESTDIR}${PREFIX}/bin/lstype
	rm -f ${DESTDIR}${PREFIX}/bin/out
	rm -f ${DESTDIR}${PREFIX}/bin/rmphdup
	rm -f ${DESTDIR}${PREFIX}/bin/run
	rm -f ${DESTDIR}${PREFIX}/bin/update-grub
	rm -f ${DESTDIR}${PREFIX}/bin/wminfo
	rm -f ${DESTDIR}${PREFIX}/bin/ctfix
	rm -f ${DESTDIR}${PREFIX}/bin/wcat
	rm -f ${DESTDIR}${PREFIX}/bin/floatdump


.PHONY: all clean install uninstall
