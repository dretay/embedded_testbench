ifeq ($(OS),Windows_NT)
  ifeq ($(shell uname -s),) # not in a bash-like shell
	CLEANUP = del /F /Q
	MKDIR = mkdir
  else # in a bash-like shell, like msys
	CLEANUP = rm -f
	MKDIR = mkdir -p
  endif
	TARGET_EXTENSION=.exe
else
	CLEANUP = rm -f
	MKDIR = mkdir -p
	TARGET_EXTENSION=out
endif

TARGET_SO ?= testbench.so

BUILD_DIR = build/
TEST_RESULTS_DIR = build/results/
SRC_DIRS = src/
LIB_DIRS = lib/

TEST_DIRS = test/
TEST_OUTPUT := build/test/
TEST_RUNNERS = test/test_runners/
# TESTS := $(shell find $(TEST_DIRS) -maxdepth 1 -name '*.cpp' -or -name '*.c')

SRCPB = $(wildcard $(SRC_DIRS)*.proto)
PBMODELS = $(patsubst $(SRC_DIRS)%.proto,$(SRC_DIRS)%.pb.c,$(SRCPB) )

SRCT = $(wildcard $(TEST_DIRS)*.c)
RUNNERS = $(patsubst $(TEST_DIRS)%.c,$(TEST_RUNNERS)%.c,$(SRCT) )
RESULTS = $(patsubst $(TEST_DIRS)Test%.c,$(TEST_RESULTS_DIR)Test%.txt,$(SRCT) )
TEST_OBJS = $(SRCT:%=$(BUILD_DIR)%.o)
# FOO = $(wildcard $(TEST_OUTPUT)*)

SRCS := $(shell find $(LIB_DIRS) $(SRC_DIRS) -maxdepth 2 -name '*.cpp' -or -name '*.c' -or -name '*.s')
OBJS := $(SRCS:%=$(BUILD_DIR)%.o)
DEPS := $(OBJS:.o=.d)
INC_DIRS := $(shell find $(LIB_DIRS) -maxdepth 1 -type d)
CFLAGS ?= $(INC_FLAGS) -DPB_FIELD_16BIT -fPIC -Wno-format-extra-args
PROTOC := /home/drew/src/nanopb-0.3.9.3/generator-bin/protoc

UNITY_ROOT=/home/drew/src/Unity
INC_FLAGS := $(addprefix -I,$(INC_DIRS)) -I$(UNITY_ROOT)/src -I./src

#for this to work it needs to generate an entry per desired results file (pathr in testwork files)
.PHONY: all
all: $(PBMODELS) $(RUNNERS) $(OBJS) build/src/hid.pb.c.o $(TEST_OBJS) $(RESULTS) test



.PHONY: test
test: 
	@echo ""
	@echo "-----------------------TEST RESULTS-----------------------"
	@echo `grep -s IGNORE $(TEST_RESULTS_DIR)/*.txt|wc -l` "tests ignored"
	@echo `grep -s IGNORE $(TEST_RESULTS_DIR)/*.txt`
	@echo `grep -s FAIL $(TEST_RESULTS_DIR)/*.txt|wc -l` "tests failed"
	@echo `grep -s FAIL $(TEST_RESULTS_DIR)/*.txt`
	@echo `grep -s PASS $(TEST_RESULTS_DIR)/*.txt|wc -l` "tests passed"
#tests
$(TEST_RESULTS_DIR)%.txt: $(BUILD_DIR)%.c.o.out
	$(MKDIR_P) $(dir $@)
	-./$< > $@ 2>&1

$(BUILD_DIR)%.c.o.out: $(TEST_OUTPUT)%.c.o
	$(CC) -o $@ $^ $(INC_FLAGS) $(OBJS) build/src/hid.pb.c.o $(UNITY_ROOT)/src/unity.c $(TEST_RUNNERS)$(basename $(notdir $<))

# assembly
$(BUILD_DIR)%.s.o: %.s	
	$(MKDIR_P) $(dir $@)
	$(AS) $(ASFLAGS) -c $< -o $@

# c source
$(BUILD_DIR)%.c.o: %.c 
	$(MKDIR_P) $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@ 

# protocol buffer models
$(SRC_DIRS)%.pb.c:: $(SRC_DIRS)%.proto
	$(PROTOC) --nanopb_out=. $<

#unity test runners
$(TEST_RUNNERS)%.c:: $(TEST_DIRS)%.c
	ruby $(UNITY_ROOT)/auto/generate_test_runner.rb $< $@



.PHONY: jupyter
jupyter: pythondeps
	( \
		jupyter notebook; \
	)

.PHONY: pythondeps
pythondeps: 
	( \
		. ./bin/activate; \
		pip install -r ./requirements.txt; \
	)

# .PHONY: valgrind
# valgrind: $(TESTS)
# 	/usr/bin/valgrind  --suppressions=valgrind.memcheck.supp --gen-suppressions=all --tool=memcheck --leak-check=full $(BUILD_DIR)/$(notdir $^).out

.PHONY: clean
clean:
	@$(RM) -r $(BUILD_DIR)
	@$(RM) -r $(TEST_DIRS)/test_runners/*
	@find $(SRC_DIRS) -type f -name '*.pb.*' -delete 
MKDIR_P ?= mkdir -p

.PRECIOUS: $(TEST_RESULTS_DIR)%.txt
.PRECIOUS: $(BUILD_DIR)%.c.o.out