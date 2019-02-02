# hello-make
A simple Makefile for C/C++ projects.

- Assumes gcc-like compiler.
- Source and header files are in `src/` directory, similar to how Eclipse or VS is usually used.
- Source files are manually registered in `SRCS` variable. This offers control on which files to be included (or excluded) from the build.
```makefile
# Source files list
SRCS := main.cpp
SRCS += yeah.cpp
SRCS += ohyeah/ohyeah.cpp
```
- Include directories are also manually registered in `INCDIRS` variable.
```makefile
# Include directories
INCDIRS := .
INCDIRS += ohyeah
```
- Supports subdirectory for source files: just put the relative path when appending to `SRCS`.
- Supports cross-compilation: set the `CROSS_COMPILE` environment variable to the prefix for the tools. Example:
```
$ CROSS_COMPILE=arm-linux-gnueabi- make
```
- Automatic dependency tracking: changes in header files will trigger re-compilation.

