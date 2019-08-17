TARGET_SO ?= testbench.so

BUILD_DIR ?= ./build
SRC_DIRS ?= ./src
LIB_DIRS ?= ./lib

PBMODELS := $(shell find $(SRC_DIRS) -maxdepth 1 -name '*.proto')
SRCS := $(shell find $(LIB_DIRS) $(SRC_DIRS) -maxdepth 2 -name '*.cpp' -or -name '*.c' -or -name '*.s')
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

INC_DIRS := $(shell find $(LIB_DIRS) -maxdepth 1 -type d)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

CFLAGS ?= $(INC_FLAGS) -DPB_FIELD_16BIT -fPIC

PROTOC := /home/drew/src/nanopb-0.3.9.3/generator-bin/protoc

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


# pb model compile
.PHONY: protobuf
protobuf: $(PBMODELS)
	$(PROTOC) --nanopb_out=. $<

.PHONY: test
test : protobuf $(BUILD_DIR)/$(TARGET_SO) 
	( \
       . ./bin/activate; \
		pytest test/; \
    )
	
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
	find $(SRC_DIRS) -type f -name '*.pb.*' -delete 

-include $(DEPS)

MKDIR_P ?= mkdir -p
