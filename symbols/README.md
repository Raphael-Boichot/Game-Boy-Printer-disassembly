# Symbol files

`tools/build_listing.py` reads these files and writes `../TMP87C840_printer_rom.asm`. Edit the CSVs, never the listing.

| File | Columns | Content |
|---|---|---|
| `sfr.csv` | addr, name, desc | special function registers 0x00–0x3F (names and meanings from the TMP87C840 datasheet; port bit meanings from the firmware) |
| `ram.csv` | addr, size, name, tag, desc | RAM variables and buffers (0x0040–0x043F) and the SIO2 buffer |
| `ram_bits.csv` | addr, bit, name, tag, desc | named flag bits; shown as a comment on every bit instruction |
| `rom_names.csv` | addr, name, tag, note | routines, labels, jump-table states and data tables |
| `rom_types.csv` | start, end, type, width, tag, note | data blocks: `words`, `bytes` (row width), `fill` |
| `roots.csv` | addr, reason | extra code entry points for the tracer |

Tags: **C** = code-traced, or reproduced by running the firmware in `../emulator/`; **I** = inferred; **?** = doubt (name is a placeholder).

The build stops on a duplicate name, a name that is not on an instruction or block start, a data block that overlaps traced code, a byte round trip that does not give the ROM back, or a reassembly of the listing text (`tools/t870asm.py`) that does not give md5 `aa393ec87ccb4220200255ab5adf8ac9`. Short branch targets inside routines keep automatic names (`Lxxxx`, `Jxxxx` for jump-table targets).

Board check: the owner's photos and the complete schematic and PCB of the IF-GBP-02 board ([RWeick/IF-GBP-02-Gameboy-Printer](https://github.com/RWeick/IF-GBP-02-Gameboy-Printer)) give every MCU pin's net; the pin descriptions in `sfr.csv` come from it. The firmware meaning of each signal is checked in the emulator. P5.3 is the only port bit whose effect is inferred: the firmware clears it on low battery (seen in the emulator) and after 27 encoder pulses while idle; on the schematic it drives the latch of the head supply, which also lights LED1.

## Names not yet tagged C (11)

| Kind | Address | Name | Tag | Note |
|---|---|---|---|---|
| ROM | 8609 | `Main_JobControl` | I | job end, copies, busy flag |
| ROM | 8E1C | `Line_NextColumnA` | I | same chain as Line_FirstColumn, unrolled, for the next column (strobe tables A) |
| ROM | 9829 | `Line_NextColumnB` | I | same chain for the strobe tables B |
| ROM | AAE6 | `Int_INT5_ButtonWake` | I | bare reti: the front button (P20 = INT5 pin) is enabled as an interrupt only to wake the CPU from IDLE |
| ROM | B369 | `Mech_StateInvalid` | I | states 0x19-0x1E |
| RAM | 00F7 | `IdleDelay` | I | tick counter before idle mode |
| bit | 0070.0 | `LineReady` | I | column data prepared |
| bit | 0070.1 | `LineFetch` | I | line buffer refill pending |
| bit | 00D9.1 | `LowBatHold` | I | withhold low battery from replies |
| bit | 00E0.2 | `DecodeStarted` | I | decoder initialised for the packet |
| bit | 00E1.6 | `InitDeferred` | I | init received during button feed |
