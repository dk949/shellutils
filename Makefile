include config.mk

CXX_SRC = $(wildcard *.cpp)
C_SRC   = $(wildcard *.c)
EXE     = $(CXX_SRC:%.cpp=%.out) $(C_SRC:%.c=%.out)

.SUFFIXES:

all: $(EXE)

clean:
	rm -f $(EXE)

%.out: %.cpp
	$(CXX) $< $(CXXFLAGS) -DVERSION=$($(basename $@)_version) -o $@
	$(STRP) $@

%.out: %.c
	$(CC) $< $(CFLAGS) -DVERSION=$($(basename $@)_version) -o $@
	$(STRP) $@

install: all
	$(foreach file, $(wildcard *.sh),install $(file) $(PREFIX)/bin/$(basename $(file));)
	$(foreach file, $(wildcard *.out),install $(file) $(PREFIX)/bin/$(basename $(file));)

uninstall:
	$(foreach file, $(wildcard *.sh), rm -f $(PREFIX)/bin/$(basename $(file));)
	$(foreach file, $(wildcard *.cpp), rm -f $(PREFIX)/bin/$(basename $(file));)


.PHONY: all clean install uninstall
