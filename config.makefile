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
CC_FLAGS = -Wall -Wextra -funsigned-char -funsigned-bitfields -fshort-enums -fpack-struct -ffunction-sections -fdata-sections -Winline
LD_FLAGS = #-Wl,--gc-sections

# Libraries e.g. m, printf, ...
LD_LIBS = m

# Optimization Level [0, 1, 2, 3, s]
CC_OPTIMIZATION = 2

# C Standard Level
CC_STANDARD = gnu99

# Programmer Settings (AVRDUDE)
# ---------------------------
PRG_TYPE = avrispmkII
