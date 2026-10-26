# Editable source

`main.asm` includes every module in address order. Build with `make` (writes `build/printer.bin`), and check with `make check`, which must print the ROM md5 `aa393ec87ccb4220200255ab5adf8ac9`.

| File | Content |
|---|---|
| `hardware.inc` | special function registers (`equ`) |
| `ram.inc` | RAM variables and flag bits (`equ`, with the bit names as comments) |
| `reset.asm` | reset: ports, RAM clear, SRAM test, timers, serial port, battery check, self-test request |
| `main_loop.asm` | main loop: idle, tick work, watchdogs, command handlers, job start |
| `line_pipeline.asm` | first column, column preparation for strobe tables A / B, line buffer refill |
| `data_decoder.asm` | data decoder, temperature / battery check, SRAM access, RLE, SRAM layout table |
| `interrupts_mech.asm` | strobe timer, battery check under load, button / cam / encoder interrupts, mechanism states |
| `receiver.asm` | main tick, serial packet receiver (coroutine), inter-byte timeout |
| `column.asm` | column extraction, history, energy codes, strobe-table writers |
| `tables.asm` | head energy and timing tables |
| `selftest.asm` | SRAM test and the self-test image |
| `vectors.asm` | unused interrupt handlers and the interrupt vectors at `org $FFE0` |
| `data/*.bin`, `data/selftest_band.2bpp` | large tables and the self-test image (`incbin`) |

Syntax (`tools/t870asm.py`):
- **instructions:** as printed by `tools/t870.py`, for example `ld (Status),$00` or `jrs T,L80AB`;
- **labels:** `Name:`;
- **directives:** `org $XXXX`, `NAME equ $XX`, `db $XX, ...` (also `$XX xN`), `dw value/label, ...`, `ds N,$XX`, `include "file"`, `incbin "file"`;
- **expressions:** `Label+n` / `Label-n`;
- **comments:** start with `;`.

Every reference to a ROM address is a label: jumps, calls, jump tables, table pointers, tick curves and the vectors. So code can be inserted or removed. Gaps up to `org $FFE0` are filled with `$FF`, and the build stops if the code grows past the vectors. `emulator/relocation_test.py` checks this: it inserts code in three modules, rebuilds, and runs a print job in the emulator. The moved ROM differs in about 21,500 bytes but behaves the same.

`src/` was written by `tools/make_source.py` from the annotated listing. Running `make source` regenerates it from `symbols/` and overwrites any hand edits.
