#!/bin/zsh

arm-none-eabi-gcc -x assembler-with-cpp -c -O0 -mcpu=cortex-m4 -mthumb -Wall core.S -o core.o
arm-none-eabi-gcc core.o -mcpu=cortex-m4 -mthumb -Wall --specs=nosys.specs -nostdlib -lgcc -Tsrc/stm32fxx.ld -o main.elf
arm-none-eabi-nm main.elf
