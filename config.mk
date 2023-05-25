# versions
VERSION = \"$(shell git describe)\"

# dirs
PREFIX  ?=
DESTDIR ?= $(HOME)/.local

# flags
COMMON_FLAGS = -O3 -Wall -Wextra -Werror
CFLAGS       = $(COMMON_FLAGS) -std=c11
CXXFLAGS     = $(COMMON_FLAGS) -std=c++20

# compiler
CC   ?= cc
CXX  ?= c++
STRP ?= strip
