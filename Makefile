#
# Makefile for the AVR Command Line Projects
#
# Copyright (c) 2016 Imre Horvath
# Released under the MIT license
#

PART = attiny85
F_CPU = 1000000UL
PROGRAMMER = arduino
PORT = /dev/cu.usbmodem1411
BAUDRATE = 19200
BITCLOCK = 20
LFUSE = 0x62
HFUSE = 0xDC
EFUSE = 0xFF

OBJECTS = prog.o
OPTIMIZE = -Os

PRG = prog
CC = avr-gcc
CXX = avr-g++
CFLAGS = -I. -g -Wall $(OPTIMIZE) -mmcu=$(PART) -DF_CPU=$(F_CPU)
CXXFLAGS = $(CFLAGS)
LDFLAGS = -Wl,-Map,$(PRG).map
OBJCOPY = avr-objcopy
OBJDUMP = avr-objdump
AVRDUDE = avrdude -v -c $(PROGRAMMER) -p $(PART) -P $(PORT) -b $(BAUDRATE) -B $(BITCLOCK)

.PHONY: all clean flash read setfuses avrdude

all: $(PRG).hex $(PRG).lst

$(PRG).elf: $(OBJECTS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

%.hex: %.elf
	$(OBJCOPY) -j .text -j .data -O ihex $< $@

%.lst: %.elf
	$(OBJDUMP) -h -S $< > $@

clean:
	rm -f $(PRG).hex $(PRG).elf $(PRG).map $(PRG).lst $(OBJECTS)

flash: $(PRG).hex
	$(AVRDUDE) -U flash:w:$(PRG).hex:i

read:
	$(AVRDUDE) -U flash:r:read.hex:i

setfuses:
	$(AVRDUDE) -U lfuse:w:$(LFUSE):m -U hfuse:w:$(HFUSE):m -U efuse:$(EFUSE):m

avrdude:
	$(AVRDUDE)
