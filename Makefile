include config.mk

all: floatdump.out colorcheck.out lstype.out fsize.out

clean:
	rm -f floatdump.out
	rm -f colorcheck.out
	rm -f lstype.out


floatdump.out: floatdump.cpp
	$(CC) -o floatdump.out floatdump.cpp -std=c++20 -O3 -DVERSION=$(FLOATDUMP_VERSION)
	$(STRP) floatdump.out

colorcheck.out: colorcheck.cpp
	$(CC) -o colorcheck.out colorcheck.cpp -std=c++20 -O3 -DVERSION=$(COLORCHECK_VERSION)
	$(STRP) colorcheck.out

lstype.out: lstype.cpp
	$(CC) -o lstype.out lstype.cpp -std=c++20 -O3 -DVERSION=$(LSTYPE_VERSION)
	$(STRP) lstype.out

fsize.out: fsize.cpp
	$(CC) -o fsize.out fsize.cpp -std=c++20 -O3 -DVERSION=$(FSIZE_VERSION)
	$(STRP) fsize.out



install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin/
	$(foreach file, $(wildcard *.sh), install $(file) ${DESTDIR}${PREFIX}/bin/$(basename $(file));)
	$(foreach file, $(wildcard *.out), install $(file) ${DESTDIR}${PREFIX}/bin/$(basename $(file));)

uninstall:
	$(foreach file, $(wildcard *.sh), rm -f ${DESTDIR}${PREFIX}/bin/$(basename $(file));)
	$(foreach file, $(wildcard *.cpp), rm -f ${DESTDIR}${PREFIX}/bin/$(basename $(file));)


.PHONY: all clean install uninstall
