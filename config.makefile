# Target Device Settings
# ---------------------------

# The AVR Device (AVR-GCC/AVRDUDE) you compile for
T_DEVICE = atmega328p

# Target Clock (F_CPU) in Hz
T_FCPU  = 20000000

# Fuse Settings
T_FUSE_L = 0xFF
T_FUSE_H = 0xFF
T_FUSE_E = 0xFF

# Compiler/Linker Settings
# ---------------------------

# General Options - remove unused functions (garbage collection)
CC_FLAGS += -fpack-struct  
CC_FLAGS += -fshort-enums 
CC_FLAGS += -ffunction-sections
CC_FLAGS += -fdata-sections
CC_FLAGS += -funsigned-char
CC_FLAGS += -funsigned-bitfields 

# General Options
LD_FLAGS += -Wl,--gc-sections
LD_FLAGS += -mrelax

#avr-gcc -Wall -O2 -fpack-struct -fshort-enums -ffunction-sections -fdata-sections 
#-std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=atmega328p -DF_CPU=20000000UL
# -MMD -MP -MF"StarlightController.d" -MT"StarlightController.d" -c -o "StarlightController.o" "../StarlightController.c"

# Libraries e.g. m, printf, ...
LD_LIBS = m

# Optimization Level [0, 1, 2, 3, s]
CC_OPTIMIZATION = 2

# C Standard Level
CC_STANDARD = gnu99

# Programmer Settings (AVRDUDE)
# ---------------------------
PRG_TYPE = avrispmkII
