####################################################
# AVR.Skeleton-C MAKEFILE
####################################################

# get Application Config
include ./config.makefile

# Binaries
CC_BIN          = /usr/bin/avr-gcc
PP_BIN					= /usr/bin/php preprocessor/pre.php
OBJCOPY_BIN     = /usr/bin/avr-objcopy
OBJDUMP_BIN     = /usr/bin/avr-objdump
AVRDUDE_BIN     = /usr/bin/avrdude

# Directories
BUILD_DIR=build/

# Get List of ALL Sourcefiles on Source Path
SOURCES = $(wildcard *.c)

# Create Object List
OBJECTS=$(SOURCES:.c=.o)

# Add additional Flags - force C language
CC_FLAGS += -std=$(CC_STANDARD) -g -mmcu=$(T_DEVICE) -O$(CC_OPTIMIZATION) -DF_CPU=$(T_FCPU)UL -xc
LD_FLAGS += -Wl,-Map=$(BUILD_DIR)application.map,--cref $(foreach d, $(LD_LIBS), -l$d)

# Target name
TARGET = _application

# Tool invocations
default: $(TARGET).elf $(TARGET).hex $(TARGET).lss
all : default

# Link All Object files on Buildpath
$(TARGET).elf: $(OBJECTS)
	@echo 'Building target: $@'
	@echo 'Invoking: AVR C++ Linker'
	$(CC_BIN) $(foreach d, $(OBJECTS), $(BUILD_DIR)$d) -o $(BUILD_DIR)$(TARGET).elf $(LD_FLAGS)
	@echo 'Finished building target: $@'
	@echo ' '

# Conveting .elf to flashable .hex file
$(TARGET).hex: $(TARGET).elf
	@echo 'Create Flash image (ihex format)'
	$(OBJCOPY_BIN) -j .text -j .data -O ihex $(BUILD_DIR)$(TARGET).elf $(BUILD_DIR)$(TARGET).hex
	@echo 'Finished building: $@'
	@echo ' '

# Create extending ASM listing from .elf
$(TARGET).lss: $(TARGET).elf
	@echo 'Invoking: AVR Create Extended Listing'
	$(OBJDUMP_BIN) -h -S $(BUILD_DIR)$(TARGET).elf  > $(BUILD_DIR)$(TARGET).lss
	@echo 'Finished building: $@'
	@echo ' '

# Preprocess, Compile & Assemble Sourcefiles
%.o: %.c
	@echo 'Compiling: $@'
	@mkdir -p $(BUILD_DIR)$(dir $*.o)
	$(PP_BIN) $< | $(CC_BIN) $(CC_FLAGS) -c -o $(BUILD_DIR)/$@ -

# Upload Hex file
install:
	$(AVRDUDE_BIN) -c $(PRG_TYPE) -p $(T_DEVICE) -U flash:w:$(BUILD_DIR)$(TARGET).hex:i

# cleanup (delete) build dir
clean:
	rm -rf $(BUILD_DIR)
