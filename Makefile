include config.mk

all: \
	floatdump.out \
	colorcheck.out \
	lstype.out \
	fsize.out \
	sobrowser.out \
	envdump.out

clean:
	rm -f floatdump.out
	rm -f colorcheck.out
	rm -f lstype.out
	rm -f fsize.out
	rm -f envdump.out

sobrowser.out: sobrowser.cpp
	$(CXX) -o $@ $< -std=c++20 -O3 -DVERSION=$(SOBROWSER_VERSION)
	$(STRP) $@

floatdump.out: floatdump.cpp
	$(CXX) -o floatdump.out floatdump.cpp -std=c++20 -O3 -DVERSION=$(FLOATDUMP_VERSION)
	$(STRP) $@

colorcheck.out: colorcheck.cpp
	$(CXX) -o colorcheck.out colorcheck.cpp -std=c++20 -O3 -DVERSION=$(COLORCHECK_VERSION)
	$(STRP) $@

lstype.out: lstype.cpp
	$(CXX) -o lstype.out lstype.cpp -std=c++20 -O3 -DVERSION=$(LSTYPE_VERSION)
	$(STRP) $@

fsize.out: fsize.cpp
	$(CXX) -o fsize.out fsize.cpp -std=c++20 -O3 -DVERSION=$(FSIZE_VERSION)
	$(STRP) $@

envdump.out: envdump.c
	$(CC) -o envdump.out envdump.c -std=c11 -O3 -DVERSION=$(ENVDUMP_VERSION)
	$(STRP) $@



install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin/
	$(foreach file, $(wildcard *.sh), install $(file) ${DESTDIR}${PREFIX}/bin/$(basename $(file));)
	$(foreach file, $(wildcard *.out), install $(file) ${DESTDIR}${PREFIX}/bin/$(basename $(file));)

uninstall:
	$(foreach file, $(wildcard *.sh), rm -f ${DESTDIR}${PREFIX}/bin/$(basename $(file));)
	$(foreach file, $(wildcard *.cpp), rm -f ${DESTDIR}${PREFIX}/bin/$(basename $(file));)


.PHONY: all clean install uninstall
