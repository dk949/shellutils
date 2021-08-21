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
	$(foreach file, $(wildcard *.out), install $(file) ${DESTDIR}${PREFIX}/bin/$(basename $(file));)

uninstall:
	$(foreach file, $(wildcard *.sh), rm -f ${DESTDIR}${PREFIX}/bin/$(basename $(file));)
	$(foreach file, $(wildcard *.out), rm -f ${DESTDIR}${PREFIX}/bin/$(basename $(file));)


.PHONY: all clean install uninstall
