/**
 *  BitIO.h
 *	Bit Manipulation
*/


#include <inttypes.h>
#include "util.h"

#ifndef BITIO_H_
#define BITIO_H_

// set bit
STATIC_INLINE(void BIT_SET(volatile uint8_t *target, uint8_t bit)){
    *target |= (1<<bit);
};

// set clear
STATIC_INLINE(void BIT_CLEAR(volatile uint8_t *target, uint8_t bit)){
    *target &= ~(1<<bit);
};

// bit toogle
STATIC_INLINE(void BIT_TOGGLE(volatile uint8_t *target, uint8_t bit)){
    *target ^= (1<<bit);
};

// set bit by boolean
STATIC_INLINE(void BIT_BOOL_SET(volatile uint8_t *target, uint8_t bit, uint8_t enable)){
    if (enable==0){
        BIT_CLEAR(target, bit);
    }else{
        BIT_SET(target, bit);
    }
};

#endif /* BITIO_H_ */
