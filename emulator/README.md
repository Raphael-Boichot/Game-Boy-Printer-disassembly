# Game Boy Printer firmware emulator

`gbprinter_emu.py` runs the real printer ROM (`../TMP87C840_Toshiba_printer_ROM.bin`) on an emulated Toshiba TMP87C840 (TLCS-870 CPU, 8 MHz) and lets a script talk to it like a Game Boy over the link cable. It was written to check `../Printer_protocol.md` against the firmware itself.

```python
from gbprinter_emu import Printer, Link, status_str
p = Printer(open('../TMP87C840_Toshiba_printer_ROM.bin', 'rb').read())
p.run_ms(1500)                      # power-on: RAM/SRAM test and the mechanism homing
L = Link(p)                         # 1.2 ms per byte, like a Game Boy at 8 kHz with a short gap
rx = L.packet(0x01)                 # Init; returns every byte the Game Boy reads
print(status_str(rx[-1]))           # 00[]
```

`python3 claims.py` runs 23 protocol checks (output in `claims_output.txt`; all match the reference). `python3 strobe_check.py` measures the head strobe widths for black, dark and light grey over a full picture (output in `strobe_output.txt`). Each takes a few minutes in pure Python.

## What is emulated

| Part | Model | Source |
|---|---|---|
| CPU | every TLCS-870 instruction the ROM uses, flags JF/ZF/CF/HF from Toshiba's instruction table; register banks in RAM at 0x40 + 8 × RBS | MAME `tlcs870` comments (instruction table), datasheet |
| Cycle timing | approximate: 1 machine cycle per byte fetched + 1 (1 machine cycle = 0.5 µs) | — |
| Interrupts | EIR / IL bit *b* → vector 0xFFE0 + 2 × (15 − *b*), lower bit = higher priority, PSW + PC pushed, IMF cleared, RETI sets it | MAME, datasheet |
| TC2 | main tick, TREG2 × fc/2¹³ (10.24 ms with TREG2 = 10; 1.0 s in idle) | datasheet p. 57 |
| TC4 | inter-byte timeout, TREG4 × fc/2¹¹ (5.12 ms) | datasheet p. 62 |
| TC1 | head strobe timer, TREG1A × fc/2³ (1 µs units) | datasheet p. 50 |
| TC3 | one-shot battery check during a strobe burst, ≈ fc/2⁷ | datasheet p. 59 (OCR) |
| SIO2 | 8-bit transmit/receive, external clock, shared buffer 0x0FF8–0x0FFF, LSB first (so both directions are bit-reversed), INTSIO2 after SIO2CR2 + 1 bytes | datasheet pp. 65–73 |
| ADC | instant; channel 0 = head temperature (default 0x80), channel 1 = battery (default 0xC0) | firmware use |
| Image SRAM | 8 KB on P3 (address low), P4 & 0x1F (address high), P7 (data); write on P2.1 rising edge with P2.2 low, read with P2.2 and P5.4 low | firmware routines A48F / A4A4 |
| Paper motor | P5.2 low = motor on; while on, an encoder pulse on INT3 every `enc_period_ms` (default 4 ms: one strobe burst, as measured on a real printer) | firmware: INT3 handler AAED, jam watchdog 8360; owner's scope |
| Cam / home sensor | P5.1 (INT4 on its rising edge) high for `cam_high` (8) out of every `cam_period` (40) encoder pulses | firmware: homing state 0x11 (B05F), watchdog 8532 |
| Front button | P2.0, `button=True` holds it | boot 809C |
| IDLE mode | SYSCR2 bit 4: the CPU waits for the next interrupt | datasheet |

## Assumptions that matter

* `enc_period_ms` = 4 ms matches the real printer: the emulated strobe widths at exposure 0x40 (`strobe_check.py`, output in `strobe_output.txt`) agree with the owner's scope (black 1.55 vs 1.56 ms, dark 1.20 vs 1.20 ms, light 0.86–0.95 vs 0.96 ms) with a head-temperature reading of 0x60 or less. `cam_period` and `cam_high` are guesses. The firmware needs them to be roughly right (the homing needs the cam sensor active for at least ~6 pulses; the watchdogs allow at most 12 ticks between encoder pulses, 13 ticks with the sensor active and 51 ticks with it inactive), but their real values are not known. Print durations, the number of pulses per band and the length of a margin unit (one cam revolution) therefore come from the model, not from the printer.
* The strobe lines (P0/P1) are logged, but how they map to dots on the head is not modelled, so the emulator does not draw the printed picture.
* Cycle counts are approximate. Protocol timing does not depend on them: the timeouts come from the timers, which are exact.
* The emulator runs only this ROM; unused peripherals (SIO1, TBT, watchdog) are ignored.
