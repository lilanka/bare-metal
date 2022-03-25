ENTRY(reset_handler)

_estack = 0x5FFFFFFF; 
_Min_Leftover_RAM = 0x400;

MEMORY
{
  flash (rx) : ORIGIN = 0x00000000, LENGTH = 1M 
  sram (rwx) : ORIGIN = 0x20000000, LENGTH = 192K 
}

SECTIONS
{
  .vector_table :
  {
    . = ALIGN(4);
    KEEP (*(.vector_table))
    . = ALIGN(4);
  } >flash

  .text :
  {
    . = ALIGN(4);
    *(.text)
    *(.text*)
    . = ALIGN(4);
  } >flash

  .rodata :
  {
    . = ALIGN(4);
    *(.rodata)
    *(.rodata*)
    . = ALIGN(4);
  } >flash

  _sidata = .;
  .data : AT(_sidata) 
  {
    . = ALIGN(4);
    _sdata = .;
    *(.data)
    *(.data*)
    _edata = .;
    . = ALIGN(4);
  } >sram

  .bss :
  {
    . = ALIGN(4);
    _sbss = .;
    *(.bss)
    *(.bss*)
    *(COMMON)
    . = ALIGN(4);
    _ebss = .;
  } >sram

  .dynamic_allocations :
  {
    . = ALIGN(4);
    _ssystem_ram = .;
    . = . + _Min_Leftover_RAM;
    . = ALIGN(4);
    _esystem_ram = .;
  } >sram
}
