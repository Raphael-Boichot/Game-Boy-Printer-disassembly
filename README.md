# Game-Boy-Printer-disassembly
Disassembly of the Game Boy Camera, TMP87C840 Toshiba ROM version. Work in progress

## Contents

| File | What it is |
|---|---|
| [`Printer_protocol.md`](Printer_protocol.md) | The Game Boy Printer protocol as the firmware implements it: packet format, commands, status bits, image memory and compression, print parameters, timeouts, self-test, emulator checklist |
| [`TMP87C840_printer_rom.asm`](TMP87C840_printer_rom.asm) | Full disassembly listing of the 32 KB ROM (TLCS-870 code traced from the interrupt vectors; data as `db`/`dw`) |
| [`tools/t870.py`](tools/t870.py) | TLCS-870 disassembler (written from MAME's `tlcs870d.cpp` opcode map) |
| [`tools/trace.py`](tools/trace.py) | Recursive tracer: `python3 tools/trace.py TMP87C840_Toshiba_printer_ROM.bin TMP87C840_printer_rom.asm ABA1` regenerates the listing |
| [`printer_test_image.png`](printer_test_image.png) | The built-in self-test image (ROM 0xDDEE-0xE06D, 160 x 16 px), drawn 4x |

The ROM itself (md5 `aa393ec87ccb4220200255ab5adf8ac9`) is not included.

All of this is AI work from static reading of the code, waiting for human validation.
