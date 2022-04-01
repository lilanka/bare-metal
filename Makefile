TARGET = main
MCU_SPEC  = cortex-m4

LD_SCRIPT = stm32f405xx.ld
LSCRIPT = ./boot/$(LD_SCRIPT)
AS_SRC   =  ./src/startup_stm32f405xx.s
C_SRC    =  ./src/main.c

# Assembly flags
ASFLAGS += -c -O0 -mcpu=$(MCU_SPEC) -mthumb -Wall -fmessage-length=0
# C flags
CFLAGS += -mcpu=$(MCU_SPEC) -mthumb -Wall -g -fmessage-length=0 --specs=nosys.specs
# Linker flags
LFLAGS += -mcpu=$(MCU_SPEC) -mthumb -Wall --specs=nosys.specs -nostdlib -lgcc -T$(LSCRIPT)

INCLUDE  += -I./headers
OBJS  = $(AS_SRC:.s=.o) $(C_SRC:.c=.o)

.PHONY: all
all: $(TARGET).bin

%.o: %.s
	arm-none-eabi-gcc -x assembler-with-cpp $(ASFLAGS) $< -o $@

%.o: %.c
	arm-none-eabi-gcc -c $(CFLAGS) $(INCLUDE) $< -o $@

$(TARGET).elf: $(OBJS)
	arm-none-eabi-gcc $^ $(LFLAGS) -o $@

$(TARGET).bin: $(TARGET).elf
	arm-none-eabi-objcopy -S -O binary $< $@
	arm-none-eabi-size $<

clean:
	rm -f $(OBJS)
	rm -f $(TARGET).elf
	rm -f $(TARGET).bin

.PHONY: clean
