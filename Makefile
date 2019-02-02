# A simple Makefile
# Tuwuh Sarwoprasojo (2019)
#
# Inspired by:
#  http://make.mad-scientist.net/papers/how-not-to-use-vpath/
#  https://www.math.colostate.edu/~yzhou/computer/writemakefile.html
#  http://polaris.s.kanazawa-u.ac.jp/~npozar/intro-to-make.html
#

# Append CROSS_COMPILE variable to support cross toolchains
AR = $(CROSS_COMPILE)ar
CC = $(CROSS_COMPILE)gcc
CXX = $(CROSS_COMPILE)g++

# Program name
PROG = hello-make

# Source files list
SRCS += main.cpp
SRCS += yeah.cpp

# Create object files list from source files list
OBJS = $(patsubst %.cpp, %.o, $(patsubst %.c, %.o, $(SRCS)))

# Directory defintions
OBJDIR = build
SRCDIR = src

# Expand directory name for the object files
OBJPROG = $(addprefix $(OBJDIR)/, $(PROG))

# Targets
all: $(OBJPROG)

$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	$(COMPILE.cc) $< -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(COMPILE.c) $< -o $@

$(OBJPROG): $(addprefix $(OBJDIR)/, $(OBJS))
	$(LINK.o) $^ $(LDLIBS) -o $@

clean:
	$(RM) $(OBJDIR)/*

# Create output directory if not exists
$(shell mkdir -p $(OBJDIR))
