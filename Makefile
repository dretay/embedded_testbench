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

#directories
BUILD_DIR = build/
TEST_RESULTS_DIR = build/results/
TEST_OUTPUT = build/test/
SRC_DIRS = src/
LIB_DIRS = lib/
TEST_DIRS = test/
TEST_RUNNERS = test/test_runners/

#protobuf files
SRCPB = $(wildcard $(SRC_DIRS)*.proto)
PBMODELS = $(patsubst $(SRC_DIRS)%.proto,$(SRC_DIRS)%.pb.c,$(SRCPB) )
PROTOC = /home/drew/src/nanopb-0.3.9.3/generator-bin/protoc
PB_OBJS = $(patsubst $(SRC_DIRS)%.proto,$(BUILD_DIR)$(SRC_DIRS)%.pb.c.o,$(SRCPB) )

#unity testing files
SRCT = $(wildcard $(TEST_DIRS)*.c)
RUNNERS = $(patsubst $(TEST_DIRS)%.c,$(TEST_RUNNERS)%.c,$(SRCT) )
RESULTS = $(patsubst $(TEST_DIRS)Test%.c,$(TEST_RESULTS_DIR)Test%.txt,$(SRCT) )
TEST_OBJS = $(SRCT:%=$(BUILD_DIR)%.o)
UNITY_ROOT=/home/drew/src/Unity

#valgrind stuff
VALGRIND = /usr/bin/valgrind
VALGRIND_SUPPS = valgrind.memcheck.supp
MEM_LEAKS = `grep -Poh 'ERROR SUMMARY:\K ([0-9]+)' $(TEST_RESULTS_DIR)*| awk '{ SUM += $$1} END { print SUM }'`

#project source files
SRCS := $(shell find $(LIB_DIRS) $(SRC_DIRS) -maxdepth 2 -name '*.c')
OBJS = $(SRCS:%=$(BUILD_DIR)%.o) $(PB_OBJS)
DEPS = $(OBJS:.o=.d)
INC_DIRS := $(shell find $(LIB_DIRS) -maxdepth 1 -type d)

#misc variables
CFLAGS = $(INC_FLAGS) -DPB_FIELD_16BIT -fPIC -Wno-format-extra-args
INC_FLAGS := $(addprefix -I,$(INC_DIRS)) -I$(UNITY_ROOT)/src -I./src
CURRENT_DIR = $(notdir $(shell pwd))

.PHONY: all
all: $(PBMODELS) $(RUNNERS) $(OBJS) $(BUILD_DIR)/$(CURRENT_DIR).so

.PHONY: test
test: all $(TEST_OBJS) $(RESULTS) 
	@echo ""
	@echo "-----------------------TESTING SUMMARY-----------------------"
	@echo `grep -s IGNORE $(TEST_RESULTS_DIR)/*.txt|wc -l` "tests ignored"
	@echo `grep -s IGNORE $(TEST_RESULTS_DIR)/*.txt`
	@echo `grep -s FAIL $(TEST_RESULTS_DIR)/*.txt|wc -l` "tests failed"
	@echo `grep -s FAIL $(TEST_RESULTS_DIR)/*.txt`
	@echo `grep -s PASS $(TEST_RESULTS_DIR)/*.txt|wc -l` "tests passed"
	@echo ""
	@echo "$(MEM_LEAKS) memory leak(s) detected"

#link objects into an so to be included elsewhere
$(BUILD_DIR)/$(CURRENT_DIR).so: $(OBJS)
	$(LD) $(OBJS) -shared -o $@

#execute tests
$(TEST_RESULTS_DIR)%.txt: $(BUILD_DIR)%.c.o.$(TARGET_EXTENSION)
	$(MKDIR) $(dir $@)
	-$(VALGRIND) --suppressions=$(VALGRIND_SUPPS) --gen-suppressions=all --tool=memcheck --leak-check=full $< > $@ 2>&1

#build the test runners
$(BUILD_DIR)%.c.o.$(TARGET_EXTENSION): $(TEST_OUTPUT)%.c.o
	$(CC) -o $@ $^ $(INC_FLAGS) $(OBJS) $(UNITY_ROOT)/src/unity.c $(TEST_RUNNERS)$(basename $(notdir $<))

# assembly
$(BUILD_DIR)%.s.o: %.s	
	$(MKDIR) $(dir $@)
	$(AS) $(ASFLAGS) -c $< -o $@

# c source
$(BUILD_DIR)%.c.o: %.c 
	$(MKDIR) $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@ 

# protocol buffer models
$(SRC_DIRS)%.pb.c:: $(SRC_DIRS)%.proto
	$(PROTOC) --nanopb_out=. $<

#unity test runners
$(TEST_RUNNERS)%.c:: $(TEST_DIRS)%.c
	ruby $(UNITY_ROOT)/auto/generate_test_runner.rb $< $@

.PHONY: jupyter
jupyter: all pythondeps
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
	$(CLEANUP) $(OBJS) $(TEST_OBJS)	$(RESULTS) $(BUILD_DIR)*.out $(SRC_DIRS)*.pb.*

.PRECIOUS: $(TEST_RESULTS_DIR)%.txt
.PRECIOUS: $(BUILD_DIR)%.c.o.out