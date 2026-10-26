; TMP87C840 special function registers (names from the datasheet; pin use from the IF-GBP-02 schematic)

P0         equ $00   ; port 0 (QFP pins 3-10): head strobe lines for band rows 0-7 (bit n = row n); P00-P07 -> TD62593A IC6 -> head connector CN2 pins 18-11 (schematic: RWeick/IF-GBP-02-Gameboy-Printer)
P1         equ $01   ; port 1 (QFP pins 11-18): head strobe lines for band rows 8-15; P10-P17 -> TD62593A IC5 -> CN2 pins 10-3
P2         equ $02   ; port 2: bit0 front button SW1 (P20 = INT5 pin 19; 0 = pressed; pull-up R24); bit1 SRAM /WE (P21 pin 21); bit2 SRAM /CE1 (P22 pin 22)
P3         equ $03   ; port 3: SRAM address A0-A7
P4         equ $04   ; port 4: bits 0-4 SRAM address A8-A12 (written OR 0xE0); bits 5-7 SIO2 (P45 SCK2 -> link pin 5, P46 SI2 <- link pin 3, P47 SO2 -> link pin 2)
P5         equ $05   ; port 5: bit0 encoder (P50 = INT3: motor connector CN1 pin 3 through transistor Q10); bit1 cam sensor (P51 = INT4: CN1 pin 5, pull-up R29); bit2 motor (P52 -> Q8/Q9 -> Q6/Q7 -> CN1 pin 2; 0 = run, 1 = brake); bit3 supply control (P53 -> Q14 -> the Q4/Q5 latch of the head supply, which also lights LED1; cleared on low battery and after 27 encoder pulses while idle; never set again); bit4 SRAM /OE (P54)
P6         equ $06   ; port 6
P7         equ $07   ; port 7: SRAM data bus D0-D7
P0CR       equ $0A   ; port 0 direction
P1CR       equ $0B   ; port 1 direction
P6CR       equ $0C   ; port 6 direction
P7CR       equ $0D   ; port 7 direction (0xFF = output for SRAM writes)
ADCCR      equ $0E   ; A/D control: low bits channel (0 = AIN0/P60: thermistor TH1 to GND with 10k pull-up R28 - other error 0x40 outside 0x35-0xD7, strobe base time; 1 = AIN1/P61: battery through divider R26/R27 - low battery 0x80 at 0x7E or below); bit6 start; bit7 end of conversion
ADCDR      equ $0F   ; A/D result
TREG1A     equ $10   ; timer 1 register A (16-bit): strobe tick length in us
TREG1B     equ $12   ; timer 1 register B
TC1CR      equ $14   ; timer 1 control: 0x18 = start fc/2^3 (1 us)
TC2CR      equ $15   ; timer 2 control: 0x24 = start fc/2^13 (main tick)
TREG2      equ $16   ; timer 2 register (16-bit): 0x000A = 10.24 ms tick; 0x03D5 = 1.0 s in idle
TREG3A     equ $18   ; timer 3 register A
TREG3B     equ $19   ; timer 3 register B
TC3CR      equ $1A   ; timer 3 control
TREG4      equ $1B   ; timer 4 register: 0x14 = 20 counts
TC4CR      equ $1C   ; timer 4 control: 0xD0 = start fc/2^11 (inter-byte timeout 5.12 ms); 0xC0 = stop and clear
SIO1CR1    equ $20   ; serial 1 control 1 (unused)
SIO1CR2    equ $21   ; serial 1 control 2 (unused)
SIO2CR1    equ $22   ; serial 2 control 1: 0x67 = stop / 8-bit transmit-receive external clock; 0xA7 = start
SIO2CR2    equ $23   ; serial 2 control 2: bytes per transfer - 1
WDTCR1     equ $34   ; watchdog control 1
WDTCR2     equ $35   ; watchdog control 2: 0xB1 disables; 0x4E clears
TBTCR      equ $36   ; time base timer control
EINTCR     equ $37   ; external interrupt control
SYSCR1     equ $38   ; system control 1
SYSCR2     equ $39   ; system control 2: bit4 IDLE
EIR        equ $3A   ; interrupt enable register (16-bit; bit0 = IMF)
IL         equ $3C   ; interrupt latch (16-bit)
PSW        equ $3F   ; program status word / register bank
