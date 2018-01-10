#include "util.h"

#ifndef RANDOM_H_
#define RANDOM_H_

// generate a 16bit seed by XORing the unintialized RAM (HEAP+STACK)
// AVR RAM Layout: DATA | (heapstart) HEAP ... STACK (RAMEND)| EXTERNAL
STATIC_INLINE(uint16_t getPseudoSeed()){
  // the heap start address
  extern uint16_t __heap_start;

  // the seed to return including initial value (randomly chosen)
  uint16_t seed = 0xA4E1;

  // the end address of the RAM
  uint16_t *i = (uint16_t*) (RAMEND + 1);

  // generate XOR seed
  while (&__heap_start <= --i) {
    seed ^= *i;
  }

  return seed;
}

#endif /* RANDOM_H_ */
