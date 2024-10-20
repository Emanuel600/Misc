## Set directories and build name
BUILD_DIR := 	build
BUILD_NAME := 	threads
HEADER_DIR := 	headers
## Flags
DEBUG := 		DEBUG
FLAGS_C := 		-Wall -I$(HEADER_DIR) -D$(DEBUG) \
				-flto -fdata-sections -ffunction-sections
## Optimize for release or debug
ifdef DEBUG
OPT_FLAG := -Og
else
OPT_FLAG := -O3
endif
FLAGS = $(FLAGS_C) $(OPT_FLAG)
## Linker
FLAGS_LINKER := $(FLAGS) -pthread
## Get source files and prepare for object files
SOURCES := $(wildcard *.c)
OBJECTS := $(SOURCES:.c=.o)
##
C_COMPILER := gcc
## Make recipes
BUILD_DIR:
	mkdir -p $(BUILD_DIR)
.PHONY: clean build CleanCompile debug compile

$(BUILD_DIR)/%.o: %.c | $(BUILD_DIR)/
	@echo Creating object $@
	$(C_COMPILER) $(FLAGS) -c $< -o $@

$(BUILD_NAME): $(addprefix $(BUILD_DIR)/, $(OBJECTS))
	@echo Compiling final program
	$(C_COMPILER) $(FLAGS_LINKER) \
	$(addprefix $(BUILD_DIR)/, $(OBJECTS)) -o $(BUILD_NAME)

debug:
	@echo $(addprefix $(BUILD_DIR)/, $(OBJECTS))
build: $(BUILD_NAME)
compile: build
clean:
	rm $(BUILD_DIR)/*
CleanCompile: clean; compile
