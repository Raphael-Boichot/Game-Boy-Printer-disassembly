; RAM variables and flag bits. [C] code-traced or run in the emulator, [I] inferred

RegBanks         equ $0040   ; [C] 32 byte(s). register banks 0-3 (8 bytes each: A W C B E D L H); bank 1 TC1 handler; bank 2 INT3 handler; bank 3 SIO2 receiver
RowHeatInt       equ $0060   ; [C] 16 byte(s). integer part of RowHeat per row, taken for the column being prepared
MechFlags        equ $0070   ; [C] 1 byte(s). mechanism flags
;   .0 LineReady      [I] column data prepared
;   .1 LineFetch      [I] line buffer refill pending
;   .2 CamSeen        [C] set by INT4 when the cam sensor rises
;   .3 MechActive     [C] mechanism job running
;   .4 StrobeBufB     [C] toggled per burst: 0 = table A; 1 = table B
;   .5 EncoderSeen    [C] set by every encoder pulse
;   .6 LineBufFill    [C] refill the line buffer from SRAM
SysFlags         equ $0071   ; [C] 1 byte(s). system flags
;   .0 MemFull        [C] image memory full (0x1680 bytes)
;   .1 EndMarkMask    [C] hide 'image data full' in replies until a status poll
;   .2 TickRunning    [C] normal 10.24 ms tick (cleared in idle, where the tick is 1 s)
;   .3 CamChange      [C] cam sensor change pending
;   .4 CamLevel       [C] last cam sensor level
;   .5 PowerOnLock    [C] set at boot; cleared when homing ends; packets answered 0xFF meanwhile
;   .6 SupplyCut      [C] P5.3 has been cleared after low battery
;   .7 Idle           [C] idle mode entered
LineCounter      equ $0072   ; [C] 1 byte(s). mechanism step counter; indexes the heat-compensation curve
MechState        equ $0073   ; [C] 1 byte(s). mechanism state (0 idle; 01-10 print columns; 11 homing; 12 band start; 13 band advance; 14 top margin; 15 bottom margin; 16 feed only; 17 button feed; 18 stop)
LineBufWr        equ $0074   ; [C] 2 byte(s). line buffer write pointer (0x0100-0x0220, 32-byte steps; checked in the emulator)
LineBufRd        equ $0076   ; [C] 2 byte(s). line buffer read pointer
HeatTime         equ $0078   ; [C] 1 byte(s). strobe base time = HeatBase + ExposureOffset
HeatBase         equ $0079   ; [C] 1 byte(s). base time from the temperature table 0xCEF6
ExposureOffset   equ $007A   ; [C] 1 byte(s). offset from the exposure table 0xCFF6
MechRequests     equ $007B   ; [C] 1 byte(s). requests to the mechanism (also low 5 bits of an encoder count)
;   .0 ReqHoming      [C] power-on homing request
;   .1 ReqFeed        [C] paper feed request
;   .2 ReqPrint       [C] print request
Status           equ $007C   ; [C] 1 byte(s). printer status as sent (bit-reversed: internal bit k = protocol bit 7-k)
;   .0 StLowBattery   [C] protocol 0x80
;   .1 StOtherError   [C] protocol 0x40
;   .2 StPaperJam     [C] protocol 0x20
;   .3 StPacketError  [C] protocol 0x10
;   .4 StUnprocessed  [C] protocol 0x08
;   .5 StImageFull    [C] protocol 0x04
;   .6 StBusy         [C] protocol 0x02
;   .7 StChecksumErr  [C] protocol 0x01
MarginBefore     equ $007D   ; [C] 1 byte(s). margin before printing (print argument byte 1 high nibble)
MarginBeforeLeft equ $007E   ; [C] 1 byte(s). margin units left in state 0x14
MarginAfter      equ $007F   ; [C] 1 byte(s). margin after printing (argument byte 1 low nibble)
FeedLeft         equ $0080   ; [C] 1 byte(s). feed units left
FeedOnlyAmount   equ $0081   ; [C] 1 byte(s). feed amount for a print with 0 sheets
TileColumnX      equ $0082   ; [C] 1 byte(s). pixel column inside the current tile (0-7)
PrintReadPos     equ $0083   ; [C] 2 byte(s). SRAM read position while printing
ImageBytes       equ $0085   ; [C] 2 byte(s). valid image bytes in SRAM (max 0x1680)
ColumnPixels     equ $0087   ; [C] 16 byte(s). dot values (0-3, after the palette) of the 16 rows of the column
ColumnHistCode   equ $0097   ; [C] 16 byte(s). Tab_EnergyByHistory code per row
RowHistory       equ $00A7   ; [C] 16 byte(s). per row: previous dot << 4 | current dot
RowHeat          equ $00B7   ; [C] 32 byte(s). 16 words, 8.8 fixed point: modelled heat of each head element
RxResume         equ $00D7   ; [C] 2 byte(s). receiver coroutine resume address
RxFlags          equ $00D9   ; [C] 1 byte(s). receiver flags
;   .0 RxInPacket     [C] receiver coroutine is waiting for a byte
;   .1 LowBatHold     [I] withhold low battery from replies
;   .2 LowBatReported [C] a reply has carried the low-battery bit
;   .3 RxIsData       [C] current packet is a data packet
;   .4 RxDataOk       [C] data packet accepted
;   .5 RxEndMark      [C] empty data packet received
;   .6 RxCompressed   [C] current data packet is compressed
;   .7 RxActive       [C] packet in progress
RxErrFlags       equ $00DA   ; [C] 1 byte(s). receiver error and control flags
;   .0 PacketError    [C] current packet broke a rule
;   .1 RxIgnored      [C] payload ignored (no command posted)
;   .2 ColdHead       [C] every row heat is zero: use the cold tick curves
;   .3 DecCompressed  [C] decoder: packet is compressed
;   .4 SyncLostBusy   [C] sync lost while printing: treat packets as junk until the job ends
;   .5 BreakBlock     [C] after Break: data packets give a packet error until Init
;   .7 DataAbort      [C] roll back the data packet
CmdRequests      equ $00DB   ; [C] 1 byte(s). commands posted by the receiver to the main loop
;   .4 ReqStatus      [C] status command posted
;   .5 ReqBreak       [C] break command posted
;   .6 ReqPrint       [C] print command posted
;   .7 ReqInit        [C] init command posted
RingWr           equ $00DC   ; [C] 2 byte(s). receive ring buffer write pointer
RingRd           equ $00DE   ; [C] 2 byte(s). receive ring buffer read pointer
DecodeFlags      equ $00E0   ; [C] 1 byte(s). data decoder and tick flags
;   .0 DataPending    [C] data packet started
;   .1 Decoding       [C] decoder busy with a packet
;   .2 DecodeStarted  [I] decoder initialised for the packet
;   .3 RleInRun       [C] inside an RLE run
;   .4 RleLiteral     [C] run is literal bytes
;   .5 RleRepeat      [C] run repeats one byte
;   .6 RleHaveByte    [C] repeat byte loaded
;   .7 Tick           [C] main tick (set by INTTC2)
JobFlags         equ $00E1   ; [C] 1 byte(s). print job flags
;   .0 AfterPrint     [C] a print was accepted (next data starts a new image)
;   .1 Printing       [C] printing
;   .2 Feeding        [C] feeding paper
;   .3 BreakReq       [C] stop requested by Break
;   .4 SioRearm       [C] serial watchdog armed: re-arm SIO2 after SioIdleTimer if no packet is in progress
;   .5 BattCheckDue   [C] battery check under load (TC3) due
;   .6 InitDeferred   [I] init received during button feed
;   .7 BattSample     [C] first strobe burst of a job: read the battery under load (low battery at <= 0x7E, or a sag of 8 below BattAtStart when <= 0x9C)
SlotBase         equ $00E2   ; [C] 2 byte(s). SRAM slot base (multiple of 0x280)
SlotOffset       equ $00E4   ; [C] 2 byte(s). offset in the current 640-byte slot
RleByte          equ $00E6   ; [C] 1 byte(s). RLE repeated byte
RleCount         equ $00E7   ; [C] 1 byte(s). RLE run count
LowBatTimer      equ $00E8   ; [C] 1 byte(s). started at 0x6D when a reply carried low battery; counts ticks
Copies           equ $00E9   ; [C] 1 byte(s). copies left (print argument byte 0)
SavedSlotBase    equ $00EA   ; [C] 2 byte(s). rollback copy of SlotBase
SavedImageBytes  equ $00EC   ; [C] 2 byte(s). rollback copy of ImageBytes
SavedSlotOffset  equ $00EE   ; [C] 2 byte(s). rollback copy of SlotOffset
RxSavedEIR       equ $00F0   ; [C] 2 byte(s). EIR saved by the receiver
SioIdleTimer     equ $00F2   ; [C] 1 byte(s). ticks without serial activity before SIO2 is re-armed (JobFlags.SioRearm)
EncoderTimeout   equ $00F3   ; [C] 1 byte(s). ticks without an encoder pulse (jam at overflow)
CamTimeout       equ $00F4   ; [C] 1 byte(s). ticks without a cam sensor change (jam at overflow)
SelfTest         equ $00F5   ; [C] 1 byte(s). 1 = self-test requested at power-on
StartDelay       equ $00F6   ; [C] 1 byte(s). delay before a job or the next copy: 0xF4 -> 0 (12 ticks)
IdleDelay        equ $00F7   ; [I] 1 byte(s). tick counter before idle mode
TileColumnsLeft  equ $00F8   ; [C] 1 byte(s). tile columns left in the band (20 per band)
IdleCool         equ $00F9   ; [C] 1 byte(s). Tab_IdleCoolByTemp value for the current temperature
DotMask          equ $00FA   ; [C] 2 byte(s). 16 bits: rows with a printed dot in this column
BandIndex        equ $00FC   ; [C] 1 byte(s). band of the picture being printed (selects the tick curve)
TempAdc          equ $00FD   ; [C] 1 byte(s). last temperature reading
MechSubState     equ $00FE   ; [C] 1 byte(s). sub-state of the current mechanism state
Palette          equ $00FF   ; [C] 1 byte(s). palette (print argument byte 2; 0 = no remapping)
LineBuf          equ $0100   ; [C] 320 byte(s). image bytes fetched from SRAM for printing (32-byte chunks)
ColumnSource     equ $0240   ; [C] 32 byte(s). 32 bytes of the tile column being printed (2 tiles x 16 rows x 2 planes)
ColumnCodes      equ $0260   ; [C] 256 byte(s). energy codes: 16 rows per pixel column, one block of 16 per column state
StrobeA_P0       equ $0360   ; [C] 35 byte(s). strobe tick table A for P0 (rows 0-7): one byte per TC1 tick
StrobeA_P1       equ $0383   ; [C] 35 byte(s). strobe tick table A for P1 (rows 8-15)
StrobeB_P0       equ $03A6   ; [C] 35 byte(s). strobe tick table B for P0
StrobeB_P1       equ $03C9   ; [C] 35 byte(s). strobe tick table B for P1
PktCommand       equ $03EC   ; [C] 1 byte(s). packet command
PktCompress      equ $03ED   ; [C] 1 byte(s). packet compression flag
PktLength        equ $03EE   ; [C] 2 byte(s). packet payload length
PktArgs          equ $03F0   ; [C] 4 byte(s). first 4 payload bytes of non-data packets
RingBuf          equ $03F4   ; [C] 32 byte(s). receive ring buffer (serial interrupt -> decoder)
PktChecksum      equ $0414   ; [C] 2 byte(s). running checksum
PktRemaining     equ $0416   ; [C] 2 byte(s). payload bytes left
EncoderIdleCount equ $0418   ; [C] 1 byte(s). encoder pulses while idle with no job (from 0xE5); on overflow P5.3 is cleared
HeatCurvePtr     equ $0419   ; [C] 2 byte(s). tick curve of the current band (from Tab_TickCurvePtrsWarm / Cold)
BattAtStart      equ $041B   ; [C] 1 byte(s). battery reading (no load) at job start; compared with the reading under load
ActivityTimer    equ $041C   ; [C] 1 byte(s). reloaded with 0xF3 by every received byte; idle reset when it wraps
HeatSoak         equ $041E   ; [C] 1 byte(s). bands printed since the head was last cold (max 40); indexes Tab_TickTrimBySoak
Sio2Buf          equ $0FF8   ; [C] 8 byte(s). SIO2 data buffer (shared transmit / receive)
