#
#
#
# Makefile template for C code
#
# Author: Leo Andrade
#
#
#


# %.o file names
NAMES := $(notdir $(basename $(wildcard *.$(SRCEXT))))
OBJECTS :=$(patsubst %,$(LIBDIR)/%.o,$(NAMES))


#
# COMPILATION RULES
#

default: all


# Rule for link and generate the binary file
all: $(OBJECTS)


# Rule for object binaries compilation
$(LIBDIR)/%.o: %.$(SRCEXT)
	@echo "-";
	@echo -en "$(BROWN)CC $(END_COLOR)";
	$(CC) -c $^ -o $@ $(DEBUG) $(CFLAGS) $(LIBS)
	@echo "-";
