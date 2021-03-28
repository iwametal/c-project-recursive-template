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
OBJECTS :=$(patsubst %,$(OBJDIR)/%.o,$(NAMES))


#
# COMPILATION RULES
#

default: all


# Rule for link and generate the binary file
all: $(OBJECTS)


# Rule for object binaries compilation
$(OBJDIR)/%.o: %.$(SRCEXT)
	@echo "-";
	@echo -en "$(BROWN)CC $(END_COLOR)";
	$(CC) -c $^ -o $@ $(DEBUG) $(CFLAGS) $(LIBS)
	@echo "-";
