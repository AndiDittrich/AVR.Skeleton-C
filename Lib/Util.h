/**
 *  Util.h
 *	Some Helper Functions
*/

#ifndef UTIL_H_
#define UTIL_H_

// simple assembly no-operation
#define nop() asm volatile ("nop")

// REAL inline function...
#define STATIC_INLINE(fstruct) \
	static inline fstruct  __attribute__((always_inline));\
	static inline fstruct

// wait for condition complete
#define WAIT_WHILE(condition) while(condition){asm volatile ("nop");}

#endif /* UTIL_H_ */
