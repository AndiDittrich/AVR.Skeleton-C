# Library Functions #

The Skeleton-C also includes some basic utility functions which may be need in every project

## Utility Functions ##

#### nop ####

Description: No-Operation assembly wrapper - useful to avoid loop-optimizations.

Source: `Lib/Util.h`

Syntax: `nop()`

```c
#include "Lib/Util.h"

while (y > 3){
  nop();
}
```

#### WAIT_WHILE ####

Description: Wait (loop until) the condition is true (not 0)

Source: `Lib/Util.h`

Syntax: `WAIT_WHILE(condition)`

```c
showStatusLed(1);

// wait for frame data complete
WAIT_WHILE(currentTransmitIndex<FRAME_SIZE);

showStatusLed(0);
```

#### STATIC_INLINE ####

Description: Wrapper function to add an implicit function declaration with `__attribute__((always_inline))` to force inlining

Source: `Lib/Util.h`

Syntax: `STATIC_INLINE(declaration){ body }`

```c
// set a single bit - will be optimized to sbi
STATIC_INLINE(void BIT_SET(volatile uint8_t *target, uint8_t bit)){
	*target |= (1<<bit);
};
```


## BIT Manipulation ##

Basic Bit-Manipulation utility. Implemented as inline-functions to throw readable errors in case of wrong usage.

#### BIT_SET #####

Description: Inline function to **set** a single bit within a byte

Source: `Lib/BitIO.h`

Syntax: `BIT_SET(target:uint8_t*,bitNum:uint8_t)`

```c
// re-enable interrupts to process UDRE events
BIT_SET(&UCSR0B, UDRIE0);
```

#### BIT_CLEAR ####

Description: Inline function to **clear** a single bit within a byte

Source: `Lib/BitIO.h`

Syntax: `BIT_CLEAR(target:uint8_t*,bitNum:uint8_t)`

```c
// disable interrupts of UDRE events
BIT_CLEAR(&UCSR0B, UDRIE0);
```

#### BIT_TOGGLE ####

Description: Inline function to **toggle** a single bit within a byte

Source: `Lib/BitIO.h`

Syntax: `BIT_TOGGLE(target:uint8_t*,bitNum:uint8_t)`

```c
// toggle a port bit
BIT_TOGGLE(&PORTA, PINA2);
```

#### BIT_BOOL_SET ####

Description: Inline function to **set** a single bit within a byte by a given boolean value (0, 1)

Source: `Lib/BitIO.h`

Syntax: `BIT_BOOL_SET(target:uint8_t*, bitNum:uint8_t, enable:uint8_t)`

```c
// define c++ like true, false
#define TRUE 1
#define FALSE 0

// set PIN4 on PORTB to 1
BIT_BOOL_SET(&PORTB, PINB4, TRUE);
```

#### BIT_MASK ####

Description: creates a bitmask from a list of bit positions

Source: **PREPROCESSOR**

Syntax: `BIT_MASK(bitNum0, ...)`

```c
// PORT Initialization
DDRA = BIT_MASK(PINA1, PINA2, PINA3, PINA8);

// will be pre-processed to
// DDRA = (1<<PINA1 | 1<<PINA2 | 1<<PINA3 | 1<<PINA8);
```

## Baudrate Settings ##

Simple Baudarte (UDRR) calculation

#### getBaudrate ####

Description: Helper function to calculate the UBRR value

Source: `Lib/Baudrate.h`

Syntax: `getBaudrate(baud:uint32_t)`

```c
#include "Lib/Baudrate.h"

// DMX Transmitter Setup. 250k baud
UBRR0 = getBaudrate(250000);
```

## Basic Constants ##

Some basic constants

#### Boolean ####

Source: `Lib/Constants.h`

* **TRUE** - 1
* **true** - 1
* **FALSE** - 0
* **false** - 0

```c
#include "Lib/Constants.h"

enableUART(true);

showLED1(FALSE);
```

## Random ##

Pseudo Random Number Utlities

#### getPseudoSeed ####

Description: Generates a pseudo random seed to initialize the random number generator by XORing the RAM (Heap+Stack) - should by called as **first function** within your main() routine!

Source: `Lib/Random.h`

Syntax: `uint16_t getPseudoSeed()`

```c
#include "Lib/Random.h"

// Initialize srand()
srand(getPseudoSeed());
```
