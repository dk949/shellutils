# versions
floatdump_version  = \"1.4.0\"
colorcheck_version = \"2.3.0\"
lstype_version     = \"1.1.0\"
fsize_version      = \"1.2.1\"
envdump_version    = \"1.0.1\"
sobrowser_version  = \"0.1.0\"

# dirs
PREFIX  = $(HOME)/.local

# flags
COMMON_FLAGS = -O3 -Wall -Wextra -Werror
CFLAGS       = $(COMMON_FLAGS) -std=c11
CXXFLAGS     = $(COMMON_FLAGS) -std=c++20

# compiler
CC   ?= cc
CXX  ?= c++
STRP ?= strip

