/**
 *  Baudrate.h
 *	Simple Baudarte (UDRR) calculation
*/

#ifndef BAUDRATE_H_
#define BAUDRATE_H_

#include "Util.h"
#include <inttypes.h>

// calculate UBRR register settings
STATIC_INLINE(uint16_t getBaudrate(uint32_t baudrate)){
	return (uint16_t) (F_CPU/(baudrate*16L)-1);
};

#endif /* BAUDRATE_H_ */
