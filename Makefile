TARGET = main

MCU_SPEC = cortex-m4

TOOLCHAIN = /usr/local/gcc-arm-none-eabi-x86_64-linux/gcc-arm-none-eabi-10.3-2021.10/bin

CC = $(TOOLCHAIN)/arm-none-eabi-gcc
AS = $(TOOLCHAIN)/arm-none-eabi-as
LD = $(TOOLCHAIN)/arm-none-eabi-ld
OC = $(TOOLCHAIN)/arm-none-eabi-objcopy
OD = $(TOOLCHAIN)/arm-none-eabi-objdump
OS = $(TOOLCHAIN)/arm-none-eabi-size

LD_SCRIPT = boot/stm32f405xx.ld
LSCRITP = ./$(LD_SCRIPT)

ASFLAGS = -c -O0 -mcpu=$(MCU_SPEC) -mthumb -Wall
CFLAGS = -mcpu=$(MCU_SPEC) -mthumb -Wall -g --specs=nosys.specs
LFLAGS = -mcpu=$(MCU_SPEC) -mthumb -Wall --specs=nosys.specs -nostdlib -lgcc -T$(LSCRIPT)

AS_SRC = ./boot/startup_stm32f405xx.s
C_SRC = ./src/main.c

OBJS = $(AS_SRC:.s=.o) $(C_SRC:.c=.o)

.PHONY: all
all: $(TARGET).bin

%.o: %.s
  $(CC) -x assembler-with-cpp $(ASFLAGS) $< -o $@

%.o: %.c
  $(CC) -c $(CFLAGS) $(INCLUDE) $< -o $@

$(TARGET).elf: $(OBJS)
  $(CC) $^ $(LFLAGS) -o $@

$(TARGET).bin: $(TARGET).elf
  $(OC) -S -O binary $< $@
  $(OS) $<

.PHONY: clean
clean:
	rm -f $(OBJS)
	rm -f $(TARGET).elf
