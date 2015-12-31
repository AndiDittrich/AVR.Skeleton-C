Skeleton-C
==========

Simple Makefile Template for 8Bit AVR Projects

## Features ##

* Simply compile all C-Files of a project
* Project configuration within a simple config file
* Generates the `.hex` image and extended listing `.lss`
* Includes some basic utility functions located in `Lib/`

## TODO ##
* Use [AVRDUDE](http://www.nongnu.org/avrdude/) to upload the flash image to your target


## Requirement: AVR Toolchain ##

The AVR Toolchain can be installed with your package manager, or *in case you need a more recent version* manually by downloading the [Official Toolchain Package](http://www.atmel.com/tools/atmelavrtoolchainforlinux.aspx)

**Ubuntu/Debian**

```bash
apt-get install make avr-libc binutils-avr gcc-avr avrdude
```

## Usage ##

1. Download the Skeleton-C package `wget https://github.com/AndiDittrich/EnlighterJS/archive/master.zip -O skeleton.zip`
2. Unpack it `unzip skeleton.zip`
3. Customize the project based configuration by editing `config.makefile` to match your MCU-Type and frequency
4. Compile your project with `make`
5. Upload the flash image to your device `make install`

All build-files are stored in the `build/` directorie. The output files are prefixed with **_application**.
For example, the generated hex file is located in `build/_application.hex`

## Project based Configuration ##
To edit linker, compiler flags, MCU-target, frequency you just need to edit the `config.makefile` file.
This allows you to easily update the **Skeleton-C** project without merging the makefile manually!

### Exmaple - Target Device Settings ###

* 8MHz Clock
* atmega16

```makefile
# The AVR Device (AVR-GCC/AVRDUDE)
T_DEVICE = atmega16

# Target Clock (F_CPU) in Hz
T_FCPU  = 8000000
```

## Library Functions ##

The Skeleton-C also includes some basic utility functions which may be need in every project

### Util.h ###

Utility Functions

#### nop ####

Description: No-Operation assembly wrapper - useful to avoid loop-optimizations.

Syntax: `nop()`

```c
while (y > 3){
  nop();
}
```

#### WAIT_WHILE ####

Description: Wait (loop until) the condition is true (not 0)

Syntax: `WAIT_WHILE(condition)`

```c
showStatusLed(1);

// wait for frame data complete
WAIT_WHILE(currentTransmitIndex<FRAME_SIZE);

showStatusLed(0);
```

#### STATIC_INLINE ####

Description: Wrapper function to add an implicit function declaration with `__attribute__((always_inline))` to force inlining

Syntax: `STATIC_INLINE(declaration){ body }`

```c
// set a single bit - will be optimized to sbi
STATIC_INLINE(void BIT_SET(volatile uint8_t *target, uint8_t bit)){
	*target |= (1<<bit);
};
```


### BitIO.h ###

Basic Bit-Manipulation utility. Implemented as inline-functions to throw readable errors in case of wrong usage.

#### BIT_SET #####

Description: Inline function to **set** a single bit within a byte

Syntax: `BIT_SET(target:uint8_t*,bitNum:uint8_t)`

```c
// re-enable interrupts to process UDRE events
BIT_SET(&UCSR0B, UDRIE0);
```

#### BIT_CLEAR ####

Description: Inline function to **clear** a single bit within a byte

Syntax: `BIT_CLEAR(target:uint8_t*,bitNum:uint8_t)`

```c
// disable interrupts of UDRE events
BIT_CLEAR(&UCSR0B, UDRIE0);
```

#### BIT_TOGGLE ####

Description: Inline function to **toggle** a single bit within a byte

Syntax: `BIT_TOGGLE(target:uint8_t*,bitNum:uint8_t)`

```c
// toggle a port bit
BIT_TOGGLE(&PORTA, PINA2);
```

#### BIT_BOOL_SET ####

Description: Inline function to **set** a single bit within a byte by a given boolean value (0, 1)

Syntax: `BIT_BOOL_SET(target:uint8_t*, bitNum:uint8_t, enable:uint8_t)`

```c
// define c++ like true, false
#define TRUE 1
#define FALSE 0

// set PIN4 on PORTB to 1
BIT_BOOL_SET(&PORTB, PINB4, TRUE);
```

### Baudrate.h ###

Simple Baudarte (UDRR) calculation

#### getBaudrate ####

Description: Helper function to calculate the UBRR value

Syntax: `getBaudrate(baud:uint32_t)`

```c
#include "Lib/Baudrate.h"

// DMX Transmitter Setup. 250k baud
UBRR0 = getBaudrate(250000);
```
### Boolean.h ###

Boolean Constants

#### CONSTANTS ####

**TRUE,true** => 1
**FALSE,false** => 0

```c
enableUART(true);

showLED1(FALSE);
```

## Any Questions ? Report a Bug ? Enhancements ? ##

Please open a new issue on [GitHub](https://github.com/AndiDittrich/AVR.Skeleton-C/issues)

## License ##

AVR.Skeleton-C is OpenSource and licensed under the Terms of [The MIT License (X11)](http://opensource.org/licenses/MIT). You're welcome to [contribute](https://github.com/AndiDittrich/AVR.Skeleton-C/blob/master/CONTRIBUTE.md)!
