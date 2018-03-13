/*-Specials-*/
define symbol __ICFEDIT_intvec_start__ = 0x00002000;
/*-Memory Regions-*/
define symbol __ICFEDIT_region_ROM_start__   = 0x00002000;
define symbol __ICFEDIT_region_ROM_end__     = 0x0001FFFF;
define symbol __ICFEDIT_region_RAM_start__   = 0x20000000;
define symbol __ICFEDIT_region_RAM_end__     = 0x20003FFF;
/*-Sizes-*/
define symbol __ICFEDIT_size_cstack__   = 0x400;
define symbol __ICFEDIT_size_heap__     = 0x800;
/**** End of ICF editor section. ###ICF###*/


define memory mem with size = 4G;
define region ROM_region   = mem:[from __ICFEDIT_region_ROM_start__   to __ICFEDIT_region_ROM_end__];
define region RAM_region   = mem:[from __ICFEDIT_region_RAM_start__   to __ICFEDIT_region_RAM_end__];

define block CSTACK    with alignment = 8, size = __ICFEDIT_size_cstack__   { };
define block HEAP      with alignment = 8, size = __ICFEDIT_size_heap__     { };

initialize by copy { readwrite };
//initialize by copy with packing = none { section __DLIB_PERTHREAD }; // Required in a multi-threaded application
do not initialize  { section .noinit };

place at address mem:__ICFEDIT_intvec_start__ { readonly section .intvec };

place in ROM_region   { readonly };
place in RAM_region   { readwrite,
                        block CSTACK, block HEAP };

