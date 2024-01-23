include config.mk

CXX_SRC = $(wildcard *.cpp)
C_SRC   = $(wildcard *.c)
EXE     = $(CXX_SRC:%.cpp=%.out) $(C_SRC:%.c=%.out)
JSON    = $(CXX_SRC:%.cpp=%.json) $(C_SRC:%.c=%.json)

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
	mkdir -p $(DIR)
	$(foreach file, $(wildcard *.sh),install $(file) $(DIR)/$(basename $(file));)
	$(foreach file, $(wildcard *.out),install $(file) $(DIR)/$(basename $(file));)

uninstall:
	$(foreach file, $(wildcard *.sh), rm -f $(DIR)/$(basename $(file));)
	$(foreach file, $(wildcard *.cpp), rm -f $(DIR)/$(basename $(file));)


compile_commands.json: $(JSON)
	echo "[" | cat - $(firstword $^) > $@
	for file in $(wordlist 2, $(words $^),$^); do echo "," | cat - "$$file" >> $@; done
	echo "]" >> $@

%.json: %.cpp
	echo '{"directory":"$(PWD)","command":"$(CXX) $(CXXFLAGS) -o $(basename $<).out $<","file":"$<","output":"$(basename $<).out"}' > $@

%.json: %.c
	echo '{"directory":$(PWD),"command":"$(CC) $(CFLAGS) -o $(basename $<).out $<","file":"$<","output":"$(basename $<).out"}' > $@

.PHONY: all clean install uninstall
