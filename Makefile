# A simple Makefile
# Tuwuh Sarwoprasojo (2019)
#
# Inspired by:
#  http://make.mad-scientist.net/papers/how-not-to-use-vpath/
#  https://www.math.colostate.edu/~yzhou/computer/writemakefile.html
#  http://polaris.s.kanazawa-u.ac.jp/~npozar/intro-to-make.html
#  http://nuclear.mutantstargoat.com/articles/make/#automatic-include-dependency-tracking
#  

# Append CROSS_COMPILE variable to support cross toolchains
AR = $(CROSS_COMPILE)ar
CC = $(CROSS_COMPILE)gcc
CXX = $(CROSS_COMPILE)g++
PREPROCESS.c ?= $(CC) -E $(CFLAGS)
PREPROCESS.cc ?= $(CXX) -E $(CFLAGS)

# Program name
PROG = hello-make

# Source files list
SRCS += main.cpp
SRCS += yeah.cpp

# Create objects and dependencies list from sources list
OBJS = $(addprefix $(OBJDIR)/,$(patsubst %.cpp,%.o,$(patsubst %.c,%.o,$(SRCS))))
DEPS = $(patsubst %.o,%.d,$(OBJS))

# Directory defintions
OBJDIR = build
SRCDIR = src

# Expand directory name for the object files
OBJPROG = $(addprefix $(OBJDIR)/,$(PROG))


# Default target
.PHONY: all
all: $(OBJPROG)

# Automatic dependency generation to include header files
# Include the .d files only if the target is not clean
# "-" suppresses warning on the first run when .d files not exist yet
ifneq ($(MAKECMDGOALS), clean)
-include $(DEPS)
endif

# Rules to generate dependency files (.d)
$(OBJDIR)/%.d: $(SRCDIR)/%.cpp
	$(PREPROCESS.cc) $< -MM -MT $(@:.d=.o) >$@

$(OBJDIR)/%.d: $(SRCDIR)/%.c
	$(PREPROCESS.c) $< -MM -MT $(@:.d=.o) >$@

# Compile and link
$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	$(COMPILE.cc) $< -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(COMPILE.c) $< -o $@

$(OBJPROG): $(OBJS)
	$(LINK.o) $^ $(LDLIBS) -o $@

.PHONY: clean
clean:
	$(RM) $(OBJPROG) $(OBJS) $(DEPS)

# Create output directory if not exists
$(shell mkdir -p $(OBJDIR))
