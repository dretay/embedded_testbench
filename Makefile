TARGET_SO ?= testbench.so

BUILD_DIR ?= ./build
SRC_DIRS ?= ./src
LIB_DIRS ?= ./lib
TEST_DIRS ?= ./test
TESTS := $(shell find $(TEST_DIRS) -maxdepth 1 -name '*.cpp' -or -name '*.c')

PBMODELS := $(shell find $(SRC_DIRS) -maxdepth 1 -name '*.proto')
SRCS := $(shell find $(LIB_DIRS) $(SRC_DIRS) -maxdepth 2 -name '*.cpp' -or -name '*.c' -or -name '*.s')
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)
INC_DIRS := $(shell find $(LIB_DIRS) -maxdepth 1 -type d)
CFLAGS ?= $(INC_FLAGS) -DPB_FIELD_16BIT -fPIC -Wno-format-extra-args
PROTOC := /home/drew/src/nanopb-0.3.9.3/generator-bin/protoc

UNITY_ROOT=/home/drew/src/Unity
INC_FLAGS := $(addprefix -I,$(INC_DIRS)) -I$(UNITY_ROOT)/src -I./src

$(BUILD_DIR)/$(TARGET_SO): $(OBJS)
	$(LD) $(OBJS) -shared -o $@

# assembly
$(BUILD_DIR)/%.s.o: %.s
	$(MKDIR_P) $(dir $@)
	$(AS) $(ASFLAGS) -c $< -o $@

# c source
$(BUILD_DIR)/%.c.o: %.c 
	$(MKDIR_P) $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@ 

.PHONY: test
test: $(TESTS)
	ruby $(UNITY_ROOT)/auto/generate_test_runner.rb $^  test/test_runners/$(notdir $^)
	$(CC) $(CFLAGS) $(INC_FLAGS) $(UNITY_ROOT)/src/unity.c $^ test/test_runners/$(notdir $^) $(OBJS) -o $(BUILD_DIR)/$(notdir $^).out
	$(BUILD_DIR)/$(notdir $^).out

valgrind: $(TESTS)
	/usr/bin/valgrind  --suppressions=valgrind.memcheck.supp --gen-suppressions=all --tool=memcheck --leak-check=full $(BUILD_DIR)/$(notdir $^).out

# pb model compile
.PHONY: protobuf
protobuff: $(PBMODELS)
	$(PROTOC) --nanopb_out=. $<
	
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

.PHONY: clean
clean:
	$(RM) -r $(BUILD_DIR)
	$(RM) -r $(TEST_DIRS)/test_runners/*
	find $(SRC_DIRS) -type f -name '*.pb.*' -delete 

-include $(DEPS)

MKDIR_P ?= mkdir -p
