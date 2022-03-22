_estack = 0x5FFFFFFF;

MEMORY
{
  flash (rx) : ORIGIN = 0x00000000, LENGTH = 1M 
  sram (rwx) : ORIGIN = 0x20000000, LENGTH = 192K 
}
