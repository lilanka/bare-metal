TARGET = main
MCU_SPEC  = cortex-m4

LD_SCRIPT = stm32f405xx.ld
LSCRIPT = ./boot/$(LD_SCRIPT)
AS_SRC   =  ./src/startup_stm32f405xx.s
C_SRC    =  ./src/main.c

# Toolchain definitions (ARM bare metal defaults)
TOOLCHAIN = /usr/local/gcc-arm-none-eabi-x86_64-linux/gcc-arm-none-eabi-10.3-2021.10
CC = $(TOOLCHAIN)/bin/arm-none-eabi-gcc
AS = $(TOOLCHAIN)/bin/arm-none-eabi-as
LD = $(TOOLCHAIN)/bin/arm-none-eabi-ld
OC = $(TOOLCHAIN)/bin/arm-none-eabi-objcopy
OD = $(TOOLCHAIN)/bin/arm-none-eabi-objdump
OS = $(TOOLCHAIN)/bin/arm-none-eabi-size

# Assembly flags
ASFLAGS += -c -O0 -mcpu=$(MCU_SPEC) -mthumb -Wall -fmessage-length=0
# C flags
CFLAGS += -mcpu=$(MCU_SPEC) -mthumb -Wall -g -fmessage-length=0 --specs=nosys.specs
# Linker flags
LFLAGS += -mcpu=$(MCU_SPEC) -mthumb -Wall --specs=nosys.specs -nostdlib -lgcc -T$(LSCRIPT)

INCLUDE  =  -I./
#INCLUDE  += -I./device_headers

OBJS  = $(AS_SRC:.s=.o) $(C_SRC:.c=.o)

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
	rm -f $(TARGET).bin

