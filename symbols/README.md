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

Board check: the owner's photos and the complete schematic and PCB of the IF-GBP-02 board ([RWeick/IF-GBP-02-Gameboy-Printer](https://github.com/RWeick/IF-GBP-02-Gameboy-Printer)) give every MCU pin's net; the pin descriptions in `sfr.csv` come from it. The firmware meaning of each signal is checked in the emulator. P5.3 (power hold) is the only port bit whose effect is inferred: on the schematic it drives the supply that feeds the head and LED1, and the firmware only ever clears it.

## Names not yet tagged C (58)

| Kind | Address | Name | Tag | Note |
|---|---|---|---|---|
| ROM | 80A8 | `Boot_SettleDelay` | I | busy-wait before the first battery reading |
| ROM | 82B6 | `Main_CheckTempBattery` | I |  |
| ROM | 82BB | `Main_Wake` | I | back from idle: normal tick |
| ROM | 8379 | `Main_StartDelay` | I |  |
| ROM | 8505 | `Main_LowBattery` | I | low-battery handling |
| ROM | 8609 | `Main_JobControl` | I | job end, copies, busy flag |
| ROM | 8808 | `Line_PrepareBand` | I | extract and convert the next column for the strobe tables |
| ROM | 8D7A | `Main_LinePipeline` | I | line buffer refill / column preparation scheduling |
| ROM | 8E1C | `Line_BuildColumnA` | I | build strobe table A for the next column |
| ROM | 9829 | `Line_BuildColumnB` | I | build strobe table B for the next column |
| ROM | A45E | `Sub_PrimeLineBuf` | I | clear LineBuf and preload 0x120 bytes from SRAM |
| ROM | ABA3 | `Mech_State00_Idle` | I |  |
| ROM | B369 | `Mech_StateInvalid` | I | states 0x19-0x1E |
| ROM | B9C2 | `Line_CopyColumnSource` | I |  |
| ROM | BA51 | `Line_ExtractColumn` | I | one bit position of the source bytes = one pixel column |
| ROM | BB39 | `Line_ColumnDots` | I | combine the two bit planes into dot values (table 0xCCB6) |
| ROM | BBED | `Line_ColumnHeat` | I |  |
| ROM | BEB6 | `Tab_ColumnTabPtrs` | I | 4 pointers: 0xD476, 0xD576, 0xD676, 0xD776 (used at 8FC6, 8FF2, 901E) |
| ROM | CCB6 | `Tab_PlaneCombine` | ? | 64 bytes used by Line_ColumnDots |
| ROM | D076 | `Tab_ParamByTemp` | I | 256 bytes by temperature reading -> 0xF9 |
| ROM | D176 | `Tab_D176` | ? | used by Line_PrepareBand |
| ROM | D276 | `Tab_D276` | ? | used by Line_PrepareBand |
| ROM | D376 | `Tab_D376` | ? |  |
| ROM | D476 | `Tab_D476` | ? | via Tab_ColumnTabPtrs |
| ROM | D576 | `Tab_D576` | ? | via Tab_ColumnTabPtrs |
| ROM | D676 | `Tab_D676` | ? | via Tab_ColumnTabPtrs |
| ROM | D776 | `Tab_D776` | ? | via Tab_ColumnTabPtrs |
| ROM | D876 | `Tab_D876` | ? |  |
| ROM | DA76 | `Tab_DA76` | ? | indexed by an ADC reading |
| ROM | DB76 | `Tab_DB76` | ? |  |
| ROM | DB88 | `Tab_HeatCurveInk` | I | heat-compensation curve (column with dots) |
| ROM | DC69 | `Tab_DC69` | ? |  |
| ROM | DC7B | `Tab_HeatCurveBlank` | I | heat-compensation curve (blank column) |
| ROM | DD5C | `Tab_HeatTrim` | I | subtracted from the curve value (index 0x041E) |
| RAM | 0060 | `ColumnDots` | I | dot values of the column being prepared (copied from 0xB8-0xD6) |
| RAM | 0074 | `LineBufWr` | I | line buffer write pointer (0x0100-0x023F) |
| RAM | 0076 | `LineBufRd` | I | line buffer read pointer |
| RAM | 007E | `MarginBeforeLeft` | I | margin before: units left |
| RAM | 00E8 | `LowBatTimer` | I | low-battery reporting timer |
| RAM | 00F6 | `StartDelay` | I | tick counter before a job starts |
| RAM | 00F7 | `IdleDelay` | I | tick counter before idle mode |
| RAM | 00F8 | `BandColumns` | I | columns left in the band |
| RAM | 0100 | `LineBuf` | I | image bytes fetched from SRAM for printing (32-byte chunks) |
| RAM | 0240 | `ColumnSource` | I | bytes the current column is extracted from |
| RAM | 041B | `BattAtStart` | I | battery reading at job start |
| RAM | 041E | `BlankColumns` | I | count of blank columns |
| bit | 0070.0 | `LineReady` | I | column data prepared |
| bit | 0070.1 | `LineFetch` | I | line buffer refill pending |
| bit | 0071.2 | `TickRunning` | I | main tick configured for activity (not idle) |
| bit | 0071.6 | `LowBatSeen` | I | low battery detected |
| bit | 00D9.1 | `LowBatHold` | I | withhold low battery from replies |
| bit | 00D9.2 | `LowBatReported` | I | low battery has been reported |
| bit | 00DA.2 | `BlankLine` | I | column is blank |
| bit | 00E0.2 | `DecodeStarted` | I | decoder initialised for the packet |
| bit | 00E1.4 | `ReplyPending` | I | ? |
| bit | 00E1.5 | `BattCheckDue` | I | battery check under load pending |
| bit | 00E1.6 | `InitDeferred` | I | init received during button feed |
| bit | 00E1.7 | `BattSample` | I | take a battery sample at the next strobe burst |
