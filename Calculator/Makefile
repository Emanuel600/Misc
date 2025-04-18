# Toolchain
TOOLCHAIN		= C:/VScode/toolchains
CXX				= g++
# Flags
W_FLAGS			= -Wall -Wextra -D_DEBUG
FLAGS			= $(W_FLAGS)
CXX_FLAGS		= $(FLAGS)
CXX_FLAGS		+= -std=gnu++17

# Directories
BUILD_DIR		= build
BIN_DIR			= bin
DOC_DIR			= docs

# Files
vpath %.cpp
vpath %.hpp

CXX_HEADS		= $(wildcard *.hpp)

CXX_SRCS		= $(wildcard *.cpp)

OBJECTS			= $(addprefix $(BUILD_DIR)/, $(CXX_SRCS:.cpp=.o))

APP				= Calculator_Tester
APP				:= $(addprefix $(BIN_DIR)/, $(APP))

# Create build directory
$(BUILD_DIR)/:
	mkdir -p $(BUILD_DIR)
# Create bin directory
$(BIN_DIR)/:
	mkdir -p $(BIN_DIR)
# Created dep directory
$(DOC_DIR)/:
	mkdir -p $(DOC_DIR)
#====================#
.PHONY: clean compile CleanCompile run CleanAll CleanBin
.PHONY: help CleanDocs dox

# 'compile' tracks all relevant files
compile: $(APP).exe

run: $(APP).exe
	./$(APP).exe

$(BUILD_DIR)/%.o: %.cpp $(CXX_HEADS) | $(BUILD_DIR)/
	@echo ""
	@echo ""
	@echo "Building $(notdir $@):"
	$(CXX) -c $(CXX_FLAGS) $< -o $@

$(APP).exe: $(OBJECTS) | $(BIN_DIR)/
	@echo ""
	@echo ""
	@echo "==| Compiling Executable |=="
	$(CXX) $(OBJECTS) -o $(APP).exe

Doxyfile:
	doxygen -g Doxyfile

dox: Doxyfile
	doxygen Doxyfile

clean:
	rm -f $(BUILD_DIR)/*

CleanAll: clean CleanBin CleanDocs

CleanBin:
	rm -f $(BIN_DIR)/*

CleanDocs:
	rm -rf $(DOC_DIR)/*

CleanCompile: clean compile

test:
	@echo "$(OBJECTS)"

.DEFAULT_GOAL		:= run

help:
	@echo "Available rules:"
	@echo ""
	@echo "compile:"
	@echo "	Compiles target, tracks all objects, sources and headers"
	@echo ""
	@echo "dox:"
	@echo "	Makes project documentation with Doxygen"
	@echo ""
	@echo "clean:"
	@echo "	Cleans everything on /build and /dep directories"
	@echo ""
	@echo "CleanBin:"
	@echo "	Cleans /bin"
	@echo ""
	@echo "CleanDocs:"
	@echo "	Cleans /docs"
	@echo ""
	@echo "CleanAll:"
	@echo "	Cleans /build, /bin and /docs"
	@echo ""
	@echo "ShowHelp (default goal):"
	@echo "	Shows this info, all available goals and extras configured"
	@echo "as tasks"
	@echo ""
