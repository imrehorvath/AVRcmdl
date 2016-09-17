#include <avr/io.h>
#include <util/delay.h>

/*
 * This is the blink example on the ATtiny85.
 *
 * Copyright (c) 2016 Imre Horvath
 * Released under the MIT license
 *
 * ATtiny85 Data Sheet:
 * http://www.atmel.com/images/atmel-2586-avr-8-bit-microcontroller-attiny25-attiny45-attiny85_datasheet.pdf
 *
 * Circuit:
 * PB1 -> 1K resistor -> LED -> GND
 */
int main(void) {

  // Set PB1 as output
  DDRB |= _BV(PB1);

  // Toggle HIGH and LOW on PB1 once a second,
  // do it forever
  while (1) {
    PORTB ^= _BV(PB1);
    _delay_ms(1000);
  }

  // Never reached
  return 0;
}
