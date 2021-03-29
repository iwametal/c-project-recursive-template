#
#
#
# Makefile template for C code
#
# Author: Leo Andrade
#
#
#


# Includes the project configurations
include project.conf

#
# Validating project variables defined in project.conf
#
ifndef PROJECT_NAME
$(error Missing PROJECT_NAME. Put variables at project.conf file)
endif
ifndef BINARY
$(error Missing BINARY. Put variables at project.conf file)
endif
ifndef PROJECT_PATH
$(error Missing PROJECT_PATH. Put variables at project.conf file)
endif


# Gets the Operating system name
OS := $(shell uname -s)

# Default shell
SHELL := /bin/bash

# Color prefix for Linux distributions
COLOR_PREFIX := e

ifeq ($(OS),Darwin)
	COLOR_PREFIX := 033
endif

# Color definition for print purpose
export BROWN=\$(COLOR_PREFIX)[0;33m
export BLUE=\$(COLOR_PREFIX)[1;34m
export END_COLOR=\$(COLOR_PREFIX)[0m



# Source code directory structure
ACTUAL_PATH := $(shell pwd)
SRCDIR := src
BINDIR := bin
TESTDIR := test
LOGDIR := $(ACTUAL_PATH)/log
export OBJDIR := obj


# Source code file extension
export SRCEXT := c
SRCEXEC := $(shell find $(SRCDIR) -type f -name Makefile)
OBJEXEC := $(shell echo "$(SRCEXEC)"|sed 's/\/Makefile/\/$(OBJDIR)\/*.o/g')
SRCEXEC := $(shell echo "$(SRCEXEC)"|sed 's/\/Makefile//g')
# NUMEXEC := 0


# Defines the C Compiler
export CC := gcc


# Defines the language standards for GCC
STD := -std=gnu99 # See man gcc for more options

# Protection for stack-smashing attack
STACK := -fstack-protector-all -Wstack-protector

# Specifies to GCC the required warnings
WARNS := -Wall -Wextra -pedantic # -pedantic warns on language standards

# Flags for compiling
export CFLAGS := -O3 $(STD) $(STACK) $(WARNS)

# Debug options
export DEBUG := -g3 -DDEBUG=1

# Dependency libraries
export LIBS := # -lm  -I some/path/to/library

# Test libraries
TEST_LIBS := -l cmocka -L /usr/lib



# Tests binary file
TEST_BINARY := $(BINARY)_test_runner


MFILEDIR := resources/makefiles/sample
D_FILE := $(PROJECT_PATH)/.vimspector.json



# %.o file names
# NAMES := $(notdir $(basename $(wildcard $(SRCDIR)/*.$(SRCEXT))))
# NAMES := $(notdir $(basename $(wildcard $(SRCEXEC))))
# NAMES := $(foreach s,$(SRCEXEC),$(eval $(call COMPILE_rule,$(s))))
# NAMES := $(foreach s,$(SRCEXEC),$(notdir $(basename $(wildcard $(SRCEXEC)))))
# OBJECTS := $(patsubst %,$(OBJDIR)/%.o,$(NAMES))
# OBJECTS := $(patsubst %.$(SRCEXT),$(OBJDIR)/%.o,$(notdir $(SRCEXEC)))
# OBJECTS :=$(patsubst %,$(OBJDIR)/%.o,$(NAMES))


# ifneq ($(words $(OBJECTS)),$(words $(sort $(OBJECTS))))
# 	$(warning object file name conflicts detected)
# endif


#
# COMPILATION RULES
#

default: all

# Help message
help:
	@echo "C Project Template"
	@echo
	@echo "Target rules:"
	@echo "    all      - Compiles and generates binary file"
	@echo "    install  - Same as all argument"
	@echo "    dir      - Create a new diretory into src folder with all dependencies already fullfilled"
	@echo "    tests    - Compiles with cmocka and run tests binary file"
	@echo "    start    - Starts a new project using C project template"
	@echo "    valgrind - Runs binary file using valgrind tool"
	@echo "    clean    - Clean the project by removing binaries"
	@echo "    help     - Prints a help message with target rules"

# Starts a new project using C project template
start:
	@echo "Creating project: $(PROJECT_NAME)"
	@mkdir -pv $(PROJECT_PATH)
	@echo "Copying files from template to new directory:"
	@cp -rvf ./* $(PROJECT_PATH)/
	@echo ""
	@echo "Generating $(D_FILE) debug file"
	@echo "{" >$(D_FILE); \
	echo -e "\t\"configurations\": {" >>$(D_FILE); \
	echo -e "\t\t\"Python: Attach to VIM\": {" >>$(D_FILE); \
	echo -e "\t\t\t\"variables\": {" >>$(D_FILE); \
	echo -e "\t\t\t\t\"port\": \"5678\"," >>$(D_FILE); \
	echo -e "\t\t\t\t\"host\": \"localhost\"" >>$(D_FILE); \
	echo -e "\t\t\t}," >>$(D_FILE); \
	echo -e "\t\t\t\"adapter\": \"vscode-cpptools\"," >>$(D_FILE); \
	echo -e "\t\t\t\"configuration\": {" >>$(D_FILE); \
	echo -e "\t\t\t\t\"request\": \"attach\"" >>$(D_FILE); \
	echo -e "\t\t\t}" >>$(D_FILE); \
	echo -e "\t\t}," >>$(D_FILE); \
	echo -e "\t\t\"C: Run current script\": {" >>$(D_FILE); \
	echo -e "\t\t\t\"adapter\": \"vscode-cpptools\"," >>$(D_FILE); \
	echo -e "\t\t\t\"configuration\": {" >>$(D_FILE); \
	echo -e "\t\t\t\t\"request\": \"launch\"," >>$(D_FILE); \
	echo -e "\t\t\t\t\"program\": \"$(PROJECT_PATH)/$(BINDIR)/$(BINARY)\"," >>$(D_FILE); \
	echo -e "\t\t\t\t\"args\": [ \"*\$${args: }\" ]," >>$(D_FILE); \
	echo -e "\t\t\t\t\"justMyCode#json\": \"\$${justMyCode:true}\"" >>$(D_FILE); \
	echo -e "\t\t\t}" >>$(D_FILE); \
	echo -e "\t\t}" >>$(D_FILE); \
	echo -e "\t}" >>$(D_FILE); \
	echo -e "}" >>$(D_FILE)
	@echo "$(D_FILE) successffully generated"
	@echo ""
	@echo "Go to $(PROJECT_PATH) and compile your project: make"
	@echo "Then execute it: bin/$(BINARY) --help"
	@echo "Happy hacking o/"


# Rule for link and generate the binary file
all:
	@for S in $(SRCEXEC); do \
		echo ""; \
		echo -e "$(BROWN)[ Processing $$S/Makefile ]$(END_COLOR)"; \
		$(MAKE) -C $$S; \
	done;
	@echo ""
	@echo -e "$(BROWN)[ Processing objects ]$(END_COLOR)";
	@echo "-"
	@echo -en "$(BROWN)LD $(END_COLOR)";
	$(CC) -o $(BINDIR)/$(BINARY) $(OBJEXEC) $(DEBUG) $(CFLAGS) $(LIBS)
	@echo -en "\n--\nBinary file placed at" \
			  "$(BROWN)$(BINDIR)/$(BINARY)$(END_COLOR)\n";


install: all


run: all
	@echo -e "$(BROWN)Type [ENTER] to run the code "
	@read buff
	@clear
	$(BINDIR)/$(BINARY)


# Rule for run valgrind tool
valgrind:
	valgrind \
		--track-origins=yes \
		--leak-check=full \
		--leak-resolution=high \
		--log-file=$(LOGDIR)/$@.log \
		$(BINDIR)/$(BINARY)
	@echo -en "\nCheck the log file: $(LOGDIR)/$@.log\n"


# Compile tests and run the test binary
tests:
	@echo -en "$(BROWN)CC $(END_COLOR)";
	$(CC) $(TESTDIR)/main.c -o $(BINDIR)/$(TEST_BINARY) $(DEBUG) $(CFLAGS) $(LIBS) $(TEST_LIBS)
	@which ldconfig && ldconfig -C /tmp/ld.so.cache || true # caching the library linking
	@echo -en "$(BROWN) Running tests: $(END_COLOR)";
	./$(BINDIR)/$(TEST_BINARY)


dir:
	@read -p "Directory name: " DIR; \
	[[ -z $$DIR ]] && echo -e "$(BROWN)[ERROR]$(END_COLOR) You need to specify a name for the new directory!" && exit; \
	[[ -d "$(SRCDIR)/$$DIR" ]] && echo -e "$(BROWN)[ERROR]$(END_COLOR) $$DIR already created in $(SRCDIR)" && exit; \
	echo "-" && echo "Creating $$DIR" && mkdir -pv "$(SRCDIR)/$$DIR/$(OBJDIR)" && touch "$(SRCDIR)/$$DIR/$(OBJDIR)/.gitkeep" && echo "$$DIR created in $(SRCDIR)" || exit; \
	echo "-" && echo "Transferring Makefile for $$DIR" && cp -vf "$(MFILEDIR)/Makefile" "$(SRCDIR)/$$DIR" && echo "Makefile transferred for $(SRCDIR)/$$DIR" && echo "-" || exit;


# Rule for cleaning the project
clean:
	@rm -rvf $(BINDIR)/* $(OBJEXEC) $(LOGDIR)/*;
