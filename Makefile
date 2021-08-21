include config.mk

all: floatdump.out colorcheck.out lstype.out

clean:
	rm -f floatdump.out
	rm -f colorcheck.out
	rm -f lstype.out

floatdump.out: floatdump.cpp
	$(CC) -o floatdump.out floatdump.cpp -std=c++20 -O3 -DVERSION=$(FLOATDUMP_VERSION)

colorcheck.out: colorcheck.cpp
	$(CC) -o colorcheck.out colorcheck.cpp -std=c++20 -O3 -DVERSION=$(COLORCHECK_VERSION)

lstype.out: lstype.cpp
	$(CC) -o lstype.out lstype.cpp -std=c++20 -O3 -DVERSION=$(LSTYPE_VERSION)



install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin/
	$(foreach file, $(wildcard *.sh), install $(file) ${DESTDIR}${PREFIX}/bin/$(basename $(file));)
	$(foreach file, $(wildcard *.out), install $(file) ${DESTDIR}${PREFIX}/bin/$(basename $(file));)

uninstall:
	$(foreach file, $(wildcard *.sh), rm -f ${DESTDIR}${PREFIX}/bin/$(basename $(file));)
	$(foreach file, $(wildcard *.out), rm -f ${DESTDIR}${PREFIX}/bin/$(basename $(file));)


.PHONY: all clean install uninstall
