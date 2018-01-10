####################################################
# AVR.Skeleton-C MAKEFILE
####################################################

# Default Flags
CC_FLAGS = -Wall -Wextra
LD_FLAGS = 

# get Application Config
include ./config.makefile

# Binaries
CC_BIN          = /usr/bin/avr-gcc
OBJCOPY_BIN     = /usr/bin/avr-objcopy
OBJDUMP_BIN     = /usr/bin/avr-objdump
SIZE_BIN        = /usr/bin/avr-size
AVRDUDE_BIN     = /usr/bin/avrdude
XXD_BIN         = /usr/bin/xxd

# Directories
BUILD_DIR=build/
TMP_DIR=.tmp/

# Get List of ALL Sourcefiles on Source Path
SOURCES = $(wildcard *.c) $(wildcard Driver/*.c)

# Create Object List
OBJECTS=$(SOURCES:.c=.o)

# Add additional Flags
CC_FLAGS += -std=$(CC_STANDARD) -g -mmcu=$(T_DEVICE) -O$(CC_OPTIMIZATION) -DF_CPU=$(T_FCPU)UL
LD_FLAGS += -Wl,-Map=$(BUILD_DIR)application.map,--cref $(foreach d, $(LD_LIBS), -l$d) -mmcu=$(T_DEVICE)

# Target name
TARGET = _application

# Tool invocations
default: $(TARGET).elf $(TARGET).hex $(TARGET).lss sizedummy
all : default

# Link All Object files on Buildpath
$(TARGET).elf: $(OBJECTS)
	@echo 'Building target: $@'
	@echo 'Invoking: AVR C++ Linker'
	$(CC_BIN) $(LD_FLAGS) -o $(BUILD_DIR)$(TARGET).elf $(foreach d, $(OBJECTS), $(BUILD_DIR)$d)
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
	$(OBJDUMP_BIN) -h -S $(BUILD_DIR)$(TARGET).elf > $(BUILD_DIR)$(TARGET).lss
	@echo 'Finished building: $@'
	@echo ' '
	
# Print Size
sizedummy: $(TARGET).elf
	@echo 'Invoking: Print Size'
	$(SIZE_BIN) --format=avr --mcu=$(T_DEVICE) $(BUILD_DIR)$<
	@echo 'Finished building: $@'
	@echo ' '

# Compile Sourcefiles
%.o: %.c
	@echo 'Compiling: $@'
	@mkdir -p $(BUILD_DIR)$(dir $*.o)
	$(CC_BIN) $(CC_FLAGS) -c -o $(BUILD_DIR)$@ $<

# eeprom hex list to ihex
eeprom-write:
	@mkdir -p $(TMP_DIR)
	@cat eeprom.txt | $(XXD_BIN) -r -p > $(TMP_DIR)eeprom.bin
	$(OBJCOPY_BIN) -I binary -O ihex $(TMP_DIR)eeprom.bin $(BUILD_DIR)eeprom.hex
	$(AVRDUDE_BIN) -c $(PRG_TYPE) -p $(T_DEVICE) -U eeprom:w:$(BUILD_DIR)eeprom.hex:i

# eeprom write with input prompt
eeprom-input-prompt:
	@read -p "Enter EEPROM Data (hex): " data; echo $$data > eeprom.txt

# eeprom input prompt -> eeprom wirte
eeprom-write-direct: eeprom-input-prompt eeprom-write

# show eeprom data
eeprom-dump:
	@mkdir -p $(TMP_DIR)
	$(AVRDUDE_BIN) -c $(PRG_TYPE) -p $(T_DEVICE) -U eeprom:r:$(TMP_DIR)eeprom-dump.hex:h
	@cat $(TMP_DIR)eeprom-dump.hex

# Upload Hex file
install:
	$(AVRDUDE_BIN) -c $(PRG_TYPE) -p $(T_DEVICE) -U flash:w:$(BUILD_DIR)$(TARGET).hex:a

# cleanup (delete) build dir
clean:
	rm -rf $(BUILD_DIR)
