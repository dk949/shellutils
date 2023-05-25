include config.mk

CXX_SRC = $(wildcard *.cpp)
C_SRC   = $(wildcard *.c)
EXE     = $(CXX_SRC:%.cpp=%.out) $(C_SRC:%.c=%.out)

.SUFFIXES:


DIR=$(DESTDIR)$(PREFIX)/bin

all: $(EXE)

clean:
	rm -f $(EXE)

%.out: %.cpp
	$(CXX) $< $(CXXFLAGS) -DVERSION=$(VERSION) -o $@
	$(STRP) $@

%.out: %.c
	$(CC) $< $(CFLAGS) -DVERSION=$(VERSION) -o $@
	$(STRP) $@

install: all
	$(foreach file, $(wildcard *.sh),install $(file) $(DIR)/$(basename $(file));)
	$(foreach file, $(wildcard *.out),install $(file) $(DIR)/$(basename $(file));)

uninstall:
	$(foreach file, $(wildcard *.sh), rm -f $(DIR)/$(basename $(file));)
	$(foreach file, $(wildcard *.cpp), rm -f $(DIR)/$(basename $(file));)


.PHONY: all clean install uninstall
