# Game Boy Printer firmware: protocol reference

*Reverse-engineered from the printer's mask ROM (Toshiba TMP87C840, 32 KB, `TMP87C840_Toshiba_printer_ROM.bin`, md5 `aa393ec87ccb4220200255ab5adf8ac9`). 2026-10-25. AI work waiting for human validation: written from static reading of the code, then checked by running this ROM in a TLCS-870 emulator (`emulator/`, section 14); nothing has been tested on a real printer yet.*

Evidence tags as in the [Game Boy Camera disassembly](https://github.com/Raphael-Boichot/Game-Boy-Camera-disassembly): **C** = code-traced (read in straight-line code) or reproduced by running the firmware in the emulator, **I** = inferred, **?** = inconclusive. Section 12 gives the tag of each group of findings; section 14 lists what the emulator reproduced.

This document derives the Game Boy Printer protocol from the printer's own firmware. It confirms the documented protocol and adds the edge cases an accurate emulator (for example a BGB print interceptor) needs. All addresses are CPU addresses in the ROM (0x8000–0xFFFF) unless they are below 0x1000, which are RAM or registers.

Behaviours not described in the usual community documentation are marked **[new]**.

---

## 1. At a glance

| Topic | Firmware behaviour | Where |
|---|---|---|
| Sync | `88 33`. A bad first byte puts the printer in "reply 0xFF" mode until the line goes quiet, and **posts an Init if the printer is idle** **[new]** | B38A, B3BF |
| Header | command, compression flag, 16-bit little-endian length | B3E2–B4C2 |
| Checksum | 16-bit sum of command, compression, both length bytes and every payload byte, sent little-endian | accumulator at 0x414 |
| Reply | `0x81` then the status byte, in the two byte slots after the checksum | B691 |
| Commands | 0x01 init, 0x02 print, 0x04 data, 0x08 break (stops printing) **[new detail]**, 0x0F status; any other value is acknowledged and ignored | B4DA–B77B |
| Payload limit | length must be < 0x400 (1024) | B510, B76A |
| Compression | flag must be 0 or 1. RLE: control byte < 0x80 → c+1 literal bytes; ≥ 0x80 → next byte repeated (c − 0x80) + 2 times | B576, A4DF |
| Image memory | 9 slots × 640 bytes = 0x1680 bytes, in external SRAM | A36F |
| Status bits | 0x01 checksum, 0x02 busy, 0x04 image data full (= end-of-data received), 0x08 unprocessed data, 0x10 packet error, 0x20 paper jam, 0x40 other error, 0x80 low battery | register 0x7C, stored bit-reversed |
| Checksum flag lag **[new]** | the status byte is built **before** the checksum is compared, so bit 0x01 describes the **previous** packet | B62F vs B67C |
| Print preconditions **[new]** | Print needs an empty data packet first and at least 4 argument bytes; otherwise packet error and nothing prints | B74F |
| Palette 0x00 **[new]** | means "no remapping", identical to 0xE4 | 8EC8 |
| Inter-byte timeout **[new]** | hardware timer TC4 restarted on every byte; if it expires mid-packet, the packet is aborted and its data rolled back | vector FFEA → B99E |
| Idle reset **[new]** | 12–13 main-loop ticks (≈125–133 ms at 8 MHz) with no byte while not printing clear memory and status, as an Init would | 82DC |
| Inter-byte limit **[new]** | 20 × 2048 / fc = 5.12 ms (8 MHz crystal) | TC4 |
| Power-on lockout **[new]** | until the mechanism has finished its start-up sequence, every packet is answered 0xFF | B399 |

---

## 2. Firmware and hardware

The printer runs a **Toshiba TLCS-870** 8-bit microcontroller, not a Z80/SM83. The 32 KB ROM is mapped at 0x8000–0xFFFF; reset vector 0xFFFE → 0x8000. Code and data end at 0xE070; the rest (8,079 bytes) is 0xFF fill. Register names come from MAME's TMP87PH40AN model, the one-time-programmable version of the same chip; the Toshiba datasheet (`TMP87C840_Toshiba.pdf`) was not used and is the reference to check them against.

Boot (0x8000): `di`, `ld SP,$043F`, watchdog disabled by writing 0xB1 to WDTCR2 (0x35), ports configured, RAM 0x0048–0x043F cleared, SRAM test, timers and SIO2 configured, ADC battery check, then the main loop at 0x80D5.

| Resource | Address | Use |
|---|---|---|
| SFRs | 0x00–0x3F | ports, timers, ADC, SIO, interrupt control |
| Internal RAM | 0x0040–0x043F | variables, register banks; stack top 0x043F |
| Line buffer | 0x0100–0x023F | image data being printed (filled from SRAM in 32-byte chunks) |
| Packet header copy | 0x03EC–0x03EF | command, compression, length lo, length hi |
| Print arguments | 0x03F0–0x03F3 | first 4 payload bytes of non-data packets |
| Receive ring buffer | 0x03F4–0x0413 | 32 bytes; write pointer 0xDC, read pointer 0xDE |
| Checksum / byte counter | 0x0414 / 0x0416 | running 16-bit sum, payload bytes left |
| Status register | 0x007C | internal, bit-reversed status byte |
| SIO2 buffer | 0x0FF8–0x0FFF | Game Boy link (receive and transmit) |
| External image SRAM | IC3 (LH5164 / LC3564, 8K x 8): P3 = A0–A7, P4.0–4.4 = A8–A12, P7 = D0–D7, P2.1 /WE, P2.2 /CE1, P5.4 /OE | 0x1680 bytes used. Read routine A48F, write routine A4A4 |
| ADC channel 0 | ADCCR 0x0E = 0x00, result 0x0F | thermistor TH1 on P60 (to GND, 10 kΩ pull-up): outside 0x35–0xD7 → "other error" (0x40); indexes the heat-time tables (colder = higher reading = longer strobes) |
| ADC channel 1 | ADCCR 0x0E = 0x01 | battery through the divider R26/R27 on P61; ≤ 0x7E → "low battery" |
| Port P2 bit 0 | 0x02 bit 0 | front button SW1 (P20, also the INT5 pin: wakes the CPU from idle) |
| Port P5 | 0x05 | bit0 encoder (CN1 pin 3 through Q10, INT3); bit1 cam sensor (CN1 pin 5, INT4); bit2 motor (Q6–Q9 drive CN1 pin 2: 0 = run, 1 = brake); bit3 power hold (supply of the head and LED1; cleared after long idle and on low battery: inferred) |
| Ports P0/P1 | 0x00/0x01 (QFP pins 3–18) | the 16 head strobe lines, one per band row, written from tables by the TC1 interrupt; P00–P07 → TD62593A IC6 → head connector CN2 pins 18–11, P10–P17 → IC5 → CN2 pins 10–3; CN2 pins 1–2 = head supply |

### Interrupt vectors

| Vector | Source | Handler | Role |
|---|---|---|---|
| FFFE | Reset | 8000 | boot, self tests, main loop |
| FFE4 | SIO2 | B373 | packet receiver (coroutine) |
| FFEA | TC4 (8-bit timer) | B99E | inter-byte timeout: aborts the current packet |
| FFE2 | TC2 (16-bit timer) | B370 | main-loop tick (sets flag E0.7) |
| FFF6 | TC1 (16-bit timer) | AA7E | head strobe / stepper output from tables |
| FFEE | TC3 (8-bit timer) | AAC0 | head-energy timing (reads ADC) |
| FFE6 / FFE8 | INT4 / INT3 | AAE7 / AAED | mechanism inputs (probably paper/position sensors) |
| FFE0 | INT5 | AAE6 | `reti` |
| others | — | E06E / E06F | `reti` / `retn` |

The CALLV vector table (0xFFC0–0xFFDF) is unused (all 0xFF).

### The receiver is a coroutine

The SIO2 interrupt handler (B373) switches to register bank 3, then:

- If flag `D9.0` is clear, it starts a new packet (B38A).
- If it is set, it jumps to the address saved in 0xD7.

Whenever the receiver needs the next byte it calls B9B4. That routine sets `D9.0`, pops its own return address into 0xD7 and executes `reti`. The whole packet parser is therefore written as straight-line code that "waits" for bytes without ever blocking the main loop.

---

## 3. Link layer

The printer is the clocked side (the Game Boy drives the clock), and its serial port shifts least-significant bit first. The Game Boy shifts most-significant bit first, so:

- **Received bytes are bit-reversed in software.** Every byte goes through an 8-step `shrc A` / `rolc W` loop. That is why the code compares against 0x11 and 0xCC, which are 0x88 and 0x33 reversed.
- **Transmitted bytes are not reversed.** The firmware keeps its status register (0x7C) already in reversed order: internal bit *k* = protocol bit *7−k*. `0x81` is the same in both orders.
- **Ordinary bytes:** after reading each byte the firmware writes 0x00 into the buffer, so the Game Boy reads 0x00 for every byte except the two reply slots (and 0xFF in sync-loss mode).
- **Reply timing:** right after the second checksum byte arrives, the firmware puts `0x81` and the status byte in a 2-byte transmit queue (SIO2CR1 0x22 = 0x67, SIO2CR2 0x23 = 0x01, 0x22 = 0xA7). They go out in the next two byte exchanges; the queue is then reset to one byte (0x23 = 0x00).
- **Inter-byte timeout:** timer TC4 (reload 0x14) is stopped and restarted (TC4CR 0x1C = 0xC0, then 0xD0) after every byte. If it expires, handler B99E:
  - clears the coroutine flag, so the next byte must be a fresh 0x88;
  - resets the transmit queue;
  - sets `DA.7`, so a data packet in progress is rolled back;
  - clears `D9.7` ("packet in progress").

  With TC4CR = 0xD0 (clock fc/2¹¹) and the 8 MHz crystal this is 20 × 256 µs = **5.12 ms**; the emulator accepts a 5.1 ms gap and aborts above it.
- **Activity counter:** every byte reloads the counter at 0x041C with 0xF3. The main loop increments it once per tick while the printer is **not** busy; when it wraps to 0 (13 ticks of silence; one tick = TREG2 10 × fc/2¹³ = 10.24 ms, so ≈125–133 ms) the receive state is reset (section 9). Every byte counts as activity, so a Game Boy that keeps polling status never triggers it.

---

## 4. Packet format

| # | Game Boy sends | Printer returns | Firmware handling |
|---|---|---|---|
| 0 | 0x88 | 0x00 | anything else → sync-loss mode (section 9) |
| 1 | 0x33 | 0x00 | anything else → reply 0xFF once, packet dropped |
| 2 | command | 0x00 | stored at 0x3EC; checksum starts here |
| 3 | compression (0/1) | 0x00 | 0x3ED; summed |
| 4 | length low | 0x00 | 0x3EE; summed |
| 5 | length high | 0x00 | 0x3EF; summed |
| 6 … 5+n | payload | 0x00 | data → ring buffer; other commands → first 4 bytes to 0x3F0–0x3F3, rest only summed |
| 6+n | checksum low | 0x00 | subtracted from the sum |
| 7+n | checksum high | 0x00 | compared; the reply has already been prepared |
| 8+n | 0x00 | **0x81** | "printer present" |
| 9+n | 0x00 | **status** | the 0x7C value from before the checksum compare (masks in section 6) |

Checksum rules:

- 16-bit sum of bytes 2…5+n, compared against the little-endian value in bytes 6+n and 7+n.
- The checksum covers the header and payload even when the payload is discarded (busy, oversized, unknown command).
- On a mismatch, `7C.7` (status 0x01) is set **after** the reply is prepared, so the Game Boy sees it in the **next** reply.
- A bad checksum on any command other than 0x02 or 0x08 also clears "image data full" (0x04).
- A bad checksum (or packet error) on a data packet rolls back the stored data (section 7). The rollback uses the current packet's result, not the lagged one.

---

## 5. Commands

The receiver validates the command while the packet arrives, sends the reply, and only then posts a request to the main loop (flags `DB.7` init, `DB.6` print, `DB.5` break, `DB.4` status). A request is posted only if the checksum flag (as of the previous packet) is clear and the current packet raised no packet error. Every command except 0x0F starts by clearing the packet-error flag (`DA.0`).

| Cmd | Name | Accepted when | Effect | Rejected when |
|---|---|---|---|---|
| 0x01 | Init | not printing | clears image memory and pointers, "image data full", "unprocessed data" (unless jammed), packet error, break flag, copy count | while printing: payload dropped, **"unprocessed data" (0x08) set** in that reply, no init |
| 0x02 | Print | not printing, empty data packet already received, length ≥ 4 | main loop takes the 4 arguments (section 8) and starts; clears "unprocessed data" | no end-of-data packet, or length < 4 → packet error; while printing → ignored |
| 0x04 | Data (len > 0) | not printing, no end-of-data yet, compression 0/1, length < 0x400, no break pending | payload streamed into image memory | after end-of-data, compression > 1, after a break → packet error; while printing → ignored |
| 0x04 | Data (len = 0) | compression = 0, first one since init | sets "image data full" (0x04) = end of data; enables Print | a second empty packet, or compression ≠ 0 → packet error |
| 0x08 | Break | always | if printing: stops the job, clears busy and "unprocessed data"; blocks further data packets until the next Init | length ≥ 0x400 → packet error |
| 0x0F | Status / NUL | always | reply only; if not printing and not jammed, also clears "unprocessed data" | length ≥ 0x400 → packet error |
| other | — | — | checksummed and acknowledged with a normal reply; nothing else happens | — |

Notes:

- Commands 0x01, 0x08, 0x0F and unknown commands may carry a payload; up to 4 bytes are kept and the rest only summed.
- **Data after a print, without Init:** the Print command sets flag `E1.0`. The next data packet then either:
  - starts a new image automatically (memory pointers reset), if nothing is unprocessed; or
  - is abandoned before its first payload byte (reply 0xFF; the remaining bytes then hit sync-loss mode), if "unprocessed data" is set.
- **Oversized data (length ≥ 0x400):** uncompressed → packet error and payload discarded; compressed → payload silently discarded, no error flag.

---

## 6. Status byte

The status byte is the internal register 0x7C sent without reversal, so its bits arrive mirrored. The battery check proves it: a battery ADC reading ≤ 0x7E sets internal bit 0, which the Game Boy sees as **0x80 Low battery**. The checksum compare sets internal bit 7, which is **0x01 Checksum error**.

| Protocol bit | Internal | Meaning | Set by | Cleared by |
|---|---|---|---|---|
| 0x01 | 7C.7 | checksum error | checksum mismatch (seen in the **next** reply) | next packet with a good checksum |
| 0x02 | 7C.6 | busy / printing | print, feed or feed-button start (868A, 86C0, 86D9, 8D6B) | end of job, break, jam abort |
| 0x04 | 7C.5 | image data full | empty data packet | init, idle reset, bad checksum on a non-print/break packet, jam abort |
| 0x08 | 7C.4 | unprocessed data | data committed to memory (A39B); init while printing; jam abort | print accepted, init, status poll while idle, end of print (none of these while jammed) |
| 0x10 | 7C.3 | packet error | current packet broke a rule (copied from `DA.0` just before the reply) | next non-status packet |
| 0x20 | 7C.2 | paper jam | mechanism timeout during printing/feeding (8368, 8553) | never: sticky until power-off |
| 0x40 | 7C.1 | other error | SRAM test failure at boot; head temperature ADC outside 0x35–0xD7 | never: sticky |
| 0x80 | 7C.0 | low battery | battery ADC ≤ 0x7E during operation (a low battery at power-on instead leaves the printer locked out, answering 0xFF: section 9) | never: sticky |

Masks applied while building the reply (B62F–B646):

- The reply to the empty data packet hides 0x04 (flag `71.1`) until the next status poll clears that flag.
- The reply to an accepted data packet never shows 0x02.
- Low battery (0x80) is withheld while flag `D9.1` is set (a reporting delay after detection).

A jam abort (paper not detected in time) sets 0x20 and 0x08, clears 0x04 and 0x02, and returns the mechanism state machine to idle.

### Typical sequence (observed by running the firmware)

| Packet | Reply status | Why |
|---|---|---|
| Init | 0x00 | clean state |
| Data #1 | 0x00 | the main loop commits the data after the reply |
| Data #2…#n | 0x08 | earlier data now unprocessed |
| Empty data | 0x08 | 0x04 masked in this reply |
| Print | 0x08 | 0x04 is still masked (flag `71.1` is cleared only by a status poll); printing starts after the reply |
| Status, < 26 ms after Print | 0x04 | busy is set 26 ms after the Print command |
| Status (printing) | 0x06 | busy + full |
| Status (done) | 0x04 | busy cleared; full stays until init or idle reset |

---

## 7. Image memory and compression

The serial interrupt only fills the 32-byte ring buffer. The main loop (A2ED–A406) decodes it into external SRAM through the RLE decoder at A4C0.

- **Slots.** Memory is filled 640 bytes (one 160×16 band) at a time: slot base in 0xE2, offset in 0xE4, total valid bytes in 0x85. At 0x1680 (9 slots) the memory is full: flag `71.0` is set and later data packets are no longer decoded (their bytes are left in the ring buffer and overwritten). Their replies still look normal. "Image data full" (0x04) is **not** set by this; only the empty data packet sets it.
- **Uncompressed packets** are appended byte for byte. The slot advances every 640 bytes, so a long packet spills into the next slot. A short packet is **not** padded: the next packet continues at the same offset.
- **Compressed packets** use the RLE scheme below, which matches the community documentation:
  - control byte `c` < 0x80 → copy the next `c + 1` bytes;
  - control byte `c` ≥ 0x80 → repeat the next byte `c − 0x7E` times (= (c & 0x7F) + 2).
- **Compression quirks [new]:**
  - The run state is reset whenever a slot fills, so a run that crosses a 640-byte boundary is cut short.
  - At the end of a compressed packet, the rest of the current slot is padded with 0x00 up to 640 bytes, so every compressed packet occupies whole slots.
  - The compression flag is sampled per packet.
- **Rollback.** At the start of each data packet the pointers (0xE2, 0x85, 0xE4) are saved (to 0xEA/0xEC/0xEE). They are restored, discarding the packet, if:
  - the packet had a checksum error or packet error (`7C & 0x88` → `DA.7`);
  - it arrived while printing;
  - the inter-byte timeout fired.
- **"Unprocessed data" (0x08)** is set when a packet's data has been fully committed, which happens after its reply.
- **No overflow check on the ring buffer.** The decoder must keep up with the link, which it does at Game Boy speeds.
- **Printing** reads SRAM from 0x83 up to 0x85 in 32-byte chunks into the line buffer at 0x0100–0x023F.

---

## 8. Print parameters (the 4 payload bytes of command 0x02)

Parsed by the main loop at 85AB. A print request is silently dropped if a print is already running (`E1.1`/`E1.2`) or a data packet is still being decoded (`E0.1`).

| Byte | Meaning | Firmware handling |
|---|---|---|
| 0 | number of sheets / copies | stored at 0xE9. **0 → feed only** (also when no image data is stored). Non-zero values are decremented by the print state machine (B21A, B283, B35E), which repeats the job while the count is non-zero |
| 1 | margins | high nibble → feed before printing (0x7D, state 0x14); low nibble → feed after printing (0x7F → 0x80). In the feed-only case the low nibble is the feed amount (0x81; 0 → no feed). Units are the mechanism's feed steps |
| 2 | palette | 0x00 → no remapping (same as 0xE4). Otherwise a 2-bit pixel value *v* prints as `(palette >> 2v) & 3`, so pixel 3 → bits 7–6, pixel 0 → bits 1–0 (8EC8) |
| 3 | exposure (darkness) | values > 0x7F are replaced by 0x40. See below |

### Exposure → head on-time

The exposure byte sets how long the head's heating dots stay on while the paper slides past. Exposure indexes a 128-entry table at **0xCFF6** that gives a signed offset:

| Exposure | Offset |
|---|---|
| 0x00–0x06 | −16 |
| … (steps of one every 7–8 values) | … |
| 0x40 (default) | −7 |
| 0x70–0x77 | 0 |
| 0x78–0x7F | +1 |

When the job starts (871D), the firmware reads the head temperature on ADC channel 0 and computes:

- the base on-time from the 256-entry table at **0xCEF6** (by temperature);
- heat time `0x78` = base + exposure offset;
- a second timing value from the table at **0xD076** (by temperature) → 0xF9.

A temperature reading outside 0x35–0xD7 aborts with "other error" instead. Hotter heads get shorter pulses; the exposure byte only shifts that curve.

How the head is driven (from the code, reproduced in the emulator, timing checked against the owner's scope on a real printer):

- Each encoder pulse (INT3) starts one strobe **burst**: 33 ticks of timer TC1, each `TREG1A` µs long (about 95–103 µs at exposure 0x40). On every tick the TC1 handler writes the next pair of bytes from two RAM tables (0x0360/0x0383 or 0x03A6/0x03C9, used alternately) to ports P0 and P1. The 16 port lines stay on for as many ticks as the dot's grey level needs.
- A 640-byte band (16 pixel rows) takes **160 bursts, one per pixel column**. The 16 strobe lines are the band's 16 rows (P0.0 = row 0 … P1.7 = row 15), so each burst prints one 16-dot column and the head sweeps across the 160 columns. In the emulator a black top row lights line P0.0 in all 160 bursts, and a black left column lights all 16 lines in burst 0 only. Bursts are 4.00 ms apart (one pixel column = 4 ms, as on the real printer), and a full 9-band picture takes about 9.9 s. The mechanism states 0x01–0x10 are the column states (16 per cycle, 10 cycles per band); 0x12 starts a band and 0x13 moves to the next one.
- On-time per burst at exposure 0x40, middle of a full picture (emulator, head-temperature reading ≤ 0x60):

  | Level | Emulator | Real printer (owner's scope) |
  |---|---|---|
  | Black | 1.55 ms | 1.56 ms |
  | Dark grey | 1.20 ms | 1.20 ms |
  | Light grey | 0.86–0.95 ms | 0.96 ms |

  With a reading of 0x80 the emulator gives 1.81 / 1.38 / 1.03 ms.
- **Heat compensation [new]:** the on-time is not constant. The first burst of a job is about twice as long (2.99 ms for black). The on-time then steps down every 16 bursts as the head warms (1.85, 1.84, 1.80, 1.76 … ms), rises slightly towards the end, and the last line is the shortest (1.46 ms for black). The step comes from the table read at AB45, indexed by the line counter 0x72.
- White dots get only very short pulses (0.02–0.15 ms).
### Head energy model (L6)

Each dot gets its own on-window inside the 33-tick burst. The window is computed per column (`Line_FirstColumn`, `Line_NextColumnA/B`, `Line_Column*`) in four stages:

1. **Pixels.** `Line_CopyColumnSource` copies the 32 bytes of the tile column being printed (2 stacked tiles, 16 rows, 2 bit-planes). `Line_ExtractColumn` takes pixel x (`TileColumnX`, 0–7) of each row and applies the palette, giving 16 dot values 0–3 (`ColumnPixels`).
2. **History.** `Line_ColumnHistory` keeps, per row, the previous dot and the current dot (`RowHistory` = prev × 16 + cur) and looks up an energy code in `Tab_EnergyByHistory` (0xCCB6):

   | Previous \ current | 0 | 1 | 2 | 3 |
   |---|---|---|---|---|
   | 0 | 0 | 0x3B | 0x52 | 0x6B |
   | 1 | 0 | 0x29 | 0x45 | 0x65 |
   | 2 | 0 | 0x25 | 0x36 | 0x60 |
   | 3 | 0 | 0x21 | 0x2B | 0x4A |

   A dot that was already hot gets less energy.
3. **Heat of each element.** `RowHeat` (16 words, 8.8 fixed point) models the temperature of each of the 16 head elements:
   - per column, a printed dot adds `Tab_HeatAddByCode[code]` (0xD176), or `Tab_HeatAddFreshByTemp` (0xD276) when it follows a white dot;
   - a white dot changes it by `Tab_IdleCoolByTemp` (0xD076, usually a decrease);
   - every 10.24 ms tick multiplies it by `Tab_DecayByTemp[t]` / 256 (0xDA76);
   - every band change subtracts `Tab_BandCoolByTemp[t]` (0xD876).

   All of these depend on the temperature reading (TH1).
4. **Code and window.** `Line_ColumnEnergy`: code = `HeatTime` + `Tab_HeatCorr<grey>[RowHeatInt]` (one 256-byte table per grey level, 0xD476–0xD776) + history code, clamped to 0–0x64. `Tab_DotTicks` (0xCCF6) turns the code into a first tick and a tick count. Higher codes start earlier and last longer, so every dot's window ends at about the same tick. Even white dots can get a short window from their correction table, which gives the 0.02–0.15 ms pulses seen on white.

The tick length itself (`TREG1A`, µs) = `Tab_TickCurves*[BandIndex][step]` − `Tab_TickTrimBySoak[HeatSoak]`:
- 9 bands × 25 steps;
- a warm set (0xDB88) and a cold set (0xDC7B), the cold set used when every `RowHeat` is zero;
- the trim grows with the number of bands printed since the head was last cold (0–40).

**Battery under load:** at the first burst of a job, TC1 reads the battery while the head draws current. Low battery is raised at ≤ 0x7E, or at ≤ 0x9C if the reading sagged 8 or more below the idle reading taken at job start (`BattAtStart`).


---

## 9. Errors and timeouts

**Sync loss (bad first byte).** If the first byte of a packet is not 0x88, or flag `DA.4` is set, the receiver (B3BF):

1. posts an **Init request if the printer is not printing** **[new]**, so line noise while idle wipes the buffer;
2. replies **0xFF** to that byte and to every following byte;
3. if printing, sets `DA.4`, so every later packet until the job ends is also treated as garbage;
4. stays in this loop until the TC4 inter-byte timeout fires (a gap on the line).

**Bad second byte.** If the second byte is not 0x33, the printer replies 0xFF once and drops the packet, with no Init.

**Power-on lockout.** Flag `71.5` is set at boot and cleared by the mechanism state machine (B0E7, B31F). Until then, every 0x88 is answered with 0xFF and the packet is dropped (unless a paper jam is already flagged).

**Inter-byte timeout.** Section 3: aborts the packet, rolls back data, clears the reply queue.

**Idle reset.** When the 0x041C counter wraps (13 ticks of silence while not busy), the main loop (82E8) clears:

- break flag, packet error, memory-full flag, "image data full";
- decoder state;
- "unprocessed data" (unless jammed);
- copy count, memory pointers and ring buffer.

This is effectively an Init. So a sender must not pause too long between the last data packet and Print. After a job ends, the status also falls back to 0x00 by itself.

**Idle and serial watchdog.** The printer enters IDLE mode (1 s tick) 133 ms after the last byte when nothing is pending, and the front button or a serial byte wakes it (emulator). If no packet is in progress and the serial port has been quiet for about 123 ms, the firmware re-arms SIO2 in 1-byte mode (`Main_Tick`, `JobFlags.SioRearm`). The firmware has no timed power-off: nothing changes in 4 minutes of idle in the emulator.

**Supply cut (P5.3).** P5.3 is cleared, and never set again, when low battery is detected, and in the idle state after 27 encoder pulses with no job (paper pulled by hand). On the schematic it drives the latch of the head supply, which also lights LED1, so this probably cuts the head supply until the printer is switched off (inferred: the emulator does not model the supply).

**Paper jam.** During printing or feeding, a timer (0xF3/0xF4) counts down while waiting for the mechanism; on expiry the motor stops, the jam abort described in section 6 happens, and the state machine returns to 0.

**Head temperature / battery.** Checked at boot (battery), before each job (both) and periodically (A409). Out-of-range temperature → 0x40 (sticky). Low battery during operation → 0x80 (sticky) and the print is aborted: the emulator shows 0x06 → 0x86 → 0x84. **At power-on [new]**, a low battery or an out-of-range head temperature stops the start-up homing from running, so the power-on lockout is never lifted: the printer then answers **0xFF** to every packet and never reports 0x80 or 0x40 (a paper-jam flag is the only error that bypasses the lockout, B396).

---

## 10. Built-in self-test

- **Trigger:** at power-on the boot code (809C) reads P2.0 twice; if it is low both times (front button held), it sets 0xF5 = 1 and calls DDAD. The start-up homing (state 0x11, B05F) clears 0xF5 at any encoder pulse where the button is released, so the button must be held **until the motor stops** (about 1.2 s after power-on in the emulator); releasing it earlier cancels the test.
- **Image:** DDAD copies the **640-byte image at 0xDDEE–0xE06D** (standard Game Boy 2bpp tiles, 20 × 2 tiles = 160 × 16 px) into SRAM, as if one data packet had been received (0x85 = 0x280). The test print uses an after-margin of 3 (AFB7, state 0x15).
- **Content:** a speckled border, a Mario head, a "Hello!" banner and a Game Boy (`printer_test_image.png`).
- **Memory test:** just before this, routine DD85 writes an incrementing pattern over all 0x1680 SRAM bytes and reads it back. Any mismatch sets "other error" (0x40).
- **Feed button:** when idle, pressing the button starts a paper feed (state 0x17, 86C9).

The 1,280-byte block at 0xA57E–0xAA7D is **not** an image; it is repeating lookup data used by the print engine.

---

## 11. Emulator checklist (for a BGB print interceptor)

Essential:

1. Answer 0x00 to every byte except the two reply slots: `0x81`, then status.
2. Sync on `88 33`. On a bad first byte, answer 0xFF until a gap in the traffic; if idle, also reset (Init).
3. Accumulate the 16-bit checksum over command, compression, length and payload.
4. Data: accept only between Init (or a finished print) and the empty data packet; keep at most 9 × 640 bytes.
5. RLE-decode compressed packets; pad each compressed packet to a whole 640-byte slot; don't pad uncompressed packets.
6. Print: require the empty data packet and 4 argument bytes. Apply the palette (0x00 = 0xE4), margins (high nibble before, low nibble after) and the copy count (0 = feed only).
7. Status bits and their lifecycle from section 6, including 0x08 after data, 0x04 after the empty packet, 0x06 while "printing", 0x04 after.
8. Keep busy (0x02) set for a realistic time. The Game Boy Camera and other games poll status until busy clears, and some games time out if the printer is too fast or too slow.

For hardware-level accuracy:

- Report the checksum-error bit one packet late.
- Mask 0x04 in the reply to the empty data packet.
- Treat Break (0x08) as abort, and block data until the next Init.
- Idle reset after a period of silence (13 main-loop ticks; the real-time value still needs measuring).
- Reject Init while busy, setting 0x08.

Rendering: decode the stored bytes as 2bpp tiles, 20 tiles per row, 640 bytes per 16-pixel band, in the order received. Use exposure only to vary darkness, if wanted (offsets −16…+1 from table 0xCFF6).

---

## 12. Confidence and open questions

**C** (code-traced, read directly from straight-line code, and reproduced in the emulator where section 14 says so):

- packet format, sync bytes, checksum, `0x81` + status reply;
- command dispatch and acceptance rules;
- status bit mapping;
- RLE format, 640-byte slots, 9-slot limit;
- palette remap and palette-0 special case;
- self-test image and trigger;
- reproduced in the emulator: the status sequence (section 6), the one-packet checksum lag, Init-on-garbage while idle, 0xFF sync-loss mode, Init while busy setting 0x08, Break, the 9-packet limit, the idle reset and inter-byte timeouts, copies, the power-on lockout and the self-test.

**I** (to check on real hardware):

- the low-battery reporting delay (`D9.1`);
- everything that depends on the paper mechanism: the emulator's encoder rate and cam-sensor period are guesses (`emulator/README.md`), so print durations and the length of a margin unit are not known.

**?** (not resolved):

- The physical rate of the paper encoder (INT3) and the length of one revolution of the cam sensor (P5.1 / INT4). Margins are counted in cam revolutions.
- INT3 is the paper-motor encoder and P5.1 / INT4 a once-per-revolution cam or home sensor (from the code and from what makes the emulator print); P5.2 low runs the motor. Which physical parts they are, and the SRAM address mapping in A564 (the order bytes are laid out for printing), are not known.

---

## 14. Verification by running the firmware

`emulator/gbprinter_emu.py` runs this ROM on an emulated TMP87C840 (8 MHz) and drives the link like a Game Boy (`emulator/README.md` lists what is modelled and what is guessed). `emulator/claims.py` replays the cases below; all 23 checks give the result shown. Statuses are the bytes the Game Boy reads after `0x81`.

| Case | Observed |
|---|---|
| Init, data, data, empty data, Print, status after 5 ms, status after 100 ms | 00 00 08 08 08 04 06 |
| Busy after Print | set 26 ms after the command, cleared at the end of the job; afterwards 0x04 stays |
| Status packet with a bad checksum, then two good ones | 00 01 00 (bit 0x01 one packet late) |
| Print without the empty data packet / with 3 argument bytes | 18 (packet error), nothing printed |
| Second empty data packet | 14 (packet error + full) |
| Data with compression flag 2 | 10 |
| 1,024-byte data, uncompressed / compressed, then status | 10 10 / 00 00 |
| Two status polls after data | 00 00 (the poll clears 0x08) |
| One junk byte while idle, then data | 00 (the data had been wiped by an Init); without the junk byte: 08 |
| Bytes after a junk first byte, no gap | all FF; after a gap > 5.12 ms the next packet is answered normally |
| 0x88 then a bad second byte | 00 FF FF |
| Longest gap inside a packet that is still accepted | 3.92 ms + 1.2 ms byte time = 5.12 ms |
| Silence after the empty data packet that wipes the job | 125 ms |
| Init while printing: status, Init reply, status | 06 0E 0E (Init ignored, 0x08 set) |
| Break while printing: Break reply, status 50 ms later, data (still busy), then once idle: data, Init, data | 02 06 04 14 04 00. Break takes effect at the next paper-feed phase: 94 ms when sent during a margin feed, up to about 700 ms in the middle of a band, which is finished first |
| 10 data packets | 00 then 08 × 9; 0x1680 bytes stored |
| Unknown command 0x03 with payload | 81 00 |
| Print with 0 sheets and margin 3 | busy (paper feed only) |
| Battery or head temperature out of range at power-on | FF to every packet (power-on lockout never lifted) |
| Battery dropping during a print | 06 → 86 → 84 (print aborted) |
| ADC channel 0 set before Print: 0x34 / 0x35 / 0xD7 / 0xD8 | 44 / prints / prints / 44: other error outside 0x35–0xD7, job refused; set during a print: 06 → 46 → 44 (aborted) |
| ADC channel 1 set before Print: 0x7F / 0x7E | prints / 04 → 84: low battery at 0x7E or below, job not started |
| Encoder stops during a print: status, Init, status | 28 28 28 (jam + unprocessed, sticky) |
| Front button held until the homing ends | self-test band printed (status 02 then 00); released earlier: no self-test |
| Copies | 2 sheets take exactly twice the motor pulses of 1 |
| Margins | each margin unit (either nibble) = one cam revolution of paper feed |
| Strobe timing, exposure 0x40 | 160 bursts per band, 4.00 ms apart; on-time black 1.55, dark 1.20, light 0.86–0.95 ms in mid-picture (real printer: 1.56 / 1.20 / 0.96 ms); first line about 2× longer (section 8) |

The power-on sequence in the emulator:
1. RAM and SRAM test.
2. Homing at about 0.5 s: the motor runs until the cam sensor has been seen twice, about 0.7 s.
3. Idle at about 1.2 s.

Packets sent before step 3 are answered 0xFF.

---

## 13. Method and files

- `tools/build_listing.py`: builds `TMP87C840_printer_rom.asm` from the symbol files in `symbols/` (names, RAM, flag bits, registers, data types), with checks, and reassembles the listing text with `tools/t870asm.py`; the result must give the ROM md5 again (`symbols/README.md`).
- `tools/t870.py`: a TLCS-870 disassembler written for this work, based on MAME's `tlcs870d.cpp` opcode map. Note: `T`/`F` jump conditions test the CPU's JF flag; they are not always/never. After `test`, `jr T` is taken when the bit is **0**.
- `tools/trace.py` (`python3 tools/trace.py ROM.bin OUT.asm ABA1` regenerates the listing exactly): recursive tracer from the 16 interrupt vectors. It follows calls, branches and the 33 `jp (PC+A)` jump tables (one 30-entry state table at 0xAB65, and 32 tables at 0xBED7–0xCA58 in the head-strobe pattern code). About 16 KB of the 24.7 KB used ROM is reached as code; the rest is lookup tables and the test image.
- `TMP87C840_printer_rom.asm`: the full annotated-label disassembly (vectors named `V_FFxx`, subroutines `Sxxxx`, branch targets `Lxxxx`, jump-table targets `Jxxxx`; data as `db`/`dw`).
- `printer_test_image.png`: the self-test band rendered 4×.
- `emulator/`: the firmware emulator and the protocol checks of section 14.

Key routines for anyone continuing: B373 receiver · B9B4 byte-wait yield · B99E inter-byte timeout · 80D5 main loop · 8564 command dispatch · 85AB print-argument parser · A29D–A406 data decoder · A4C0 RLE · A48F/A4A4 SRAM read/write · A409 temperature/battery check · DD85 SRAM test · DDAD self-test loader · 0xAB62 mechanism state machine.
