RESET:
  8000  483a       di
  8002  fa3f04     ld SP,$043F
  8005  2c3800     ld ($38),$00
  8008  2c3980     ld ($39),$80
  800B  2c3407     ld ($34),$07
  800E  2c35b1     ld ($35),$B1
  8011  2c0000     ld ($00),$00
  8014  2c0aff     ld ($0A),$FF
  8017  2c0100     ld ($01),$00
  801A  2c0bff     ld ($0B),$FF
  801D  2c0207     ld ($02),$07
  8020  2c0300     ld ($03),$00
  8023  2c04e0     ld ($04),$E0
  8026  2c05ff     ld ($05),$FF
  8029  2c0600     ld ($06),$00
  802C  2c0c03     ld ($0C),$03
  802F  2c0700     ld ($07),$00
  8032  2c0d00     ld ($0D),$00
  8035  174800     ld HL,$0048
  8038  15f803     ld BC,$03F8
L803B:
  803B  f62c00     ld (HL+),$00
  803E  19         dec BC
  803F  d1fa       jr NZ,L803B
  8041  407b       set ($7B).0
  8043  4571       set ($71).5
  8045  4271       set ($71).2
  8047  24740001   ldw ($74),$0100
  804B  24760001   ldw ($76),$0100
  804F  17f403     ld HL,$03F4
  8052  f0dc13     ld ($DC),HL
  8055  f0de13     ld ($DE),HL
  8058  171d04     ld HL,$041D
  805B  2d6d       ld (HL),$6D
  805D  2cf79c     ld ($F7),$9C
  8060  2cf601     ld ($F6),$01
  8063  2cf3f4     ld ($F3),$F4
  8066  171804     ld HL,$0418
  8069  2de5       ld (HL),$E5
  806B  fc85dd     call SDD85
  806E  24106400   ldw ($10),$0064
  8072  2c1408     ld ($14),$08
  8075  24160a00   ldw ($16),$000A
  8079  2c1524     ld ($15),$24
  807C  2c185e     ld ($18),$5E
  807F  2c1a08     ld ($1A),$08
  8082  2c1b14     ld ($1B),$14
  8085  2c1cc0     ld ($1C),$C0
  8088  2c2267     ld ($22),$67
  808B  2c2300     ld ($23),$00
  808E  2c22a7     ld ($22),$A7
  8091  2c3708     ld ($37),$08
  8094  243cef02   ldw ($3C),$02EF
  8098  243a11fd   ldw ($3A),$FD11
  809C  d802       test ($02).0
  809E  a8         jrs F,L80A8
  809F  d802       test ($02).0
  80A1  a5         jrs F,L80A8
  80A2  2cf501     ld ($F5),$01
  80A5  fcaddd     call SDDAD
L80A8:
  80A8  140000     ld WA,$0000
L80AB:
  80AB  10         inc WA
  80AC  bd         jrs F,L80AB
  80AD  2c0e01     ld ($0E),$01
  80B0  460e       set ($0E).6
L80B2:
  80B2  df0e       test ($0E).7
  80B4  9c         jrs T,L80B2
  80B5  220f       ld A,($0F)
  80B7  777e       cmp A,$7E
  80B9  d517       jr GT,L80D2
  80BB  14b3fe     ld WA,$FEB3
L80BE:
  80BE  10         inc WA
  80BF  bd         jrs F,L80BE
  80C0  2c0e01     ld ($0E),$01
  80C3  460e       set ($0E).6
L80C5:
  80C5  df0e       test ($0E).7
  80C7  9c         jrs T,L80C5
  80C8  220f       ld A,($0F)
  80CA  777e       cmp A,$7E
  80CC  d504       jr GT,L80D2
  80CE  407c       set ($7C).0
  80D0  41d9       set ($D9).1
L80D2:
  80D2  2c340f     ld ($34),$0F
L80D5:
  80D5  2c354e     ld ($35),$4E
  80D8  2273       ld A,($73)
  80DA  d004       jr Z,L80E0
  80DC  7710       cmp A,$10
  80DE  d404       jr LE,L80E4
L80E0:
  80E0  24000000   ldw ($00),$0000
L80E4:
  80E4  d87c       test ($7C).0
  80E6  85         jrs T,L80ED
  80E7  de71       test ($71).6
  80E9  a2         jrs F,L80ED
  80EA  febb82     jp L82BB
L80ED:
  80ED  2273       ld A,($73)
  80EF  d003       jr Z,L80F4
  80F1  febb82     jp L82BB
L80F4:
  80F4  de7c       test ($7C).6
  80F6  82         jrs T,L80FA
  80F7  febb82     jp L82BB
L80FA:
  80FA  d8d9       test ($D9).0
  80FC  82         jrs T,L8100
  80FD  febb82     jp L82BB
L8100:
  8100  171c04     ld HL,$041C
  8103  e37700     cmp (HL),$00
  8106  82         jrs T,L810A
  8107  febb82     jp L82BB
L810A:
  810A  de22       test ($22).6
  810C  82         jrs T,L8110
  810D  febb82     jp L82BB
L8110:
  8110  d9e0       test ($E0).1
  8112  82         jrs T,L8116
  8113  febb82     jp L82BB
L8116:
  8116  dc7c       test ($7C).4
  8118  82         jrs T,L811C
  8119  febb82     jp L82BB
L811C:
  811C  d87b       test ($7B).0
  811E  82         jrs T,L8122
  811F  febb82     jp L82BB
L8122:
  8122  da7b       test ($7B).2
  8124  82         jrs T,L8128
  8125  febb82     jp L82BB
L8128:
  8128  4771       set ($71).7
  812A  4a71       clr ($71).2
  812C  2c1504     ld ($15),$04
  812F  2416d503   ldw ($16),$03D5
  8133  2c1524     ld ($15),$24
  8136  171d04     ld HL,$041D
  8139  2d6d       ld (HL),$6D
  813B  2cf79c     ld ($F7),$9C
  813E  4fe0       clr ($E0).7
  8140  4439       set ($39).4
  8142  4271       set ($71).2
  8144  2c1504     ld ($15),$04
  8147  24160a00   ldw ($16),$000A
  814B  2c1524     ld ($15),$24
  814E  4fe0       clr ($E0).7
  8150  a2         jrs F,L8154
  8151  feb682     jp L82B6
L8154:
  8154  dfe1       test ($E1).7
  8156  82         jrs T,L815A
  8157  feb682     jp L82B6
L815A:
  815A  2c0e00     ld ($0E),$00
  815D  460e       set ($0E).6
L815F:
  815F  df0e       test ($0E).7
  8161  9c         jrs T,L815F
  8162  e00f5a     ld C,($0F)
  8165  1476da     ld WA,$DA76
  8168  3300       ld B,$00
  816A  e931       add WA,BC
  816C  e817       ld HL,WA
  816E  e35a       ld C,(HL)
  8170  ea5d       ld D,C
  8172  e0b75c     ld E,($B7)
  8175  ea02       mul DE
  8177  ea59       ld W,C
  8179  22b8       ld A,($B8)
  817B  02         mul W,A
  817C  ed61       add A,D
  817E  e97000     addc W,$00
  8181  f0b710     ld ($B7),WA
  8184  ea5d       ld D,C
  8186  e0b95c     ld E,($B9)
  8189  ea02       mul DE
  818B  ea59       ld W,C
  818D  22ba       ld A,($BA)
  818F  02         mul W,A
  8190  ed61       add A,D
  8192  e97000     addc W,$00
  8195  f0b910     ld ($B9),WA
  8198  ea5d       ld D,C
  819A  e0bb5c     ld E,($BB)
  819D  ea02       mul DE
  819F  ea59       ld W,C
  81A1  22bc       ld A,($BC)
  81A3  02         mul W,A
  81A4  ed61       add A,D
  81A6  e97000     addc W,$00
  81A9  f0bb10     ld ($BB),WA
  81AC  ea5d       ld D,C
  81AE  e0bd5c     ld E,($BD)
  81B1  ea02       mul DE
  81B3  ea59       ld W,C
  81B5  22be       ld A,($BE)
  81B7  02         mul W,A
  81B8  ed61       add A,D
  81BA  e97000     addc W,$00
  81BD  f0bd10     ld ($BD),WA
  81C0  ea5d       ld D,C
  81C2  e0bf5c     ld E,($BF)
  81C5  ea02       mul DE
  81C7  ea59       ld W,C
  81C9  22c0       ld A,($C0)
  81CB  02         mul W,A
  81CC  ed61       add A,D
  81CE  e97000     addc W,$00
  81D1  f0bf10     ld ($BF),WA
  81D4  ea5d       ld D,C
  81D6  e0c15c     ld E,($C1)
  81D9  ea02       mul DE
  81DB  ea59       ld W,C
  81DD  22c2       ld A,($C2)
  81DF  02         mul W,A
  81E0  ed61       add A,D
  81E2  e97000     addc W,$00
  81E5  f0c110     ld ($C1),WA
  81E8  ea5d       ld D,C
  81EA  e0c35c     ld E,($C3)
  81ED  ea02       mul DE
  81EF  ea59       ld W,C
  81F1  22c4       ld A,($C4)
  81F3  02         mul W,A
  81F4  ed61       add A,D
  81F6  e97000     addc W,$00
  81F9  f0c310     ld ($C3),WA
  81FC  ea5d       ld D,C
  81FE  e0c55c     ld E,($C5)
  8201  ea02       mul DE
  8203  ea59       ld W,C
  8205  22c6       ld A,($C6)
  8207  02         mul W,A
  8208  ed61       add A,D
  820A  e97000     addc W,$00
  820D  f0c510     ld ($C5),WA
  8210  ea5d       ld D,C
  8212  e0c75c     ld E,($C7)
  8215  ea02       mul DE
  8217  ea59       ld W,C
  8219  22c8       ld A,($C8)
  821B  02         mul W,A
  821C  ed61       add A,D
  821E  e97000     addc W,$00
  8221  f0c710     ld ($C7),WA
  8224  ea5d       ld D,C
  8226  e0c95c     ld E,($C9)
  8229  ea02       mul DE
  822B  ea59       ld W,C
  822D  22ca       ld A,($CA)
  822F  02         mul W,A
  8230  ed61       add A,D
  8232  e97000     addc W,$00
  8235  f0c910     ld ($C9),WA
  8238  ea5d       ld D,C
  823A  e0cb5c     ld E,($CB)
  823D  ea02       mul DE
  823F  ea59       ld W,C
  8241  22cc       ld A,($CC)
  8243  02         mul W,A
  8244  ed61       add A,D
  8246  e97000     addc W,$00
  8249  f0cb10     ld ($CB),WA
  824C  ea5d       ld D,C
  824E  e0cd5c     ld E,($CD)
  8251  ea02       mul DE
  8253  ea59       ld W,C
  8255  22ce       ld A,($CE)
  8257  02         mul W,A
  8258  ed61       add A,D
  825A  e97000     addc W,$00
  825D  f0cd10     ld ($CD),WA
  8260  ea5d       ld D,C
  8262  e0cf5c     ld E,($CF)
  8265  ea02       mul DE
  8267  ea59       ld W,C
  8269  22d0       ld A,($D0)
  826B  02         mul W,A
  826C  ed61       add A,D
  826E  e97000     addc W,$00
  8271  f0cf10     ld ($CF),WA
  8274  ea5d       ld D,C
  8276  e0d15c     ld E,($D1)
  8279  ea02       mul DE
  827B  ea59       ld W,C
  827D  22d2       ld A,($D2)
  827F  02         mul W,A
  8280  ed61       add A,D
  8282  e97000     addc W,$00
  8285  f0d110     ld ($D1),WA
  8288  ea5d       ld D,C
  828A  e0d35c     ld E,($D3)
  828D  ea02       mul DE
  828F  ea59       ld W,C
  8291  22d4       ld A,($D4)
  8293  02         mul W,A
  8294  ed61       add A,D
  8296  e97000     addc W,$00
  8299  f0d310     ld ($D3),WA
  829C  ea5d       ld D,C
  829E  e0d55c     ld E,($D5)
  82A1  ea02       mul DE
  82A3  ea59       ld W,C
  82A5  22d6       ld A,($D6)
  82A7  02         mul W,A
  82A8  ed61       add A,D
  82AA  e97000     addc W,$00
  82AD  f0d510     ld ($D5),WA
  82B0  171e04     ld HL,$041E
  82B3  29         dec (HL)
  82B4  a0         jrs F,L82B6
  82B5  2f         clr (HL)
L82B6:
  82B6  fc09a4     call SA409
  82B9  fb15       jr L82D0
L82BB:
  82BB  4f71       clr ($71).7
  82BD  171804     ld HL,$0418
  82C0  2de5       ld (HL),$E5
  82C2  e0737700   cmp ($73),$00
  82C6  85         jrs T,L82CD
  82C7  e0737711   cmp ($73),$11
  82CB  d203       jr CS,L82D0
L82CD:
  82CD  fc09a4     call SA409
L82D0:
  82D0  4fe0       clr ($E0).7
  82D2  a2         jrs F,L82D6
  82D3  fe0885     jp L8508
L82D6:
  82D6  22e8       ld A,($E8)
  82D8  d002       jr Z,L82DC
  82DA  20e8       inc ($E8)
L82DC:
  82DC  de7c       test ($7C).6
  82DE  d739       jr F,L8319
  82E0  171c04     ld HL,$041C
  82E3  e37700     cmp (HL),$00
  82E6  d631       jr T,L8319
  82E8  21         inc (HL)
  82E9  d12e       jr NZ,L8319
  82EB  4dda       clr ($DA).5
  82ED  48da       clr ($DA).0
  82EF  4871       clr ($71).0
  82F1  4d7c       clr ($7C).5
  82F3  49e0       clr ($E0).1
  82F5  4ae0       clr ($E0).2
  82F7  4cd9       clr ($D9).4
  82F9  4dd9       clr ($D9).5
  82FB  da7c       test ($7C).2
  82FD  a1         jrs F,L8300
  82FE  4c7c       clr ($7C).4
L8300:
  8300  48e1       clr ($E1).0
  8302  2ee9       clr ($E9)
  8304  24e20000   ldw ($E2),$0000
  8308  24830000   ldw ($83),$0000
  830C  24850000   ldw ($85),$0000
  8310  17f403     ld HL,$03F4
  8313  f0dc13     ld ($DC),HL
  8316  f0de13     ld ($DE),HL
L8319:
  8319  22f2       ld A,($F2)
  831B  d002       jr Z,L831F
  831D  20f2       inc ($F2)
L831F:
  831F  dce1       test ($E1).4
  8321  d713       jr F,L8336
  8323  22f2       ld A,($F2)
  8325  d124       jr NZ,L834B
  8327  2cf2f4     ld ($F2),$F4
  832A  d8d9       test ($D9).0
  832C  d71b       jr F,L8349
  832E  de22       test ($22).6
  8330  d617       jr T,L8349
  8332  44e1       set ($E1).4
  8334  fb15       jr L834B
L8336:
  8336  d8d9       test ($D9).0
  8338  af         jrs F,L8349
  8339  de22       test ($22).6
  833B  8c         jrs T,L8349
  833C  22f2       ld A,($F2)
  833E  d10b       jr NZ,L834B
  8340  2c2267     ld ($22),$67
  8343  2c2300     ld ($23),$00
  8346  2c22a7     ld ($22),$A7
L8349:
  8349  4ce1       clr ($E1).4
L834B:
  834B  2273       ld A,($73)
  834D  d109       jr NZ,L8358
  834F  2ef3       clr ($F3)
  8351  4d70       clr ($70).5
  8353  2cf3f4     ld ($F3),$F4
  8356  fb21       jr L8379
L8358:
  8358  4d70       clr ($70).5
  835A  84         jrs T,L8360
  835B  2cf3f4     ld ($F3),$F4
  835E  fb19       jr L8379
L8360:
  8360  22f3       ld A,($F3)
  8362  d015       jr Z,L8379
  8364  20f3       inc ($F3)
  8366  d711       jr F,L8379
  8368  24000000   ldw ($00),$0000
  836C  4205       set ($05).2
  836E  427c       set ($7C).2
  8370  2c7300     ld ($73),$00
  8373  447c       set ($7C).4
  8375  4d7c       clr ($7C).5
  8377  4e7c       clr ($7C).6
L8379:
  8379  e0f67701   cmp ($F6),$01
  837D  85         jrs T,L8384
  837E  22f6       ld A,($F6)
  8380  d002       jr Z,L8384
  8382  20f6       inc ($F6)
L8384:
  8384  da71       test ($71).2
  8386  a2         jrs F,L838A
  8387  fe0585     jp L8505
L838A:
  838A  2273       ld A,($73)
  838C  d003       jr Z,L8391
  838E  fe0585     jp L8505
L8391:
  8391  d87c       test ($7C).0
  8393  8a         jrs T,L839F
  8394  171d04     ld HL,$041D
  8397  e37700     cmp (HL),$00
  839A  83         jrs T,L839F
  839B  21         inc (HL)
  839C  a1         jrs F,L839F
  839D  49d9       clr ($D9).1
L839F:
  839F  20f7       inc ($F7)
  83A1  82         jrs T,L83A5
  83A2  fe0885     jp L8508
L83A5:
  83A5  171e04     ld HL,$041E
  83A8  2f         clr (HL)
  83A9  dfe1       test ($E1).7
  83AB  82         jrs T,L83AF
  83AC  fe0585     jp L8505
L83AF:
  83AF  2c0e00     ld ($0E),$00
  83B2  460e       set ($0E).6
L83B4:
  83B4  df0e       test ($0E).7
  83B6  9c         jrs T,L83B4
  83B7  e00f5a     ld C,($0F)
  83BA  1476da     ld WA,$DA76
  83BD  3300       ld B,$00
  83BF  e931       add WA,BC
  83C1  e817       ld HL,WA
  83C3  e35a       ld C,(HL)
  83C5  ea5d       ld D,C
  83C7  e0b75c     ld E,($B7)
  83CA  ea02       mul DE
  83CC  ea59       ld W,C
  83CE  22b8       ld A,($B8)
  83D0  02         mul W,A
  83D1  ed61       add A,D
  83D3  e97000     addc W,$00
  83D6  f0b710     ld ($B7),WA
  83D9  ea5d       ld D,C
  83DB  e0b95c     ld E,($B9)
  83DE  ea02       mul DE
  83E0  ea59       ld W,C
  83E2  22ba       ld A,($BA)
  83E4  02         mul W,A
  83E5  ed61       add A,D
  83E7  e97000     addc W,$00
  83EA  f0b910     ld ($B9),WA
  83ED  ea5d       ld D,C
  83EF  e0bb5c     ld E,($BB)
  83F2  ea02       mul DE
  83F4  ea59       ld W,C
  83F6  22bc       ld A,($BC)
  83F8  02         mul W,A
  83F9  ed61       add A,D
  83FB  e97000     addc W,$00
  83FE  f0bb10     ld ($BB),WA
  8401  ea5d       ld D,C
  8403  e0bd5c     ld E,($BD)
  8406  ea02       mul DE
  8408  ea59       ld W,C
  840A  22be       ld A,($BE)
  840C  02         mul W,A
  840D  ed61       add A,D
  840F  e97000     addc W,$00
  8412  f0bd10     ld ($BD),WA
  8415  ea5d       ld D,C
  8417  e0bf5c     ld E,($BF)
  841A  ea02       mul DE
  841C  ea59       ld W,C
  841E  22c0       ld A,($C0)
  8420  02         mul W,A
  8421  ed61       add A,D
  8423  e97000     addc W,$00
  8426  f0bf10     ld ($BF),WA
  8429  ea5d       ld D,C
  842B  e0c15c     ld E,($C1)
  842E  ea02       mul DE
  8430  ea59       ld W,C
  8432  22c2       ld A,($C2)
  8434  02         mul W,A
  8435  ed61       add A,D
  8437  e97000     addc W,$00
  843A  f0c110     ld ($C1),WA
  843D  ea5d       ld D,C
  843F  e0c35c     ld E,($C3)
  8442  ea02       mul DE
  8444  ea59       ld W,C
  8446  22c4       ld A,($C4)
  8448  02         mul W,A
  8449  ed61       add A,D
  844B  e97000     addc W,$00
  844E  f0c310     ld ($C3),WA
  8451  ea5d       ld D,C
  8453  e0c55c     ld E,($C5)
  8456  ea02       mul DE
  8458  ea59       ld W,C
  845A  22c6       ld A,($C6)
  845C  02         mul W,A
  845D  ed61       add A,D
  845F  e97000     addc W,$00
  8462  f0c510     ld ($C5),WA
  8465  ea5d       ld D,C
  8467  e0c75c     ld E,($C7)
  846A  ea02       mul DE
  846C  ea59       ld W,C
  846E  22c8       ld A,($C8)
  8470  02         mul W,A
  8471  ed61       add A,D
  8473  e97000     addc W,$00
  8476  f0c710     ld ($C7),WA
  8479  ea5d       ld D,C
  847B  e0c95c     ld E,($C9)
  847E  ea02       mul DE
  8480  ea59       ld W,C
  8482  22ca       ld A,($CA)
  8484  02         mul W,A
  8485  ed61       add A,D
  8487  e97000     addc W,$00
  848A  f0c910     ld ($C9),WA
  848D  ea5d       ld D,C
  848F  e0cb5c     ld E,($CB)
  8492  ea02       mul DE
  8494  ea59       ld W,C
  8496  22cc       ld A,($CC)
  8498  02         mul W,A
  8499  ed61       add A,D
  849B  e97000     addc W,$00
  849E  f0cb10     ld ($CB),WA
  84A1  ea5d       ld D,C
  84A3  e0cd5c     ld E,($CD)
  84A6  ea02       mul DE
  84A8  ea59       ld W,C
  84AA  22ce       ld A,($CE)
  84AC  02         mul W,A
  84AD  ed61       add A,D
  84AF  e97000     addc W,$00
  84B2  f0cd10     ld ($CD),WA
  84B5  ea5d       ld D,C
  84B7  e0cf5c     ld E,($CF)
  84BA  ea02       mul DE
  84BC  ea59       ld W,C
  84BE  22d0       ld A,($D0)
  84C0  02         mul W,A
  84C1  ed61       add A,D
  84C3  e97000     addc W,$00
  84C6  f0cf10     ld ($CF),WA
  84C9  ea5d       ld D,C
  84CB  e0d15c     ld E,($D1)
  84CE  ea02       mul DE
  84D0  ea59       ld W,C
  84D2  22d2       ld A,($D2)
  84D4  02         mul W,A
  84D5  ed61       add A,D
  84D7  e97000     addc W,$00
  84DA  f0d110     ld ($D1),WA
  84DD  ea5d       ld D,C
  84DF  e0d35c     ld E,($D3)
  84E2  ea02       mul DE
  84E4  ea59       ld W,C
  84E6  22d4       ld A,($D4)
  84E8  02         mul W,A
  84E9  ed61       add A,D
  84EB  e97000     addc W,$00
  84EE  f0d310     ld ($D3),WA
  84F1  ea5d       ld D,C
  84F3  e0d55c     ld E,($D5)
  84F6  ea02       mul DE
  84F8  ea59       ld W,C
  84FA  22d6       ld A,($D6)
  84FC  02         mul W,A
  84FD  ed61       add A,D
  84FF  e97000     addc W,$00
  8502  f0d510     ld ($D5),WA
L8505:
  8505  2cf79c     ld ($F7),$9C
L8508:
  8508  d87c       test ($7C).0
  850A  a5         jrs F,L8511
  850B  49d9       clr ($D9).1
  850D  4ad9       clr ($D9).2
  850F  fb18       jr L8529
L8511:
  8511  dad9       test ($D9).2
  8513  ab         jrs F,L8520
  8514  d9d9       test ($D9).1
  8516  d711       jr F,L8529
  8518  171c04     ld HL,$041C
  851B  e37700     cmp (HL),$00
  851E  85         jrs T,L8525
  851F  88         jrs T,L8529
L8520:
  8520  e0e87700   cmp ($E8),$00
  8524  a3         jrs F,L8529
L8525:
  8525  4671       set ($71).6
  8527  4b05       clr ($05).3
L8529:
  8529  db70       test ($70).3
  852B  a5         jrs F,L8532
  852C  4b71       clr ($71).3
  852E  2ef4       clr ($F4)
  8530  fb32       jr L8564
L8532:
  8532  d905       test ($05).1
  8534  e071d4     xor CF,($71).4
  8537  d612       jr T,L854B
  8539  e071c4     cpl ($71).4
  853C  4b71       clr ($71).3
  853E  dc71       test ($71).4
  8540  84         jrs T,L8546
  8541  2cf4f3     ld ($F4),$F3
  8544  fb1e       jr L8564
L8546:
  8546  2cf4cd     ld ($F4),$CD
  8549  fb19       jr L8564
L854B:
  854B  4b71       clr ($71).3
  854D  d615       jr T,L8564
  854F  20f4       inc ($F4)
  8551  d711       jr F,L8564
  8553  24000000   ldw ($00),$0000
  8557  4205       set ($05).2
  8559  427c       set ($7C).2
  855B  2c7300     ld ($73),$00
  855E  447c       set ($7C).4
  8560  4d7c       clr ($7C).5
  8562  4e7c       clr ($7C).6
L8564:
  8564  4fdb       clr ($DB).7
  8566  d713       jr F,L857B
  8568  4edb       clr ($DB).6
  856A  d73f       jr F,L85AB
  856C  4ddb       clr ($DB).5
  856E  82         jrs T,L8572
  856F  fefd85     jp L85FD
L8572:
  8572  4cdb       clr ($DB).4
  8574  82         jrs T,L8578
  8575  fe0986     jp L8609
L8578:
  8578  fe0986     jp L8609
L857B:
  857B  4871       clr ($71).0
  857D  4d7c       clr ($7C).5
  857F  49e0       clr ($E0).1
  8581  4ae0       clr ($E0).2
  8583  4cd9       clr ($D9).4
  8585  4dd9       clr ($D9).5
  8587  da7c       test ($7C).2
  8589  a1         jrs F,L858C
  858A  4c7c       clr ($7C).4
L858C:
  858C  48e1       clr ($E1).0
  858E  2ee9       clr ($E9)
  8590  4dda       clr ($DA).5
  8592  48da       clr ($DA).0
  8594  24e20000   ldw ($E2),$0000
  8598  24830000   ldw ($83),$0000
  859C  24850000   ldw ($85),$0000
  85A0  17f403     ld HL,$03F4
  85A3  f0dc13     ld ($DC),HL
  85A6  f0de13     ld ($DE),HL
  85A9  fb5e       jr L8609
L85AB:
  85AB  d9e1       test ($E1).1
  85AD  d742       jr F,L85F1
  85AF  dae1       test ($E1).2
  85B1  d73e       jr F,L85F1
  85B3  d9e0       test ($E0).1
  85B5  d73a       jr F,L85F1
  85B7  40e1       set ($E1).0
  85B9  17f003     ld HL,$03F0
  85BC  e658       ld A,(HL+)
  85BE  2ae9       ld ($E9),A
  85C0  d031       jr Z,L85F3
  85C2  e08514     ld WA,($85)
  85C5  e83f0000   cmp WA,$0000
  85C9  d628       jr T,L85F3
  85CB  23         ld A,(HL)
  85CC  01         swap A
  85CD  740f       and A,$0F
  85CF  2a7d       ld ($7D),A
  85D1  e658       ld A,(HL+)
  85D3  740f       and A,$0F
  85D5  2a7f       ld ($7F),A
  85D7  e326ff     ld ($FF),(HL)
  85DA  13         inc HL
  85DB  e35a       ld C,(HL)
  85DD  ea777f     cmp C,$7F
  85E0  d402       jr LE,L85E4
  85E2  3240       ld C,$40
L85E4:
  85E4  17f6cf     ld HL,$CFF6
  85E7  e5267a     ld ($7A),(HL+C)
  85EA  427b       set ($7B).2
  85EC  da7c       test ($7C).2
  85EE  a1         jrs F,L85F1
  85EF  4c7c       clr ($7C).4
L85F1:
  85F1  fb16       jr L8609
L85F3:
  85F3  23         ld A,(HL)
  85F4  740f       and A,$0F
  85F6  83         jrs T,L85FB
  85F7  2a81       ld ($81),A
  85F9  417b       set ($7B).1
L85FB:
  85FB  fb0c       jr L8609
L85FD:
  85FD  dae1       test ($E1).2
  85FF  a4         jrs F,L8605
  8600  d9e1       test ($E1).1
  8602  83         jrs T,L8607
  8603  45da       set ($DA).5
L8605:
  8605  43e1       set ($E1).3
L8607:
  8607  fb00       jr L8609
L8609:
  8609  db70       test ($70).3
  860B  d64f       jr T,L865C
  860D  2273       ld A,($73)
  860F  d003       jr Z,L8614
  8611  fe7a8d     jp L8D7A
L8614:
  8614  22f5       ld A,($F5)
  8616  d003       jr Z,L861B
  8618  fee086     jp L86E0
L861B:
  861B  4be1       clr ($E1).3
  861D  8e         jrs T,L862D
  861E  d87c       test ($7C).0
  8620  82         jrs T,L8624
  8621  dad9       test ($D9).2
  8623  88         jrs T,L862D
L8624:
  8624  4e7c       clr ($7C).6
  8626  4cda       clr ($DA).4
  8628  da7c       test ($7C).2
  862A  a1         jrs F,L862D
  862B  4c7c       clr ($7C).4
L862D:
  862D  4ae1       clr ($E1).2
  862F  49e1       clr ($E1).1
  8631  dee1       test ($E1).6
  8633  89         jrs T,L863E
  8634  dfd9       test ($D9).7
  8636  a3         jrs F,L863B
  8637  4ee1       clr ($E1).6
  8639  47db       set ($DB).7
L863B:
  863B  fe7a8d     jp L8D7A
L863E:
  863E  22e9       ld A,($E9)
  8640  d008       jr Z,L864A
  8642  4b70       clr ($70).3
  8644  2cf6f4     ld ($F6),$F4
  8647  fe7a8d     jp L8D7A
L864A:
  864A  dfd9       test ($D9).7
  864C  ab         jrs F,L8659
  864D  d87c       test ($7C).0
  864F  82         jrs T,L8653
  8650  dad9       test ($D9).2
  8652  85         jrs T,L8659
L8653:
  8653  4e7c       clr ($7C).6
  8655  4b70       clr ($70).3
  8657  4cda       clr ($DA).4
L8659:
  8659  fe7a8d     jp L8D7A
L865C:
  865C  d87c       test ($7C).0
  865E  82         jrs T,L8662
  865F  fe7a8d     jp L8D7A
L8662:
  8662  da7c       test ($7C).2
  8664  82         jrs T,L8668
  8665  fe7a8d     jp L8D7A
L8668:
  8668  d97c       test ($7C).1
  866A  82         jrs T,L866E
  866B  fe7a8d     jp L8D7A
L866E:
  866E  487b       clr ($7B).0
  8670  d638       jr T,L86AA
  8672  d87c       test ($7C).0
  8674  af         jrs F,L8685
  8675  2c0e01     ld ($0E),$01
  8678  460e       set ($0E).6
L867A:
  867A  df0e       test ($0E).7
  867C  9c         jrs T,L867A
  867D  220f       ld A,($0F)
  867F  171b04     ld HL,$041B
  8682  2b         ld (HL),A
  8683  47e1       set ($E1).7
L8685:
  8685  2c7311     ld ($73),$11
  8688  4370       set ($70).3
  868A  467c       set ($7C).6
  868C  4a70       clr ($70).2
  868E  2efe       clr ($FE)
  8690  0f01       ld RBS,1
  8692  33eb       ld B,$EB
  8694  140000     ld WA,$0000
  8697  f00010     ld ($00),WA
  869A  176103     ld HL,$0361
  869D  168403     ld DE,$0384
  86A0  0f00       ld RBS,0
  86A2  2c1418     ld ($14),$18
  86A5  4a05       clr ($05).2
  86A7  fe7a8d     jp L8D7A
L86AA:
  86AA  497b       clr ($7B).1
  86AC  d617       jr T,L86C5
  86AE  42e1       set ($E1).2
  86B0  268180     ld ($80),($81)
  86B3  2c7316     ld ($73),$16
  86B6  2efe       clr ($FE)
  86B8  2e72       clr ($72)
  86BA  4a70       clr ($70).2
  86BC  4a05       clr ($05).2
  86BE  4370       set ($70).3
  86C0  467c       set ($7C).6
  86C2  fe7a8d     jp L8D7A
L86C5:
  86C5  22f5       ld A,($F5)
  86C7  d117       jr NZ,L86E0
  86C9  d802       test ($02).0
  86CB  d713       jr F,L86E0
  86CD  d802       test ($02).0
  86CF  af         jrs F,L86E0
  86D0  42e1       set ($E1).2
  86D2  2c7317     ld ($73),$17
  86D5  4a05       clr ($05).2
  86D7  4370       set ($70).3
  86D9  467c       set ($7C).6
  86DB  2efe       clr ($FE)
  86DD  fe7a8d     jp L8D7A
L86E0:
  86E0  da7b       test ($7B).2
  86E2  a2         jrs F,L86E6
  86E3  fe7a8d     jp L8D7A
L86E6:
  86E6  e0f67701   cmp ($F6),$01
  86EA  88         jrs T,L86F4
  86EB  22f6       ld A,($F6)
  86ED  d003       jr Z,L86F2
  86EF  fe7a8d     jp L8D7A
L86F2:
  86F2  20f6       inc ($F6)
L86F4:
  86F4  4a7b       clr ($7B).2
  86F6  483a       di
  86F8  2c0e00     ld ($0E),$00
  86FB  460e       set ($0E).6
L86FD:
  86FD  df0e       test ($0E).7
  86FF  9c         jrs T,L86FD
  8700  e00f5a     ld C,($0F)
  8703  403a       ei
  8705  f0fd52     ld ($FD),C
  8708  ea7734     cmp C,$34
  870B  d405       jr LE,L8712
  870D  ea77d7     cmp C,$D7
  8710  d40b       jr LE,L871D
L8712:
  8712  24000000   ldw ($00),$0000
  8716  4205       set ($05).2
  8718  417c       set ($7C).1
  871A  fe7a8d     jp L8D7A
L871D:
  871D  14f6ce     ld WA,$CEF6
  8720  3300       ld B,$00
  8722  e931       add WA,BC
  8724  e817       ld HL,WA
  8726  23         ld A,(HL)
  8727  2a79       ld ($79),A
  8729  797a       add A,($7A)
  872B  2a78       ld ($78),A
  872D  1476d0     ld WA,$D076
  8730  3300       ld B,$00
  8732  e931       add WA,BC
  8734  e817       ld HL,WA
  8736  e326f9     ld ($F9),(HL)
  8739  41e1       set ($E1).1
  873B  4c70       clr ($70).4
  873D  4670       set ($70).6
  873F  24740001   ldw ($74),$0100
  8743  24760001   ldw ($76),$0100
  8747  24830000   ldw ($83),$0000
  874B  2cf813     ld ($F8),$13
  874E  2ea7       clr ($A7)
  8750  2ea8       clr ($A8)
  8752  2ea9       clr ($A9)
  8754  2eaa       clr ($AA)
  8756  2eab       clr ($AB)
  8758  2eac       clr ($AC)
  875A  2ead       clr ($AD)
  875C  2eae       clr ($AE)
  875E  2eaf       clr ($AF)
  8760  2eb0       clr ($B0)
  8762  2eb1       clr ($B1)
  8764  2eb2       clr ($B2)
  8766  2eb3       clr ($B3)
  8768  2eb4       clr ($B4)
  876A  2eb5       clr ($B5)
  876C  2eb6       clr ($B6)
  876E  26b860     ld ($60),($B8)
  8771  26ba61     ld ($61),($BA)
  8774  26bc62     ld ($62),($BC)
  8777  26be63     ld ($63),($BE)
  877A  26c064     ld ($64),($C0)
  877D  26c265     ld ($65),($C2)
  8780  26c466     ld ($66),($C4)
  8783  26c667     ld ($67),($C6)
  8786  26c868     ld ($68),($C8)
  8789  26ca69     ld ($69),($CA)
  878C  26cc6a     ld ($6A),($CC)
  878F  26ce6b     ld ($6B),($CE)
  8792  26d06c     ld ($6C),($D0)
  8795  26d26d     ld ($6D),($D2)
  8798  26d46e     ld ($6E),($D4)
  879B  26d66f     ld ($6F),($D6)
  879E  2efc       clr ($FC)
  87A0  171904     ld HL,$0419
  87A3  2260       ld A,($60)
  87A5  d146       jr NZ,L87ED
  87A7  2261       ld A,($61)
  87A9  d142       jr NZ,L87ED
  87AB  2262       ld A,($62)
  87AD  d13e       jr NZ,L87ED
  87AF  2263       ld A,($63)
  87B1  d13a       jr NZ,L87ED
  87B3  2264       ld A,($64)
  87B5  d136       jr NZ,L87ED
  87B7  2265       ld A,($65)
  87B9  d132       jr NZ,L87ED
  87BB  2266       ld A,($66)
  87BD  d12e       jr NZ,L87ED
  87BF  2267       ld A,($67)
  87C1  d12a       jr NZ,L87ED
  87C3  2268       ld A,($68)
  87C5  d126       jr NZ,L87ED
  87C7  2269       ld A,($69)
  87C9  d122       jr NZ,L87ED
  87CB  226a       ld A,($6A)
  87CD  d11e       jr NZ,L87ED
  87CF  226b       ld A,($6B)
  87D1  d11a       jr NZ,L87ED
  87D3  226c       ld A,($6C)
  87D5  d116       jr NZ,L87ED
  87D7  226d       ld A,($6D)
  87D9  d112       jr NZ,L87ED
  87DB  226e       ld A,($6E)
  87DD  d10e       jr NZ,L87ED
  87DF  226f       ld A,($6F)
  87E1  d10a       jr NZ,L87ED
  87E3  257bdc     ldw (HL),$DC7B
  87E6  42da       set ($DA).2
  87E8  171e04     ld HL,$041E
  87EB  2f         clr (HL)
  87EC  8f         jrs T,L87FD
L87ED:
  87ED  2588db     ldw (HL),$DB88
  87F0  4ada       clr ($DA).2
  87F2  171e04     ld HL,$041E
  87F5  21         inc (HL)
  87F6  e37728     cmp (HL),$28
  87F9  d402       jr LE,L87FD
  87FB  2d28       ld (HL),$28
L87FD:
  87FD  fc5ea4     call SA45E
  8800  e07616     ld DE,($76)
  8803  fcc2b9     call SB9C2
  8806  2e82       clr ($82)
L8808:
  8808  fc51ba     call SBA51
  880B  fc39bb     call SBB39
  880E  166002     ld DE,$0260
  8811  fcedbb     call SBBED
  8814  166002     ld DE,$0260
  8817  2282       ld A,($82)
  8819  01         swap A
  881A  3100       ld W,$00
  881C  ea31       add WA,DE
  881E  e817       ld HL,WA
  8820  e35a       ld C,(HL)
  8822  1776d1     ld HL,$D176
  8825  e558       ld A,(HL+C)
  8827  d021       jr Z,L884A
  8829  40fa       set ($FA).0
  882B  d71f       jr F,L884C
  882D  e0a77703   cmp ($A7),$03
  8831  d519       jr GT,L884C
  8833  e0fd5a     ld C,($FD)
  8836  3300       ld B,$00
  8838  ea1c       shlc C
  883A  eb1e       rolc B
  883C  1476d2     ld WA,$D276
  883F  e931       add WA,BC
  8841  e817       ld HL,WA
  8843  e314       ld WA,(HL)
  8845  e0b717     ld HL,($B7)
  8848  fb13       jr L885D
L884A:
  884A  22f9       ld A,($F9)
L884C:
  884C  e0b717     ld HL,($B7)
  884F  e8df       test A.7
  8851  88         jrs T,L885B
  8852  31ff       ld W,$FF
  8854  eb31       add WA,HL
  8856  8b         jrs T,L8863
  8857  140000     ld WA,$0000
  885A  87         jrs T,L8863
L885B:
  885B  3100       ld W,$00
L885D:
  885D  eb31       add WA,HL
  885F  a2         jrs F,L8863
  8860  14ffff     ld WA,$FFFF
L8863:
  8863  f0b710     ld ($B7),WA
  8866  12         inc DE
  8867  2282       ld A,($82)
  8869  01         swap A
  886A  3100       ld W,$00
  886C  ea31       add WA,DE
  886E  e817       ld HL,WA
  8870  e35a       ld C,(HL)
  8872  1776d1     ld HL,$D176
  8875  e558       ld A,(HL+C)
  8877  d021       jr Z,L889A
  8879  41fa       set ($FA).1
  887B  d71f       jr F,L889C
  887D  e0a87703   cmp ($A8),$03
  8881  d519       jr GT,L889C
  8883  e0fd5a     ld C,($FD)
  8886  3300       ld B,$00
  8888  ea1c       shlc C
  888A  eb1e       rolc B
  888C  1476d2     ld WA,$D276
  888F  e931       add WA,BC
  8891  e817       ld HL,WA
  8893  e314       ld WA,(HL)
  8895  e0b917     ld HL,($B9)
  8898  fb13       jr L88AD
L889A:
  889A  22f9       ld A,($F9)
L889C:
  889C  e0b917     ld HL,($B9)
  889F  e8df       test A.7
  88A1  88         jrs T,L88AB
  88A2  31ff       ld W,$FF
  88A4  eb31       add WA,HL
  88A6  8b         jrs T,L88B3
  88A7  140000     ld WA,$0000
  88AA  87         jrs T,L88B3
L88AB:
  88AB  3100       ld W,$00
L88AD:
  88AD  eb31       add WA,HL
  88AF  a2         jrs F,L88B3
  88B0  14ffff     ld WA,$FFFF
L88B3:
  88B3  f0b910     ld ($B9),WA
  88B6  12         inc DE
  88B7  2282       ld A,($82)
  88B9  01         swap A
  88BA  3100       ld W,$00
  88BC  ea31       add WA,DE
  88BE  e817       ld HL,WA
  88C0  e35a       ld C,(HL)
  88C2  1776d1     ld HL,$D176
  88C5  e558       ld A,(HL+C)
  88C7  d021       jr Z,L88EA
  88C9  42fa       set ($FA).2
  88CB  d71f       jr F,L88EC
  88CD  e0a97703   cmp ($A9),$03
  88D1  d519       jr GT,L88EC
  88D3  e0fd5a     ld C,($FD)
  88D6  3300       ld B,$00
  88D8  ea1c       shlc C
  88DA  eb1e       rolc B
  88DC  1476d2     ld WA,$D276
  88DF  e931       add WA,BC
  88E1  e817       ld HL,WA
  88E3  e314       ld WA,(HL)
  88E5  e0bb17     ld HL,($BB)
  88E8  fb13       jr L88FD
L88EA:
  88EA  22f9       ld A,($F9)
L88EC:
  88EC  e0bb17     ld HL,($BB)
  88EF  e8df       test A.7
  88F1  88         jrs T,L88FB
  88F2  31ff       ld W,$FF
  88F4  eb31       add WA,HL
  88F6  8b         jrs T,L8903
  88F7  140000     ld WA,$0000
  88FA  87         jrs T,L8903
L88FB:
  88FB  3100       ld W,$00
L88FD:
  88FD  eb31       add WA,HL
  88FF  a2         jrs F,L8903
  8900  14ffff     ld WA,$FFFF
L8903:
  8903  f0bb10     ld ($BB),WA
  8906  12         inc DE
  8907  2282       ld A,($82)
  8909  01         swap A
  890A  3100       ld W,$00
  890C  ea31       add WA,DE
  890E  e817       ld HL,WA
  8910  e35a       ld C,(HL)
  8912  1776d1     ld HL,$D176
  8915  e558       ld A,(HL+C)
  8917  d021       jr Z,L893A
  8919  43fa       set ($FA).3
  891B  d71f       jr F,L893C
  891D  e0aa7703   cmp ($AA),$03
  8921  d519       jr GT,L893C
  8923  e0fd5a     ld C,($FD)
  8926  3300       ld B,$00
  8928  ea1c       shlc C
  892A  eb1e       rolc B
  892C  1476d2     ld WA,$D276
  892F  e931       add WA,BC
  8931  e817       ld HL,WA
  8933  e314       ld WA,(HL)
  8935  e0bd17     ld HL,($BD)
  8938  fb13       jr L894D
L893A:
  893A  22f9       ld A,($F9)
L893C:
  893C  e0bd17     ld HL,($BD)
  893F  e8df       test A.7
  8941  88         jrs T,L894B
  8942  31ff       ld W,$FF
  8944  eb31       add WA,HL
  8946  8b         jrs T,L8953
  8947  140000     ld WA,$0000
  894A  87         jrs T,L8953
L894B:
  894B  3100       ld W,$00
L894D:
  894D  eb31       add WA,HL
  894F  a2         jrs F,L8953
  8950  14ffff     ld WA,$FFFF
L8953:
  8953  f0bd10     ld ($BD),WA
  8956  12         inc DE
  8957  2282       ld A,($82)
  8959  01         swap A
  895A  3100       ld W,$00
  895C  ea31       add WA,DE
  895E  e817       ld HL,WA
  8960  e35a       ld C,(HL)
  8962  1776d1     ld HL,$D176
  8965  e558       ld A,(HL+C)
  8967  d021       jr Z,L898A
  8969  44fa       set ($FA).4
  896B  d71f       jr F,L898C
  896D  e0ab7703   cmp ($AB),$03
  8971  d519       jr GT,L898C
  8973  e0fd5a     ld C,($FD)
  8976  3300       ld B,$00
  8978  ea1c       shlc C
  897A  eb1e       rolc B
  897C  1476d2     ld WA,$D276
  897F  e931       add WA,BC
  8981  e817       ld HL,WA
  8983  e314       ld WA,(HL)
  8985  e0bf17     ld HL,($BF)
  8988  fb13       jr L899D
L898A:
  898A  22f9       ld A,($F9)
L898C:
  898C  e0bf17     ld HL,($BF)
  898F  e8df       test A.7
  8991  88         jrs T,L899B
  8992  31ff       ld W,$FF
  8994  eb31       add WA,HL
  8996  8b         jrs T,L89A3
  8997  140000     ld WA,$0000
  899A  87         jrs T,L89A3
L899B:
  899B  3100       ld W,$00
L899D:
  899D  eb31       add WA,HL
  899F  a2         jrs F,L89A3
  89A0  14ffff     ld WA,$FFFF
L89A3:
  89A3  f0bf10     ld ($BF),WA
  89A6  12         inc DE
  89A7  2282       ld A,($82)
  89A9  01         swap A
  89AA  3100       ld W,$00
  89AC  ea31       add WA,DE
  89AE  e817       ld HL,WA
  89B0  e35a       ld C,(HL)
  89B2  1776d1     ld HL,$D176
  89B5  e558       ld A,(HL+C)
  89B7  d021       jr Z,L89DA
  89B9  45fa       set ($FA).5
  89BB  d71f       jr F,L89DC
  89BD  e0ac7703   cmp ($AC),$03
  89C1  d519       jr GT,L89DC
  89C3  e0fd5a     ld C,($FD)
  89C6  3300       ld B,$00
  89C8  ea1c       shlc C
  89CA  eb1e       rolc B
  89CC  1476d2     ld WA,$D276
  89CF  e931       add WA,BC
  89D1  e817       ld HL,WA
  89D3  e314       ld WA,(HL)
  89D5  e0c117     ld HL,($C1)
  89D8  fb13       jr L89ED
L89DA:
  89DA  22f9       ld A,($F9)
L89DC:
  89DC  e0c117     ld HL,($C1)
  89DF  e8df       test A.7
  89E1  88         jrs T,L89EB
  89E2  31ff       ld W,$FF
  89E4  eb31       add WA,HL
  89E6  8b         jrs T,L89F3
  89E7  140000     ld WA,$0000
  89EA  87         jrs T,L89F3
L89EB:
  89EB  3100       ld W,$00
L89ED:
  89ED  eb31       add WA,HL
  89EF  a2         jrs F,L89F3
  89F0  14ffff     ld WA,$FFFF
L89F3:
  89F3  f0c110     ld ($C1),WA
  89F6  12         inc DE
  89F7  2282       ld A,($82)
  89F9  01         swap A
  89FA  3100       ld W,$00
  89FC  ea31       add WA,DE
  89FE  e817       ld HL,WA
  8A00  e35a       ld C,(HL)
  8A02  1776d1     ld HL,$D176
  8A05  e558       ld A,(HL+C)
  8A07  d021       jr Z,L8A2A
  8A09  46fa       set ($FA).6
  8A0B  d71f       jr F,L8A2C
  8A0D  e0ad7703   cmp ($AD),$03
  8A11  d519       jr GT,L8A2C
  8A13  e0fd5a     ld C,($FD)
  8A16  3300       ld B,$00
  8A18  ea1c       shlc C
  8A1A  eb1e       rolc B
  8A1C  1476d2     ld WA,$D276
  8A1F  e931       add WA,BC
  8A21  e817       ld HL,WA
  8A23  e314       ld WA,(HL)
  8A25  e0c317     ld HL,($C3)
  8A28  fb13       jr L8A3D
L8A2A:
  8A2A  22f9       ld A,($F9)
L8A2C:
  8A2C  e0c317     ld HL,($C3)
  8A2F  e8df       test A.7
  8A31  88         jrs T,L8A3B
  8A32  31ff       ld W,$FF
  8A34  eb31       add WA,HL
  8A36  8b         jrs T,L8A43
  8A37  140000     ld WA,$0000
  8A3A  87         jrs T,L8A43
L8A3B:
  8A3B  3100       ld W,$00
L8A3D:
  8A3D  eb31       add WA,HL
  8A3F  a2         jrs F,L8A43
  8A40  14ffff     ld WA,$FFFF
L8A43:
  8A43  f0c310     ld ($C3),WA
  8A46  12         inc DE
  8A47  2282       ld A,($82)
  8A49  01         swap A
  8A4A  3100       ld W,$00
  8A4C  ea31       add WA,DE
  8A4E  e817       ld HL,WA
  8A50  e35a       ld C,(HL)
  8A52  1776d1     ld HL,$D176
  8A55  e558       ld A,(HL+C)
  8A57  d021       jr Z,L8A7A
  8A59  47fa       set ($FA).7
  8A5B  d71f       jr F,L8A7C
  8A5D  e0ae7703   cmp ($AE),$03
  8A61  d519       jr GT,L8A7C
  8A63  e0fd5a     ld C,($FD)
  8A66  3300       ld B,$00
  8A68  ea1c       shlc C
  8A6A  eb1e       rolc B
  8A6C  1476d2     ld WA,$D276
  8A6F  e931       add WA,BC
  8A71  e817       ld HL,WA
  8A73  e314       ld WA,(HL)
  8A75  e0c517     ld HL,($C5)
  8A78  fb13       jr L8A8D
L8A7A:
  8A7A  22f9       ld A,($F9)
L8A7C:
  8A7C  e0c517     ld HL,($C5)
  8A7F  e8df       test A.7
  8A81  88         jrs T,L8A8B
  8A82  31ff       ld W,$FF
  8A84  eb31       add WA,HL
  8A86  8b         jrs T,L8A93
  8A87  140000     ld WA,$0000
  8A8A  87         jrs T,L8A93
L8A8B:
  8A8B  3100       ld W,$00
L8A8D:
  8A8D  eb31       add WA,HL
  8A8F  a2         jrs F,L8A93
  8A90  14ffff     ld WA,$FFFF
L8A93:
  8A93  f0c510     ld ($C5),WA
  8A96  12         inc DE
  8A97  2282       ld A,($82)
  8A99  01         swap A
  8A9A  3100       ld W,$00
  8A9C  ea31       add WA,DE
  8A9E  e817       ld HL,WA
  8AA0  e35a       ld C,(HL)
  8AA2  1776d1     ld HL,$D176
  8AA5  e558       ld A,(HL+C)
  8AA7  d021       jr Z,L8ACA
  8AA9  40fb       set ($FB).0
  8AAB  d71f       jr F,L8ACC
  8AAD  e0af7703   cmp ($AF),$03
  8AB1  d519       jr GT,L8ACC
  8AB3  e0fd5a     ld C,($FD)
  8AB6  3300       ld B,$00
  8AB8  ea1c       shlc C
  8ABA  eb1e       rolc B
  8ABC  1476d2     ld WA,$D276
  8ABF  e931       add WA,BC
  8AC1  e817       ld HL,WA
  8AC3  e314       ld WA,(HL)
  8AC5  e0c717     ld HL,($C7)
  8AC8  fb13       jr L8ADD
L8ACA:
  8ACA  22f9       ld A,($F9)
L8ACC:
  8ACC  e0c717     ld HL,($C7)
  8ACF  e8df       test A.7
  8AD1  88         jrs T,L8ADB
  8AD2  31ff       ld W,$FF
  8AD4  eb31       add WA,HL
  8AD6  8b         jrs T,L8AE3
  8AD7  140000     ld WA,$0000
  8ADA  87         jrs T,L8AE3
L8ADB:
  8ADB  3100       ld W,$00
L8ADD:
  8ADD  eb31       add WA,HL
  8ADF  a2         jrs F,L8AE3
  8AE0  14ffff     ld WA,$FFFF
L8AE3:
  8AE3  f0c710     ld ($C7),WA
  8AE6  12         inc DE
  8AE7  2282       ld A,($82)
  8AE9  01         swap A
  8AEA  3100       ld W,$00
  8AEC  ea31       add WA,DE
  8AEE  e817       ld HL,WA
  8AF0  e35a       ld C,(HL)
  8AF2  1776d1     ld HL,$D176
  8AF5  e558       ld A,(HL+C)
  8AF7  d021       jr Z,L8B1A
  8AF9  41fb       set ($FB).1
  8AFB  d71f       jr F,L8B1C
  8AFD  e0b07703   cmp ($B0),$03
  8B01  d519       jr GT,L8B1C
  8B03  e0fd5a     ld C,($FD)
  8B06  3300       ld B,$00
  8B08  ea1c       shlc C
  8B0A  eb1e       rolc B
  8B0C  1476d2     ld WA,$D276
  8B0F  e931       add WA,BC
  8B11  e817       ld HL,WA
  8B13  e314       ld WA,(HL)
  8B15  e0c917     ld HL,($C9)
  8B18  fb13       jr L8B2D
L8B1A:
  8B1A  22f9       ld A,($F9)
L8B1C:
  8B1C  e0c917     ld HL,($C9)
  8B1F  e8df       test A.7
  8B21  88         jrs T,L8B2B
  8B22  31ff       ld W,$FF
  8B24  eb31       add WA,HL
  8B26  8b         jrs T,L8B33
  8B27  140000     ld WA,$0000
  8B2A  87         jrs T,L8B33
L8B2B:
  8B2B  3100       ld W,$00
L8B2D:
  8B2D  eb31       add WA,HL
  8B2F  a2         jrs F,L8B33
  8B30  14ffff     ld WA,$FFFF
L8B33:
  8B33  f0c910     ld ($C9),WA
  8B36  12         inc DE
  8B37  2282       ld A,($82)
  8B39  01         swap A
  8B3A  3100       ld W,$00
  8B3C  ea31       add WA,DE
  8B3E  e817       ld HL,WA
  8B40  e35a       ld C,(HL)
  8B42  1776d1     ld HL,$D176
  8B45  e558       ld A,(HL+C)
  8B47  d021       jr Z,L8B6A
  8B49  42fb       set ($FB).2
  8B4B  d71f       jr F,L8B6C
  8B4D  e0b17703   cmp ($B1),$03
  8B51  d519       jr GT,L8B6C
  8B53  e0fd5a     ld C,($FD)
  8B56  3300       ld B,$00
  8B58  ea1c       shlc C
  8B5A  eb1e       rolc B
  8B5C  1476d2     ld WA,$D276
  8B5F  e931       add WA,BC
  8B61  e817       ld HL,WA
  8B63  e314       ld WA,(HL)
  8B65  e0cb17     ld HL,($CB)
  8B68  fb13       jr L8B7D
L8B6A:
  8B6A  22f9       ld A,($F9)
L8B6C:
  8B6C  e0cb17     ld HL,($CB)
  8B6F  e8df       test A.7
  8B71  88         jrs T,L8B7B
  8B72  31ff       ld W,$FF
  8B74  eb31       add WA,HL
  8B76  8b         jrs T,L8B83
  8B77  140000     ld WA,$0000
  8B7A  87         jrs T,L8B83
L8B7B:
  8B7B  3100       ld W,$00
L8B7D:
  8B7D  eb31       add WA,HL
  8B7F  a2         jrs F,L8B83
  8B80  14ffff     ld WA,$FFFF
L8B83:
  8B83  f0cb10     ld ($CB),WA
  8B86  12         inc DE
  8B87  2282       ld A,($82)
  8B89  01         swap A
  8B8A  3100       ld W,$00
  8B8C  ea31       add WA,DE
  8B8E  e817       ld HL,WA
  8B90  e35a       ld C,(HL)
  8B92  1776d1     ld HL,$D176
  8B95  e558       ld A,(HL+C)
  8B97  d021       jr Z,L8BBA
  8B99  43fb       set ($FB).3
  8B9B  d71f       jr F,L8BBC
  8B9D  e0b27703   cmp ($B2),$03
  8BA1  d519       jr GT,L8BBC
  8BA3  e0fd5a     ld C,($FD)
  8BA6  3300       ld B,$00
  8BA8  ea1c       shlc C
  8BAA  eb1e       rolc B
  8BAC  1476d2     ld WA,$D276
  8BAF  e931       add WA,BC
  8BB1  e817       ld HL,WA
  8BB3  e314       ld WA,(HL)
  8BB5  e0cd17     ld HL,($CD)
  8BB8  fb13       jr L8BCD
L8BBA:
  8BBA  22f9       ld A,($F9)
L8BBC:
  8BBC  e0cd17     ld HL,($CD)
  8BBF  e8df       test A.7
  8BC1  88         jrs T,L8BCB
  8BC2  31ff       ld W,$FF
  8BC4  eb31       add WA,HL
  8BC6  8b         jrs T,L8BD3
  8BC7  140000     ld WA,$0000
  8BCA  87         jrs T,L8BD3
L8BCB:
  8BCB  3100       ld W,$00
L8BCD:
  8BCD  eb31       add WA,HL
  8BCF  a2         jrs F,L8BD3
  8BD0  14ffff     ld WA,$FFFF
L8BD3:
  8BD3  f0cd10     ld ($CD),WA
  8BD6  12         inc DE
  8BD7  2282       ld A,($82)
  8BD9  01         swap A
  8BDA  3100       ld W,$00
  8BDC  ea31       add WA,DE
  8BDE  e817       ld HL,WA
  8BE0  e35a       ld C,(HL)
  8BE2  1776d1     ld HL,$D176
  8BE5  e558       ld A,(HL+C)
  8BE7  d021       jr Z,L8C0A
  8BE9  44fb       set ($FB).4
  8BEB  d71f       jr F,L8C0C
  8BED  e0b37703   cmp ($B3),$03
  8BF1  d519       jr GT,L8C0C
  8BF3  e0fd5a     ld C,($FD)
  8BF6  3300       ld B,$00
  8BF8  ea1c       shlc C
  8BFA  eb1e       rolc B
  8BFC  1476d2     ld WA,$D276
  8BFF  e931       add WA,BC
  8C01  e817       ld HL,WA
  8C03  e314       ld WA,(HL)
  8C05  e0cf17     ld HL,($CF)
  8C08  fb13       jr L8C1D
L8C0A:
  8C0A  22f9       ld A,($F9)
L8C0C:
  8C0C  e0cf17     ld HL,($CF)
  8C0F  e8df       test A.7
  8C11  88         jrs T,L8C1B
  8C12  31ff       ld W,$FF
  8C14  eb31       add WA,HL
  8C16  8b         jrs T,L8C23
  8C17  140000     ld WA,$0000
  8C1A  87         jrs T,L8C23
L8C1B:
  8C1B  3100       ld W,$00
L8C1D:
  8C1D  eb31       add WA,HL
  8C1F  a2         jrs F,L8C23
  8C20  14ffff     ld WA,$FFFF
L8C23:
  8C23  f0cf10     ld ($CF),WA
  8C26  12         inc DE
  8C27  2282       ld A,($82)
  8C29  01         swap A
  8C2A  3100       ld W,$00
  8C2C  ea31       add WA,DE
  8C2E  e817       ld HL,WA
  8C30  e35a       ld C,(HL)
  8C32  1776d1     ld HL,$D176
  8C35  e558       ld A,(HL+C)
  8C37  d021       jr Z,L8C5A
  8C39  45fb       set ($FB).5
  8C3B  d71f       jr F,L8C5C
  8C3D  e0b47703   cmp ($B4),$03
  8C41  d519       jr GT,L8C5C
  8C43  e0fd5a     ld C,($FD)
  8C46  3300       ld B,$00
  8C48  ea1c       shlc C
  8C4A  eb1e       rolc B
  8C4C  1476d2     ld WA,$D276
  8C4F  e931       add WA,BC
  8C51  e817       ld HL,WA
  8C53  e314       ld WA,(HL)
  8C55  e0d117     ld HL,($D1)
  8C58  fb13       jr L8C6D
L8C5A:
  8C5A  22f9       ld A,($F9)
L8C5C:
  8C5C  e0d117     ld HL,($D1)
  8C5F  e8df       test A.7
  8C61  88         jrs T,L8C6B
  8C62  31ff       ld W,$FF
  8C64  eb31       add WA,HL
  8C66  8b         jrs T,L8C73
  8C67  140000     ld WA,$0000
  8C6A  87         jrs T,L8C73
L8C6B:
  8C6B  3100       ld W,$00
L8C6D:
  8C6D  eb31       add WA,HL
  8C6F  a2         jrs F,L8C73
  8C70  14ffff     ld WA,$FFFF
L8C73:
  8C73  f0d110     ld ($D1),WA
  8C76  12         inc DE
  8C77  2282       ld A,($82)
  8C79  01         swap A
  8C7A  3100       ld W,$00
  8C7C  ea31       add WA,DE
  8C7E  e817       ld HL,WA
  8C80  e35a       ld C,(HL)
  8C82  1776d1     ld HL,$D176
  8C85  e558       ld A,(HL+C)
  8C87  d021       jr Z,L8CAA
  8C89  46fb       set ($FB).6
  8C8B  d71f       jr F,L8CAC
  8C8D  e0b57703   cmp ($B5),$03
  8C91  d519       jr GT,L8CAC
  8C93  e0fd5a     ld C,($FD)
  8C96  3300       ld B,$00
  8C98  ea1c       shlc C
  8C9A  eb1e       rolc B
  8C9C  1476d2     ld WA,$D276
  8C9F  e931       add WA,BC
  8CA1  e817       ld HL,WA
  8CA3  e314       ld WA,(HL)
  8CA5  e0d317     ld HL,($D3)
  8CA8  fb13       jr L8CBD
L8CAA:
  8CAA  22f9       ld A,($F9)
L8CAC:
  8CAC  e0d317     ld HL,($D3)
  8CAF  e8df       test A.7
  8CB1  88         jrs T,L8CBB
  8CB2  31ff       ld W,$FF
  8CB4  eb31       add WA,HL
  8CB6  8b         jrs T,L8CC3
  8CB7  140000     ld WA,$0000
  8CBA  87         jrs T,L8CC3
L8CBB:
  8CBB  3100       ld W,$00
L8CBD:
  8CBD  eb31       add WA,HL
  8CBF  a2         jrs F,L8CC3
  8CC0  14ffff     ld WA,$FFFF
L8CC3:
  8CC3  f0d310     ld ($D3),WA
  8CC6  12         inc DE
  8CC7  2282       ld A,($82)
  8CC9  01         swap A
  8CCA  3100       ld W,$00
  8CCC  ea31       add WA,DE
  8CCE  e817       ld HL,WA
  8CD0  e35a       ld C,(HL)
  8CD2  1776d1     ld HL,$D176
  8CD5  e558       ld A,(HL+C)
  8CD7  d021       jr Z,L8CFA
  8CD9  47fb       set ($FB).7
  8CDB  d71f       jr F,L8CFC
  8CDD  e0b67703   cmp ($B6),$03
  8CE1  d519       jr GT,L8CFC
  8CE3  e0fd5a     ld C,($FD)
  8CE6  3300       ld B,$00
  8CE8  ea1c       shlc C
  8CEA  eb1e       rolc B
  8CEC  1476d2     ld WA,$D276
  8CEF  e931       add WA,BC
  8CF1  e817       ld HL,WA
  8CF3  e314       ld WA,(HL)
  8CF5  e0d517     ld HL,($D5)
  8CF8  fb13       jr L8D0D
L8CFA:
  8CFA  22f9       ld A,($F9)
L8CFC:
  8CFC  e0d517     ld HL,($D5)
  8CFF  e8df       test A.7
  8D01  88         jrs T,L8D0B
  8D02  31ff       ld W,$FF
  8D04  eb31       add WA,HL
  8D06  8b         jrs T,L8D13
  8D07  140000     ld WA,$0000
  8D0A  87         jrs T,L8D13
L8D0B:
  8D0B  3100       ld W,$00
L8D0D:
  8D0D  eb31       add WA,HL
  8D0F  a2         jrs F,L8D13
  8D10  14ffff     ld WA,$FFFF
L8D13:
  8D13  f0d510     ld ($D5),WA
  8D16  2082       inc ($82)
  8D18  e0827708   cmp ($82),$08
  8D1C  d303       jr CC,L8D21
  8D1E  fe0888     jp L8808
L8D21:
  8D21  166002     ld DE,$0260
  8D24  fcbebe     call SBEBE
  8D27  fc1dbf     call SBF1D
  8D2A  fc7cbf     call SBF7C
  8D2D  fcdbbf     call SBFDB
  8D30  fc3ac0     call SC03A
  8D33  fc99c0     call SC099
  8D36  fcf8c0     call SC0F8
  8D39  fc57c1     call SC157
  8D3C  fcb6c1     call SC1B6
  8D3F  fc15c2     call SC215
  8D42  fc74c2     call SC274
  8D45  fcd3c2     call SC2D3
  8D48  fc32c3     call SC332
  8D4B  fc91c3     call SC391
  8D4E  fcf0c3     call SC3F0
  8D51  fc4fc4     call SC44F
  8D54  4070       set ($70).0
  8D56  4970       clr ($70).1
  8D58  227d       ld A,($7D)
  8D5A  d013       jr Z,L8D6F
  8D5C  2a7e       ld ($7E),A
  8D5E  2e7d       clr ($7D)
  8D60  2c7314     ld ($73),$14
  8D63  4a70       clr ($70).2
  8D65  2efe       clr ($FE)
  8D67  4a05       clr ($05).2
  8D69  4370       set ($70).3
  8D6B  467c       set ($7C).6
  8D6D  fb0b       jr L8D7A
L8D6F:
  8D6F  2e72       clr ($72)
  8D71  2c7312     ld ($73),$12
  8D74  4a05       clr ($05).2
  8D76  4370       set ($70).3
  8D78  467c       set ($7C).6
L8D7A:
  8D7A  e07414     ld WA,($74)
  8D7D  e07616     ld DE,($76)
  8D80  ea37       cmp WA,DE
  8D82  a2         jrs F,L8D86
  8D83  fe9da2     jp LA29D
L8D86:
  8D86  d870       test ($70).0
  8D88  82         jrs T,L8D8C
  8D89  fe9397     jp L9793
L8D8C:
  8D8C  174002     ld HL,$0240
  8D8F  e227       ld (HL),(DE)
  8D91  13         inc HL
  8D92  12         inc DE
  8D93  e227       ld (HL),(DE)
  8D95  13         inc HL
  8D96  12         inc DE
  8D97  e227       ld (HL),(DE)
  8D99  13         inc HL
  8D9A  12         inc DE
  8D9B  e227       ld (HL),(DE)
  8D9D  13         inc HL
  8D9E  12         inc DE
  8D9F  e227       ld (HL),(DE)
  8DA1  13         inc HL
  8DA2  12         inc DE
  8DA3  e227       ld (HL),(DE)
  8DA5  13         inc HL
  8DA6  12         inc DE
  8DA7  e227       ld (HL),(DE)
  8DA9  13         inc HL
  8DAA  12         inc DE
  8DAB  e227       ld (HL),(DE)
  8DAD  13         inc HL
  8DAE  12         inc DE
  8DAF  e227       ld (HL),(DE)
  8DB1  13         inc HL
  8DB2  12         inc DE
  8DB3  e227       ld (HL),(DE)
  8DB5  13         inc HL
  8DB6  12         inc DE
  8DB7  e227       ld (HL),(DE)
  8DB9  13         inc HL
  8DBA  12         inc DE
  8DBB  e227       ld (HL),(DE)
  8DBD  13         inc HL
  8DBE  12         inc DE
  8DBF  e227       ld (HL),(DE)
  8DC1  13         inc HL
  8DC2  12         inc DE
  8DC3  e227       ld (HL),(DE)
  8DC5  13         inc HL
  8DC6  12         inc DE
  8DC7  e227       ld (HL),(DE)
  8DC9  13         inc HL
  8DCA  12         inc DE
  8DCB  e227       ld (HL),(DE)
  8DCD  13         inc HL
  8DCE  12         inc DE
  8DCF  e227       ld (HL),(DE)
  8DD1  13         inc HL
  8DD2  12         inc DE
  8DD3  e227       ld (HL),(DE)
  8DD5  13         inc HL
  8DD6  12         inc DE
  8DD7  e227       ld (HL),(DE)
  8DD9  13         inc HL
  8DDA  12         inc DE
  8DDB  e227       ld (HL),(DE)
  8DDD  13         inc HL
  8DDE  12         inc DE
  8DDF  e227       ld (HL),(DE)
  8DE1  13         inc HL
  8DE2  12         inc DE
  8DE3  e227       ld (HL),(DE)
  8DE5  13         inc HL
  8DE6  12         inc DE
  8DE7  e227       ld (HL),(DE)
  8DE9  13         inc HL
  8DEA  12         inc DE
  8DEB  e227       ld (HL),(DE)
  8DED  13         inc HL
  8DEE  12         inc DE
  8DEF  e227       ld (HL),(DE)
  8DF1  13         inc HL
  8DF2  12         inc DE
  8DF3  e227       ld (HL),(DE)
  8DF5  13         inc HL
  8DF6  12         inc DE
  8DF7  e227       ld (HL),(DE)
  8DF9  13         inc HL
  8DFA  12         inc DE
  8DFB  e227       ld (HL),(DE)
  8DFD  13         inc HL
  8DFE  12         inc DE
  8DFF  e227       ld (HL),(DE)
  8E01  13         inc HL
  8E02  12         inc DE
  8E03  e227       ld (HL),(DE)
  8E05  13         inc HL
  8E06  12         inc DE
  8E07  e227       ld (HL),(DE)
  8E09  13         inc HL
  8E0A  12         inc DE
  8E0B  e227       ld (HL),(DE)
  8E0D  12         inc DE
  8E0E  ea3f4002   cmp DE,$0240
  8E12  d203       jr CS,L8E17
  8E14  160001     ld DE,$0100
L8E17:
  8E17  f07612     ld ($76),DE
  8E1A  2e82       clr ($82)
L8E1C:
  8E1C  178700     ld HL,$0087
  8E1F  164002     ld DE,$0240
  8E22  3007       ld A,$07
  8E24  e0825a     ld C,($82)
  8E27  ea63       sub A,C
  8E29  e89e       test (DE).A
  8E2B  e3c8       ld (HL).0,CF
  8E2D  12         inc DE
  8E2E  e89e       test (DE).A
  8E30  e6c9       ld (HL+).1,CF
  8E32  12         inc DE
  8E33  e89e       test (DE).A
  8E35  e3c8       ld (HL).0,CF
  8E37  12         inc DE
  8E38  e89e       test (DE).A
  8E3A  e6c9       ld (HL+).1,CF
  8E3C  12         inc DE
  8E3D  e89e       test (DE).A
  8E3F  e3c8       ld (HL).0,CF
  8E41  12         inc DE
  8E42  e89e       test (DE).A
  8E44  e6c9       ld (HL+).1,CF
  8E46  12         inc DE
  8E47  e89e       test (DE).A
  8E49  e3c8       ld (HL).0,CF
  8E4B  12         inc DE
  8E4C  e89e       test (DE).A
  8E4E  e6c9       ld (HL+).1,CF
  8E50  12         inc DE
  8E51  e89e       test (DE).A
  8E53  e3c8       ld (HL).0,CF
  8E55  12         inc DE
  8E56  e89e       test (DE).A
  8E58  e6c9       ld (HL+).1,CF
  8E5A  12         inc DE
  8E5B  e89e       test (DE).A
  8E5D  e3c8       ld (HL).0,CF
  8E5F  12         inc DE
  8E60  e89e       test (DE).A
  8E62  e6c9       ld (HL+).1,CF
  8E64  12         inc DE
  8E65  e89e       test (DE).A
  8E67  e3c8       ld (HL).0,CF
  8E69  12         inc DE
  8E6A  e89e       test (DE).A
  8E6C  e6c9       ld (HL+).1,CF
  8E6E  12         inc DE
  8E6F  e89e       test (DE).A
  8E71  e3c8       ld (HL).0,CF
  8E73  12         inc DE
  8E74  e89e       test (DE).A
  8E76  e6c9       ld (HL+).1,CF
  8E78  12         inc DE
  8E79  e89e       test (DE).A
  8E7B  e3c8       ld (HL).0,CF
  8E7D  12         inc DE
  8E7E  e89e       test (DE).A
  8E80  e6c9       ld (HL+).1,CF
  8E82  12         inc DE
  8E83  e89e       test (DE).A
  8E85  e3c8       ld (HL).0,CF
  8E87  12         inc DE
  8E88  e89e       test (DE).A
  8E8A  e6c9       ld (HL+).1,CF
  8E8C  12         inc DE
  8E8D  e89e       test (DE).A
  8E8F  e3c8       ld (HL).0,CF
  8E91  12         inc DE
  8E92  e89e       test (DE).A
  8E94  e6c9       ld (HL+).1,CF
  8E96  12         inc DE
  8E97  e89e       test (DE).A
  8E99  e3c8       ld (HL).0,CF
  8E9B  12         inc DE
  8E9C  e89e       test (DE).A
  8E9E  e6c9       ld (HL+).1,CF
  8EA0  12         inc DE
  8EA1  e89e       test (DE).A
  8EA3  e3c8       ld (HL).0,CF
  8EA5  12         inc DE
  8EA6  e89e       test (DE).A
  8EA8  e6c9       ld (HL+).1,CF
  8EAA  12         inc DE
  8EAB  e89e       test (DE).A
  8EAD  e3c8       ld (HL).0,CF
  8EAF  12         inc DE
  8EB0  e89e       test (DE).A
  8EB2  e6c9       ld (HL+).1,CF
  8EB4  12         inc DE
  8EB5  e89e       test (DE).A
  8EB7  e3c8       ld (HL).0,CF
  8EB9  12         inc DE
  8EBA  e89e       test (DE).A
  8EBC  e6c9       ld (HL+).1,CF
  8EBE  12         inc DE
  8EBF  e89e       test (DE).A
  8EC1  e3c8       ld (HL).0,CF
  8EC3  12         inc DE
  8EC4  e89e       test (DE).A
  8EC6  e3c9       ld (HL).1,CF
  8EC8  22ff       ld A,($FF)
  8ECA  d037       jr Z,L8F03
  8ECC  74c0       and A,$C0
  8ECE  01         swap A
  8ECF  1d         shrc A
  8ED0  1d         shrc A
  8ED1  5b         ld B,A
  8ED2  22ff       ld A,($FF)
  8ED4  7430       and A,$30
  8ED6  01         swap A
  8ED7  5a         ld C,A
  8ED8  22ff       ld A,($FF)
  8EDA  740c       and A,$0C
  8EDC  1d         shrc A
  8EDD  1d         shrc A
  8EDE  5d         ld D,A
  8EDF  e0ff5c     ld E,($FF)
  8EE2  ec7403     and E,$03
  8EE5  178700     ld HL,$0087
L8EE8:
  8EE8  23         ld A,(HL)
  8EE9  7703       cmp A,$03
  8EEB  a2         jrs F,L8EEF
  8EEC  f653       ld (HL+),B
  8EEE  8d         jrs T,L8EFD
L8EEF:
  8EEF  7702       cmp A,$02
  8EF1  a2         jrs F,L8EF5
  8EF2  f652       ld (HL+),C
  8EF4  87         jrs T,L8EFD
L8EF5:
  8EF5  7701       cmp A,$01
  8EF7  a2         jrs F,L8EFB
  8EF8  f655       ld (HL+),D
  8EFA  81         jrs T,L8EFD
L8EFB:
  8EFB  f654       ld (HL+),E
L8EFD:
  8EFD  eb3f9600   cmp HL,$0096
  8F01  d4e5       jr LE,L8EE8
L8F03:
  8F03  17b6cc     ld HL,$CCB6
  8F06  2287       ld A,($87)
  8F08  e0a708     rold A,($A7)
  8F0B  e0a75a     ld C,($A7)
  8F0E  e52697     ld ($97),(HL+C)
  8F11  2288       ld A,($88)
  8F13  e0a808     rold A,($A8)
  8F16  e0a85a     ld C,($A8)
  8F19  e52698     ld ($98),(HL+C)
  8F1C  2289       ld A,($89)
  8F1E  e0a908     rold A,($A9)
  8F21  e0a95a     ld C,($A9)
  8F24  e52699     ld ($99),(HL+C)
  8F27  228a       ld A,($8A)
  8F29  e0aa08     rold A,($AA)
  8F2C  e0aa5a     ld C,($AA)
  8F2F  e5269a     ld ($9A),(HL+C)
  8F32  228b       ld A,($8B)
  8F34  e0ab08     rold A,($AB)
  8F37  e0ab5a     ld C,($AB)
  8F3A  e5269b     ld ($9B),(HL+C)
  8F3D  228c       ld A,($8C)
  8F3F  e0ac08     rold A,($AC)
  8F42  e0ac5a     ld C,($AC)
  8F45  e5269c     ld ($9C),(HL+C)
  8F48  228d       ld A,($8D)
  8F4A  e0ad08     rold A,($AD)
  8F4D  e0ad5a     ld C,($AD)
  8F50  e5269d     ld ($9D),(HL+C)
  8F53  228e       ld A,($8E)
  8F55  e0ae08     rold A,($AE)
  8F58  e0ae5a     ld C,($AE)
  8F5B  e5269e     ld ($9E),(HL+C)
  8F5E  228f       ld A,($8F)
  8F60  e0af08     rold A,($AF)
  8F63  e0af5a     ld C,($AF)
  8F66  e5269f     ld ($9F),(HL+C)
  8F69  2290       ld A,($90)
  8F6B  e0b008     rold A,($B0)
  8F6E  e0b05a     ld C,($B0)
  8F71  e526a0     ld ($A0),(HL+C)
  8F74  2291       ld A,($91)
  8F76  e0b108     rold A,($B1)
  8F79  e0b15a     ld C,($B1)
  8F7C  e526a1     ld ($A1),(HL+C)
  8F7F  2292       ld A,($92)
  8F81  e0b208     rold A,($B2)
  8F84  e0b25a     ld C,($B2)
  8F87  e526a2     ld ($A2),(HL+C)
  8F8A  2293       ld A,($93)
  8F8C  e0b308     rold A,($B3)
  8F8F  e0b35a     ld C,($B3)
  8F92  e526a3     ld ($A3),(HL+C)
  8F95  2294       ld A,($94)
  8F97  e0b408     rold A,($B4)
  8F9A  e0b45a     ld C,($B4)
  8F9D  e526a4     ld ($A4),(HL+C)
  8FA0  2295       ld A,($95)
  8FA2  e0b508     rold A,($B5)
  8FA5  e0b55a     ld C,($B5)
  8FA8  e526a5     ld ($A5),(HL+C)
  8FAB  2296       ld A,($96)
  8FAD  e0b608     rold A,($B6)
  8FB0  e0b65a     ld C,($B6)
  8FB3  e526a6     ld ($A6),(HL+C)
  8FB6  166002     ld DE,$0260
  8FB9  2282       ld A,($82)
  8FBB  01         swap A
  8FBC  3100       ld W,$00
  8FBE  ea31       add WA,DE
  8FC0  e816       ld DE,WA
  8FC2  2287       ld A,($87)
  8FC4  1c         shlc A
  8FC5  5a         ld C,A
  8FC6  17b6be     ld HL,$BEB6
  8FC9  e517       ld HL,(HL+C)
  8FCB  2260       ld A,($60)
  8FCD  3100       ld W,$00
  8FCF  eb31       add WA,HL
  8FD1  e817       ld HL,WA
  8FD3  e09759     ld W,($97)
  8FD6  2278       ld A,($78)
  8FD8  e379       add A,(HL)
  8FDA  e8df       test A.7
  8FDC  a8         jrs F,L8FE6
  8FDD  e961       add A,W
  8FDF  7764       cmp A,$64
  8FE1  d408       jr LE,L8FEB
  8FE3  3064       ld A,$64
  8FE5  84         jrs T,L8FEB
L8FE6:
  8FE6  e961       add A,W
  8FE8  81         jrs T,L8FEB
  8FE9  3000       ld A,$00
L8FEB:
  8FEB  f250       ld (DE),A
  8FED  12         inc DE
  8FEE  2288       ld A,($88)
  8FF0  1c         shlc A
  8FF1  5a         ld C,A
  8FF2  17b6be     ld HL,$BEB6
  8FF5  e517       ld HL,(HL+C)
  8FF7  2261       ld A,($61)
  8FF9  3100       ld W,$00
  8FFB  eb31       add WA,HL
  8FFD  e817       ld HL,WA
  8FFF  e09859     ld W,($98)
  9002  2278       ld A,($78)
  9004  e379       add A,(HL)
  9006  e8df       test A.7
  9008  a8         jrs F,L9012
  9009  e961       add A,W
  900B  7764       cmp A,$64
  900D  d408       jr LE,L9017
  900F  3064       ld A,$64
  9011  84         jrs T,L9017
L9012:
  9012  e961       add A,W
  9014  81         jrs T,L9017
  9015  3000       ld A,$00
L9017:
  9017  f250       ld (DE),A
  9019  12         inc DE
  901A  2289       ld A,($89)
  901C  1c         shlc A
  901D  5a         ld C,A
  901E  17b6be     ld HL,$BEB6
  9021  e517       ld HL,(HL+C)
  9023  2262       ld A,($62)
  9025  3100       ld W,$00
  9027  eb31       add WA,HL
  9029  e817       ld HL,WA
  902B  e09959     ld W,($99)
  902E  2278       ld A,($78)
  9030  e379       add A,(HL)
  9032  e8df       test A.7
  9034  a8         jrs F,L903E
  9035  e961       add A,W
  9037  7764       cmp A,$64
  9039  d408       jr LE,L9043
  903B  3064       ld A,$64
  903D  84         jrs T,L9043
L903E:
  903E  e961       add A,W
  9040  81         jrs T,L9043
  9041  3000       ld A,$00
L9043:
  9043  f250       ld (DE),A
  9045  12         inc DE
  9046  228a       ld A,($8A)
  9048  1c         shlc A
  9049  5a         ld C,A
  904A  17b6be     ld HL,$BEB6
  904D  e517       ld HL,(HL+C)
  904F  2263       ld A,($63)
  9051  3100       ld W,$00
  9053  eb31       add WA,HL
  9055  e817       ld HL,WA
  9057  e09a59     ld W,($9A)
  905A  2278       ld A,($78)
  905C  e379       add A,(HL)
  905E  e8df       test A.7
  9060  a8         jrs F,L906A
  9061  e961       add A,W
  9063  7764       cmp A,$64
  9065  d408       jr LE,L906F
  9067  3064       ld A,$64
  9069  84         jrs T,L906F
L906A:
  906A  e961       add A,W
  906C  81         jrs T,L906F
  906D  3000       ld A,$00
L906F:
  906F  f250       ld (DE),A
  9071  12         inc DE
  9072  228b       ld A,($8B)
  9074  1c         shlc A
  9075  5a         ld C,A
  9076  17b6be     ld HL,$BEB6
  9079  e517       ld HL,(HL+C)
  907B  2264       ld A,($64)
  907D  3100       ld W,$00
  907F  eb31       add WA,HL
  9081  e817       ld HL,WA
  9083  e09b59     ld W,($9B)
  9086  2278       ld A,($78)
  9088  e379       add A,(HL)
  908A  e8df       test A.7
  908C  a8         jrs F,L9096
  908D  e961       add A,W
  908F  7764       cmp A,$64
  9091  d408       jr LE,L909B
  9093  3064       ld A,$64
  9095  84         jrs T,L909B
L9096:
  9096  e961       add A,W
  9098  81         jrs T,L909B
  9099  3000       ld A,$00
L909B:
  909B  f250       ld (DE),A
  909D  12         inc DE
  909E  228c       ld A,($8C)
  90A0  1c         shlc A
  90A1  5a         ld C,A
  90A2  17b6be     ld HL,$BEB6
  90A5  e517       ld HL,(HL+C)
  90A7  2265       ld A,($65)
  90A9  3100       ld W,$00
  90AB  eb31       add WA,HL
  90AD  e817       ld HL,WA
  90AF  e09c59     ld W,($9C)
  90B2  2278       ld A,($78)
  90B4  e379       add A,(HL)
  90B6  e8df       test A.7
  90B8  a8         jrs F,L90C2
  90B9  e961       add A,W
  90BB  7764       cmp A,$64
  90BD  d408       jr LE,L90C7
  90BF  3064       ld A,$64
  90C1  84         jrs T,L90C7
L90C2:
  90C2  e961       add A,W
  90C4  81         jrs T,L90C7
  90C5  3000       ld A,$00
L90C7:
  90C7  f250       ld (DE),A
  90C9  12         inc DE
  90CA  228d       ld A,($8D)
  90CC  1c         shlc A
  90CD  5a         ld C,A
  90CE  17b6be     ld HL,$BEB6
  90D1  e517       ld HL,(HL+C)
  90D3  2266       ld A,($66)
  90D5  3100       ld W,$00
  90D7  eb31       add WA,HL
  90D9  e817       ld HL,WA
  90DB  e09d59     ld W,($9D)
  90DE  2278       ld A,($78)
  90E0  e379       add A,(HL)
  90E2  e8df       test A.7
  90E4  a8         jrs F,L90EE
  90E5  e961       add A,W
  90E7  7764       cmp A,$64
  90E9  d408       jr LE,L90F3
  90EB  3064       ld A,$64
  90ED  84         jrs T,L90F3
L90EE:
  90EE  e961       add A,W
  90F0  81         jrs T,L90F3
  90F1  3000       ld A,$00
L90F3:
  90F3  f250       ld (DE),A
  90F5  12         inc DE
  90F6  228e       ld A,($8E)
  90F8  1c         shlc A
  90F9  5a         ld C,A
  90FA  17b6be     ld HL,$BEB6
  90FD  e517       ld HL,(HL+C)
  90FF  2267       ld A,($67)
  9101  3100       ld W,$00
  9103  eb31       add WA,HL
  9105  e817       ld HL,WA
  9107  e09e59     ld W,($9E)
  910A  2278       ld A,($78)
  910C  e379       add A,(HL)
  910E  e8df       test A.7
  9110  a8         jrs F,L911A
  9111  e961       add A,W
  9113  7764       cmp A,$64
  9115  d408       jr LE,L911F
  9117  3064       ld A,$64
  9119  84         jrs T,L911F
L911A:
  911A  e961       add A,W
  911C  81         jrs T,L911F
  911D  3000       ld A,$00
L911F:
  911F  f250       ld (DE),A
  9121  12         inc DE
  9122  228f       ld A,($8F)
  9124  1c         shlc A
  9125  5a         ld C,A
  9126  17b6be     ld HL,$BEB6
  9129  e517       ld HL,(HL+C)
  912B  2268       ld A,($68)
  912D  3100       ld W,$00
  912F  eb31       add WA,HL
  9131  e817       ld HL,WA
  9133  e09f59     ld W,($9F)
  9136  2278       ld A,($78)
  9138  e379       add A,(HL)
  913A  e8df       test A.7
  913C  a8         jrs F,L9146
  913D  e961       add A,W
  913F  7764       cmp A,$64
  9141  d408       jr LE,L914B
  9143  3064       ld A,$64
  9145  84         jrs T,L914B
L9146:
  9146  e961       add A,W
  9148  81         jrs T,L914B
  9149  3000       ld A,$00
L914B:
  914B  f250       ld (DE),A
  914D  12         inc DE
  914E  2290       ld A,($90)
  9150  1c         shlc A
  9151  5a         ld C,A
  9152  17b6be     ld HL,$BEB6
  9155  e517       ld HL,(HL+C)
  9157  2269       ld A,($69)
  9159  3100       ld W,$00
  915B  eb31       add WA,HL
  915D  e817       ld HL,WA
  915F  e0a059     ld W,($A0)
  9162  2278       ld A,($78)
  9164  e379       add A,(HL)
  9166  e8df       test A.7
  9168  a8         jrs F,L9172
  9169  e961       add A,W
  916B  7764       cmp A,$64
  916D  d408       jr LE,L9177
  916F  3064       ld A,$64
  9171  84         jrs T,L9177
L9172:
  9172  e961       add A,W
  9174  81         jrs T,L9177
  9175  3000       ld A,$00
L9177:
  9177  f250       ld (DE),A
  9179  12         inc DE
  917A  2291       ld A,($91)
  917C  1c         shlc A
  917D  5a         ld C,A
  917E  17b6be     ld HL,$BEB6
  9181  e517       ld HL,(HL+C)
  9183  226a       ld A,($6A)
  9185  3100       ld W,$00
  9187  eb31       add WA,HL
  9189  e817       ld HL,WA
  918B  e0a159     ld W,($A1)
  918E  2278       ld A,($78)
  9190  e379       add A,(HL)
  9192  e8df       test A.7
  9194  a8         jrs F,L919E
  9195  e961       add A,W
  9197  7764       cmp A,$64
  9199  d408       jr LE,L91A3
  919B  3064       ld A,$64
  919D  84         jrs T,L91A3
L919E:
  919E  e961       add A,W
  91A0  81         jrs T,L91A3
  91A1  3000       ld A,$00
L91A3:
  91A3  f250       ld (DE),A
  91A5  12         inc DE
  91A6  2292       ld A,($92)
  91A8  1c         shlc A
  91A9  5a         ld C,A
  91AA  17b6be     ld HL,$BEB6
  91AD  e517       ld HL,(HL+C)
  91AF  226b       ld A,($6B)
  91B1  3100       ld W,$00
  91B3  eb31       add WA,HL
  91B5  e817       ld HL,WA
  91B7  e0a259     ld W,($A2)
  91BA  2278       ld A,($78)
  91BC  e379       add A,(HL)
  91BE  e8df       test A.7
  91C0  a8         jrs F,L91CA
  91C1  e961       add A,W
  91C3  7764       cmp A,$64
  91C5  d408       jr LE,L91CF
  91C7  3064       ld A,$64
  91C9  84         jrs T,L91CF
L91CA:
  91CA  e961       add A,W
  91CC  81         jrs T,L91CF
  91CD  3000       ld A,$00
L91CF:
  91CF  f250       ld (DE),A
  91D1  12         inc DE
  91D2  2293       ld A,($93)
  91D4  1c         shlc A
  91D5  5a         ld C,A
  91D6  17b6be     ld HL,$BEB6
  91D9  e517       ld HL,(HL+C)
  91DB  226c       ld A,($6C)
  91DD  3100       ld W,$00
  91DF  eb31       add WA,HL
  91E1  e817       ld HL,WA
  91E3  e0a359     ld W,($A3)
  91E6  2278       ld A,($78)
  91E8  e379       add A,(HL)
  91EA  e8df       test A.7
  91EC  a8         jrs F,L91F6
  91ED  e961       add A,W
  91EF  7764       cmp A,$64
  91F1  d408       jr LE,L91FB
  91F3  3064       ld A,$64
  91F5  84         jrs T,L91FB
L91F6:
  91F6  e961       add A,W
  91F8  81         jrs T,L91FB
  91F9  3000       ld A,$00
L91FB:
  91FB  f250       ld (DE),A
  91FD  12         inc DE
  91FE  2294       ld A,($94)
  9200  1c         shlc A
  9201  5a         ld C,A
  9202  17b6be     ld HL,$BEB6
  9205  e517       ld HL,(HL+C)
  9207  226d       ld A,($6D)
  9209  3100       ld W,$00
  920B  eb31       add WA,HL
  920D  e817       ld HL,WA
  920F  e0a459     ld W,($A4)
  9212  2278       ld A,($78)
  9214  e379       add A,(HL)
  9216  e8df       test A.7
  9218  a8         jrs F,L9222
  9219  e961       add A,W
  921B  7764       cmp A,$64
  921D  d408       jr LE,L9227
  921F  3064       ld A,$64
  9221  84         jrs T,L9227
L9222:
  9222  e961       add A,W
  9224  81         jrs T,L9227
  9225  3000       ld A,$00
L9227:
  9227  f250       ld (DE),A
  9229  12         inc DE
  922A  2295       ld A,($95)
  922C  1c         shlc A
  922D  5a         ld C,A
  922E  17b6be     ld HL,$BEB6
  9231  e517       ld HL,(HL+C)
  9233  226e       ld A,($6E)
  9235  3100       ld W,$00
  9237  eb31       add WA,HL
  9239  e817       ld HL,WA
  923B  e0a559     ld W,($A5)
  923E  2278       ld A,($78)
  9240  e379       add A,(HL)
  9242  e8df       test A.7
  9244  a8         jrs F,L924E
  9245  e961       add A,W
  9247  7764       cmp A,$64
  9249  d408       jr LE,L9253
  924B  3064       ld A,$64
  924D  84         jrs T,L9253
L924E:
  924E  e961       add A,W
  9250  81         jrs T,L9253
  9251  3000       ld A,$00
L9253:
  9253  f250       ld (DE),A
  9255  12         inc DE
  9256  2296       ld A,($96)
  9258  1c         shlc A
  9259  5a         ld C,A
  925A  17b6be     ld HL,$BEB6
  925D  e517       ld HL,(HL+C)
  925F  226f       ld A,($6F)
  9261  3100       ld W,$00
  9263  eb31       add WA,HL
  9265  e817       ld HL,WA
  9267  e0a659     ld W,($A6)
  926A  2278       ld A,($78)
  926C  e379       add A,(HL)
  926E  e8df       test A.7
  9270  a8         jrs F,L927A
  9271  e961       add A,W
  9273  7764       cmp A,$64
  9275  d408       jr LE,L927F
  9277  3064       ld A,$64
  9279  84         jrs T,L927F
L927A:
  927A  e961       add A,W
  927C  81         jrs T,L927F
  927D  3000       ld A,$00
L927F:
  927F  f250       ld (DE),A
  9281  166002     ld DE,$0260
  9284  2282       ld A,($82)
  9286  01         swap A
  9287  3100       ld W,$00
  9289  ea31       add WA,DE
  928B  e817       ld HL,WA
  928D  e35a       ld C,(HL)
  928F  1776d1     ld HL,$D176
  9292  e558       ld A,(HL+C)
  9294  d021       jr Z,L92B7
  9296  40fa       set ($FA).0
  9298  d71f       jr F,L92B9
  929A  e0a77703   cmp ($A7),$03
  929E  d519       jr GT,L92B9
  92A0  e0fd5a     ld C,($FD)
  92A3  3300       ld B,$00
  92A5  ea1c       shlc C
  92A7  eb1e       rolc B
  92A9  1476d2     ld WA,$D276
  92AC  e931       add WA,BC
  92AE  e817       ld HL,WA
  92B0  e314       ld WA,(HL)
  92B2  e0b717     ld HL,($B7)
  92B5  fb13       jr L92CA
L92B7:
  92B7  22f9       ld A,($F9)
L92B9:
  92B9  e0b717     ld HL,($B7)
  92BC  e8df       test A.7
  92BE  88         jrs T,L92C8
  92BF  31ff       ld W,$FF
  92C1  eb31       add WA,HL
  92C3  8b         jrs T,L92D0
  92C4  140000     ld WA,$0000
  92C7  87         jrs T,L92D0
L92C8:
  92C8  3100       ld W,$00
L92CA:
  92CA  eb31       add WA,HL
  92CC  a2         jrs F,L92D0
  92CD  14ffff     ld WA,$FFFF
L92D0:
  92D0  f0b710     ld ($B7),WA
  92D3  12         inc DE
  92D4  2282       ld A,($82)
  92D6  01         swap A
  92D7  3100       ld W,$00
  92D9  ea31       add WA,DE
  92DB  e817       ld HL,WA
  92DD  e35a       ld C,(HL)
  92DF  1776d1     ld HL,$D176
  92E2  e558       ld A,(HL+C)
  92E4  d021       jr Z,L9307
  92E6  41fa       set ($FA).1
  92E8  d71f       jr F,L9309
  92EA  e0a87703   cmp ($A8),$03
  92EE  d519       jr GT,L9309
  92F0  e0fd5a     ld C,($FD)
  92F3  3300       ld B,$00
  92F5  ea1c       shlc C
  92F7  eb1e       rolc B
  92F9  1476d2     ld WA,$D276
  92FC  e931       add WA,BC
  92FE  e817       ld HL,WA
  9300  e314       ld WA,(HL)
  9302  e0b917     ld HL,($B9)
  9305  fb13       jr L931A
L9307:
  9307  22f9       ld A,($F9)
L9309:
  9309  e0b917     ld HL,($B9)
  930C  e8df       test A.7
  930E  88         jrs T,L9318
  930F  31ff       ld W,$FF
  9311  eb31       add WA,HL
  9313  8b         jrs T,L9320
  9314  140000     ld WA,$0000
  9317  87         jrs T,L9320
L9318:
  9318  3100       ld W,$00
L931A:
  931A  eb31       add WA,HL
  931C  a2         jrs F,L9320
  931D  14ffff     ld WA,$FFFF
L9320:
  9320  f0b910     ld ($B9),WA
  9323  12         inc DE
  9324  2282       ld A,($82)
  9326  01         swap A
  9327  3100       ld W,$00
  9329  ea31       add WA,DE
  932B  e817       ld HL,WA
  932D  e35a       ld C,(HL)
  932F  1776d1     ld HL,$D176
  9332  e558       ld A,(HL+C)
  9334  d021       jr Z,L9357
  9336  42fa       set ($FA).2
  9338  d71f       jr F,L9359
  933A  e0a97703   cmp ($A9),$03
  933E  d519       jr GT,L9359
  9340  e0fd5a     ld C,($FD)
  9343  3300       ld B,$00
  9345  ea1c       shlc C
  9347  eb1e       rolc B
  9349  1476d2     ld WA,$D276
  934C  e931       add WA,BC
  934E  e817       ld HL,WA
  9350  e314       ld WA,(HL)
  9352  e0bb17     ld HL,($BB)
  9355  fb13       jr L936A
L9357:
  9357  22f9       ld A,($F9)
L9359:
  9359  e0bb17     ld HL,($BB)
  935C  e8df       test A.7
  935E  88         jrs T,L9368
  935F  31ff       ld W,$FF
  9361  eb31       add WA,HL
  9363  8b         jrs T,L9370
  9364  140000     ld WA,$0000
  9367  87         jrs T,L9370
L9368:
  9368  3100       ld W,$00
L936A:
  936A  eb31       add WA,HL
  936C  a2         jrs F,L9370
  936D  14ffff     ld WA,$FFFF
L9370:
  9370  f0bb10     ld ($BB),WA
  9373  12         inc DE
  9374  2282       ld A,($82)
  9376  01         swap A
  9377  3100       ld W,$00
  9379  ea31       add WA,DE
  937B  e817       ld HL,WA
  937D  e35a       ld C,(HL)
  937F  1776d1     ld HL,$D176
  9382  e558       ld A,(HL+C)
  9384  d021       jr Z,L93A7
  9386  43fa       set ($FA).3
  9388  d71f       jr F,L93A9
  938A  e0aa7703   cmp ($AA),$03
  938E  d519       jr GT,L93A9
  9390  e0fd5a     ld C,($FD)
  9393  3300       ld B,$00
  9395  ea1c       shlc C
  9397  eb1e       rolc B
  9399  1476d2     ld WA,$D276
  939C  e931       add WA,BC
  939E  e817       ld HL,WA
  93A0  e314       ld WA,(HL)
  93A2  e0bd17     ld HL,($BD)
  93A5  fb13       jr L93BA
L93A7:
  93A7  22f9       ld A,($F9)
L93A9:
  93A9  e0bd17     ld HL,($BD)
  93AC  e8df       test A.7
  93AE  88         jrs T,L93B8
  93AF  31ff       ld W,$FF
  93B1  eb31       add WA,HL
  93B3  8b         jrs T,L93C0
  93B4  140000     ld WA,$0000
  93B7  87         jrs T,L93C0
L93B8:
  93B8  3100       ld W,$00
L93BA:
  93BA  eb31       add WA,HL
  93BC  a2         jrs F,L93C0
  93BD  14ffff     ld WA,$FFFF
L93C0:
  93C0  f0bd10     ld ($BD),WA
  93C3  12         inc DE
  93C4  2282       ld A,($82)
  93C6  01         swap A
  93C7  3100       ld W,$00
  93C9  ea31       add WA,DE
  93CB  e817       ld HL,WA
  93CD  e35a       ld C,(HL)
  93CF  1776d1     ld HL,$D176
  93D2  e558       ld A,(HL+C)
  93D4  d021       jr Z,L93F7
  93D6  44fa       set ($FA).4
  93D8  d71f       jr F,L93F9
  93DA  e0ab7703   cmp ($AB),$03
  93DE  d519       jr GT,L93F9
  93E0  e0fd5a     ld C,($FD)
  93E3  3300       ld B,$00
  93E5  ea1c       shlc C
  93E7  eb1e       rolc B
  93E9  1476d2     ld WA,$D276
  93EC  e931       add WA,BC
  93EE  e817       ld HL,WA
  93F0  e314       ld WA,(HL)
  93F2  e0bf17     ld HL,($BF)
  93F5  fb13       jr L940A
L93F7:
  93F7  22f9       ld A,($F9)
L93F9:
  93F9  e0bf17     ld HL,($BF)
  93FC  e8df       test A.7
  93FE  88         jrs T,L9408
  93FF  31ff       ld W,$FF
  9401  eb31       add WA,HL
  9403  8b         jrs T,L9410
  9404  140000     ld WA,$0000
  9407  87         jrs T,L9410
L9408:
  9408  3100       ld W,$00
L940A:
  940A  eb31       add WA,HL
  940C  a2         jrs F,L9410
  940D  14ffff     ld WA,$FFFF
L9410:
  9410  f0bf10     ld ($BF),WA
  9413  12         inc DE
  9414  2282       ld A,($82)
  9416  01         swap A
  9417  3100       ld W,$00
  9419  ea31       add WA,DE
  941B  e817       ld HL,WA
  941D  e35a       ld C,(HL)
  941F  1776d1     ld HL,$D176
  9422  e558       ld A,(HL+C)
  9424  d021       jr Z,L9447
  9426  45fa       set ($FA).5
  9428  d71f       jr F,L9449
  942A  e0ac7703   cmp ($AC),$03
  942E  d519       jr GT,L9449
  9430  e0fd5a     ld C,($FD)
  9433  3300       ld B,$00
  9435  ea1c       shlc C
  9437  eb1e       rolc B
  9439  1476d2     ld WA,$D276
  943C  e931       add WA,BC
  943E  e817       ld HL,WA
  9440  e314       ld WA,(HL)
  9442  e0c117     ld HL,($C1)
  9445  fb13       jr L945A
L9447:
  9447  22f9       ld A,($F9)
L9449:
  9449  e0c117     ld HL,($C1)
  944C  e8df       test A.7
  944E  88         jrs T,L9458
  944F  31ff       ld W,$FF
  9451  eb31       add WA,HL
  9453  8b         jrs T,L9460
  9454  140000     ld WA,$0000
  9457  87         jrs T,L9460
L9458:
  9458  3100       ld W,$00
L945A:
  945A  eb31       add WA,HL
  945C  a2         jrs F,L9460
  945D  14ffff     ld WA,$FFFF
L9460:
  9460  f0c110     ld ($C1),WA
  9463  12         inc DE
  9464  2282       ld A,($82)
  9466  01         swap A
  9467  3100       ld W,$00
  9469  ea31       add WA,DE
  946B  e817       ld HL,WA
  946D  e35a       ld C,(HL)
  946F  1776d1     ld HL,$D176
  9472  e558       ld A,(HL+C)
  9474  d021       jr Z,L9497
  9476  46fa       set ($FA).6
  9478  d71f       jr F,L9499
  947A  e0ad7703   cmp ($AD),$03
  947E  d519       jr GT,L9499
  9480  e0fd5a     ld C,($FD)
  9483  3300       ld B,$00
  9485  ea1c       shlc C
  9487  eb1e       rolc B
  9489  1476d2     ld WA,$D276
  948C  e931       add WA,BC
  948E  e817       ld HL,WA
  9490  e314       ld WA,(HL)
  9492  e0c317     ld HL,($C3)
  9495  fb13       jr L94AA
L9497:
  9497  22f9       ld A,($F9)
L9499:
  9499  e0c317     ld HL,($C3)
  949C  e8df       test A.7
  949E  88         jrs T,L94A8
  949F  31ff       ld W,$FF
  94A1  eb31       add WA,HL
  94A3  8b         jrs T,L94B0
  94A4  140000     ld WA,$0000
  94A7  87         jrs T,L94B0
L94A8:
  94A8  3100       ld W,$00
L94AA:
  94AA  eb31       add WA,HL
  94AC  a2         jrs F,L94B0
  94AD  14ffff     ld WA,$FFFF
L94B0:
  94B0  f0c310     ld ($C3),WA
  94B3  12         inc DE
  94B4  2282       ld A,($82)
  94B6  01         swap A
  94B7  3100       ld W,$00
  94B9  ea31       add WA,DE
  94BB  e817       ld HL,WA
  94BD  e35a       ld C,(HL)
  94BF  1776d1     ld HL,$D176
  94C2  e558       ld A,(HL+C)
  94C4  d021       jr Z,L94E7
  94C6  47fa       set ($FA).7
  94C8  d71f       jr F,L94E9
  94CA  e0ae7703   cmp ($AE),$03
  94CE  d519       jr GT,L94E9
  94D0  e0fd5a     ld C,($FD)
  94D3  3300       ld B,$00
  94D5  ea1c       shlc C
  94D7  eb1e       rolc B
  94D9  1476d2     ld WA,$D276
  94DC  e931       add WA,BC
  94DE  e817       ld HL,WA
  94E0  e314       ld WA,(HL)
  94E2  e0c517     ld HL,($C5)
  94E5  fb13       jr L94FA
L94E7:
  94E7  22f9       ld A,($F9)
L94E9:
  94E9  e0c517     ld HL,($C5)
  94EC  e8df       test A.7
  94EE  88         jrs T,L94F8
  94EF  31ff       ld W,$FF
  94F1  eb31       add WA,HL
  94F3  8b         jrs T,L9500
  94F4  140000     ld WA,$0000
  94F7  87         jrs T,L9500
L94F8:
  94F8  3100       ld W,$00
L94FA:
  94FA  eb31       add WA,HL
  94FC  a2         jrs F,L9500
  94FD  14ffff     ld WA,$FFFF
L9500:
  9500  f0c510     ld ($C5),WA
  9503  12         inc DE
  9504  2282       ld A,($82)
  9506  01         swap A
  9507  3100       ld W,$00
  9509  ea31       add WA,DE
  950B  e817       ld HL,WA
  950D  e35a       ld C,(HL)
  950F  1776d1     ld HL,$D176
  9512  e558       ld A,(HL+C)
  9514  d021       jr Z,L9537
  9516  40fb       set ($FB).0
  9518  d71f       jr F,L9539
  951A  e0af7703   cmp ($AF),$03
  951E  d519       jr GT,L9539
  9520  e0fd5a     ld C,($FD)
  9523  3300       ld B,$00
  9525  ea1c       shlc C
  9527  eb1e       rolc B
  9529  1476d2     ld WA,$D276
  952C  e931       add WA,BC
  952E  e817       ld HL,WA
  9530  e314       ld WA,(HL)
  9532  e0c717     ld HL,($C7)
  9535  fb13       jr L954A
L9537:
  9537  22f9       ld A,($F9)
L9539:
  9539  e0c717     ld HL,($C7)
  953C  e8df       test A.7
  953E  88         jrs T,L9548
  953F  31ff       ld W,$FF
  9541  eb31       add WA,HL
  9543  8b         jrs T,L9550
  9544  140000     ld WA,$0000
  9547  87         jrs T,L9550
L9548:
  9548  3100       ld W,$00
L954A:
  954A  eb31       add WA,HL
  954C  a2         jrs F,L9550
  954D  14ffff     ld WA,$FFFF
L9550:
  9550  f0c710     ld ($C7),WA
  9553  12         inc DE
  9554  2282       ld A,($82)
  9556  01         swap A
  9557  3100       ld W,$00
  9559  ea31       add WA,DE
  955B  e817       ld HL,WA
  955D  e35a       ld C,(HL)
  955F  1776d1     ld HL,$D176
  9562  e558       ld A,(HL+C)
  9564  d021       jr Z,L9587
  9566  41fb       set ($FB).1
  9568  d71f       jr F,L9589
  956A  e0b07703   cmp ($B0),$03
  956E  d519       jr GT,L9589
  9570  e0fd5a     ld C,($FD)
  9573  3300       ld B,$00
  9575  ea1c       shlc C
  9577  eb1e       rolc B
  9579  1476d2     ld WA,$D276
  957C  e931       add WA,BC
  957E  e817       ld HL,WA
  9580  e314       ld WA,(HL)
  9582  e0c917     ld HL,($C9)
  9585  fb13       jr L959A
L9587:
  9587  22f9       ld A,($F9)
L9589:
  9589  e0c917     ld HL,($C9)
  958C  e8df       test A.7
  958E  88         jrs T,L9598
  958F  31ff       ld W,$FF
  9591  eb31       add WA,HL
  9593  8b         jrs T,L95A0
  9594  140000     ld WA,$0000
  9597  87         jrs T,L95A0
L9598:
  9598  3100       ld W,$00
L959A:
  959A  eb31       add WA,HL
  959C  a2         jrs F,L95A0
  959D  14ffff     ld WA,$FFFF
L95A0:
  95A0  f0c910     ld ($C9),WA
  95A3  12         inc DE
  95A4  2282       ld A,($82)
  95A6  01         swap A
  95A7  3100       ld W,$00
  95A9  ea31       add WA,DE
  95AB  e817       ld HL,WA
  95AD  e35a       ld C,(HL)
  95AF  1776d1     ld HL,$D176
  95B2  e558       ld A,(HL+C)
  95B4  d021       jr Z,L95D7
  95B6  42fb       set ($FB).2
  95B8  d71f       jr F,L95D9
  95BA  e0b17703   cmp ($B1),$03
  95BE  d519       jr GT,L95D9
  95C0  e0fd5a     ld C,($FD)
  95C3  3300       ld B,$00
  95C5  ea1c       shlc C
  95C7  eb1e       rolc B
  95C9  1476d2     ld WA,$D276
  95CC  e931       add WA,BC
  95CE  e817       ld HL,WA
  95D0  e314       ld WA,(HL)
  95D2  e0cb17     ld HL,($CB)
  95D5  fb13       jr L95EA
L95D7:
  95D7  22f9       ld A,($F9)
L95D9:
  95D9  e0cb17     ld HL,($CB)
  95DC  e8df       test A.7
  95DE  88         jrs T,L95E8
  95DF  31ff       ld W,$FF
  95E1  eb31       add WA,HL
  95E3  8b         jrs T,L95F0
  95E4  140000     ld WA,$0000
  95E7  87         jrs T,L95F0
L95E8:
  95E8  3100       ld W,$00
L95EA:
  95EA  eb31       add WA,HL
  95EC  a2         jrs F,L95F0
  95ED  14ffff     ld WA,$FFFF
L95F0:
  95F0  f0cb10     ld ($CB),WA
  95F3  12         inc DE
  95F4  2282       ld A,($82)
  95F6  01         swap A
  95F7  3100       ld W,$00
  95F9  ea31       add WA,DE
  95FB  e817       ld HL,WA
  95FD  e35a       ld C,(HL)
  95FF  1776d1     ld HL,$D176
  9602  e558       ld A,(HL+C)
  9604  d021       jr Z,L9627
  9606  43fb       set ($FB).3
  9608  d71f       jr F,L9629
  960A  e0b27703   cmp ($B2),$03
  960E  d519       jr GT,L9629
  9610  e0fd5a     ld C,($FD)
  9613  3300       ld B,$00
  9615  ea1c       shlc C
  9617  eb1e       rolc B
  9619  1476d2     ld WA,$D276
  961C  e931       add WA,BC
  961E  e817       ld HL,WA
  9620  e314       ld WA,(HL)
  9622  e0cd17     ld HL,($CD)
  9625  fb13       jr L963A
L9627:
  9627  22f9       ld A,($F9)
L9629:
  9629  e0cd17     ld HL,($CD)
  962C  e8df       test A.7
  962E  88         jrs T,L9638
  962F  31ff       ld W,$FF
  9631  eb31       add WA,HL
  9633  8b         jrs T,L9640
  9634  140000     ld WA,$0000
  9637  87         jrs T,L9640
L9638:
  9638  3100       ld W,$00
L963A:
  963A  eb31       add WA,HL
  963C  a2         jrs F,L9640
  963D  14ffff     ld WA,$FFFF
L9640:
  9640  f0cd10     ld ($CD),WA
  9643  12         inc DE
  9644  2282       ld A,($82)
  9646  01         swap A
  9647  3100       ld W,$00
  9649  ea31       add WA,DE
  964B  e817       ld HL,WA
  964D  e35a       ld C,(HL)
  964F  1776d1     ld HL,$D176
  9652  e558       ld A,(HL+C)
  9654  d021       jr Z,L9677
  9656  44fb       set ($FB).4
  9658  d71f       jr F,L9679
  965A  e0b37703   cmp ($B3),$03
  965E  d519       jr GT,L9679
  9660  e0fd5a     ld C,($FD)
  9663  3300       ld B,$00
  9665  ea1c       shlc C
  9667  eb1e       rolc B
  9669  1476d2     ld WA,$D276
  966C  e931       add WA,BC
  966E  e817       ld HL,WA
  9670  e314       ld WA,(HL)
  9672  e0cf17     ld HL,($CF)
  9675  fb13       jr L968A
L9677:
  9677  22f9       ld A,($F9)
L9679:
  9679  e0cf17     ld HL,($CF)
  967C  e8df       test A.7
  967E  88         jrs T,L9688
  967F  31ff       ld W,$FF
  9681  eb31       add WA,HL
  9683  8b         jrs T,L9690
  9684  140000     ld WA,$0000
  9687  87         jrs T,L9690
L9688:
  9688  3100       ld W,$00
L968A:
  968A  eb31       add WA,HL
  968C  a2         jrs F,L9690
  968D  14ffff     ld WA,$FFFF
L9690:
  9690  f0cf10     ld ($CF),WA
  9693  12         inc DE
  9694  2282       ld A,($82)
  9696  01         swap A
  9697  3100       ld W,$00
  9699  ea31       add WA,DE
  969B  e817       ld HL,WA
  969D  e35a       ld C,(HL)
  969F  1776d1     ld HL,$D176
  96A2  e558       ld A,(HL+C)
  96A4  d021       jr Z,L96C7
  96A6  45fb       set ($FB).5
  96A8  d71f       jr F,L96C9
  96AA  e0b47703   cmp ($B4),$03
  96AE  d519       jr GT,L96C9
  96B0  e0fd5a     ld C,($FD)
  96B3  3300       ld B,$00
  96B5  ea1c       shlc C
  96B7  eb1e       rolc B
  96B9  1476d2     ld WA,$D276
  96BC  e931       add WA,BC
  96BE  e817       ld HL,WA
  96C0  e314       ld WA,(HL)
  96C2  e0d117     ld HL,($D1)
  96C5  fb13       jr L96DA
L96C7:
  96C7  22f9       ld A,($F9)
L96C9:
  96C9  e0d117     ld HL,($D1)
  96CC  e8df       test A.7
  96CE  88         jrs T,L96D8
  96CF  31ff       ld W,$FF
  96D1  eb31       add WA,HL
  96D3  8b         jrs T,L96E0
  96D4  140000     ld WA,$0000
  96D7  87         jrs T,L96E0
L96D8:
  96D8  3100       ld W,$00
L96DA:
  96DA  eb31       add WA,HL
  96DC  a2         jrs F,L96E0
  96DD  14ffff     ld WA,$FFFF
L96E0:
  96E0  f0d110     ld ($D1),WA
  96E3  12         inc DE
  96E4  2282       ld A,($82)
  96E6  01         swap A
  96E7  3100       ld W,$00
  96E9  ea31       add WA,DE
  96EB  e817       ld HL,WA
  96ED  e35a       ld C,(HL)
  96EF  1776d1     ld HL,$D176
  96F2  e558       ld A,(HL+C)
  96F4  d021       jr Z,L9717
  96F6  46fb       set ($FB).6
  96F8  d71f       jr F,L9719
  96FA  e0b57703   cmp ($B5),$03
  96FE  d519       jr GT,L9719
  9700  e0fd5a     ld C,($FD)
  9703  3300       ld B,$00
  9705  ea1c       shlc C
  9707  eb1e       rolc B
  9709  1476d2     ld WA,$D276
  970C  e931       add WA,BC
  970E  e817       ld HL,WA
  9710  e314       ld WA,(HL)
  9712  e0d317     ld HL,($D3)
  9715  fb13       jr L972A
L9717:
  9717  22f9       ld A,($F9)
L9719:
  9719  e0d317     ld HL,($D3)
  971C  e8df       test A.7
  971E  88         jrs T,L9728
  971F  31ff       ld W,$FF
  9721  eb31       add WA,HL
  9723  8b         jrs T,L9730
  9724  140000     ld WA,$0000
  9727  87         jrs T,L9730
L9728:
  9728  3100       ld W,$00
L972A:
  972A  eb31       add WA,HL
  972C  a2         jrs F,L9730
  972D  14ffff     ld WA,$FFFF
L9730:
  9730  f0d310     ld ($D3),WA
  9733  12         inc DE
  9734  2282       ld A,($82)
  9736  01         swap A
  9737  3100       ld W,$00
  9739  ea31       add WA,DE
  973B  e817       ld HL,WA
  973D  e35a       ld C,(HL)
  973F  1776d1     ld HL,$D176
  9742  e558       ld A,(HL+C)
  9744  d021       jr Z,L9767
  9746  47fb       set ($FB).7
  9748  d71f       jr F,L9769
  974A  e0b67703   cmp ($B6),$03
  974E  d519       jr GT,L9769
  9750  e0fd5a     ld C,($FD)
  9753  3300       ld B,$00
  9755  ea1c       shlc C
  9757  eb1e       rolc B
  9759  1476d2     ld WA,$D276
  975C  e931       add WA,BC
  975E  e817       ld HL,WA
  9760  e314       ld WA,(HL)
  9762  e0d517     ld HL,($D5)
  9765  fb13       jr L977A
L9767:
  9767  22f9       ld A,($F9)
L9769:
  9769  e0d517     ld HL,($D5)
  976C  e8df       test A.7
  976E  88         jrs T,L9778
  976F  31ff       ld W,$FF
  9771  eb31       add WA,HL
  9773  8b         jrs T,L9780
  9774  140000     ld WA,$0000
  9777  87         jrs T,L9780
L9778:
  9778  3100       ld W,$00
L977A:
  977A  eb31       add WA,HL
  977C  a2         jrs F,L9780
  977D  14ffff     ld WA,$FFFF
L9780:
  9780  f0d510     ld ($D5),WA
  9783  2082       inc ($82)
  9785  e0827708   cmp ($82),$08
  9789  d303       jr CC,L978E
  978B  fe1c8e     jp L8E1C
L978E:
  978E  4070       set ($70).0
  9790  fe9da1     jp LA19D
L9793:
  9793  d970       test ($70).1
  9795  82         jrs T,L9799
  9796  fe9da2     jp LA29D
L9799:
  9799  174002     ld HL,$0240
  979C  e227       ld (HL),(DE)
  979E  13         inc HL
  979F  12         inc DE
  97A0  e227       ld (HL),(DE)
  97A2  13         inc HL
  97A3  12         inc DE
  97A4  e227       ld (HL),(DE)
  97A6  13         inc HL
  97A7  12         inc DE
  97A8  e227       ld (HL),(DE)
  97AA  13         inc HL
  97AB  12         inc DE
  97AC  e227       ld (HL),(DE)
  97AE  13         inc HL
  97AF  12         inc DE
  97B0  e227       ld (HL),(DE)
  97B2  13         inc HL
  97B3  12         inc DE
  97B4  e227       ld (HL),(DE)
  97B6  13         inc HL
  97B7  12         inc DE
  97B8  e227       ld (HL),(DE)
  97BA  13         inc HL
  97BB  12         inc DE
  97BC  e227       ld (HL),(DE)
  97BE  13         inc HL
  97BF  12         inc DE
  97C0  e227       ld (HL),(DE)
  97C2  13         inc HL
  97C3  12         inc DE
  97C4  e227       ld (HL),(DE)
  97C6  13         inc HL
  97C7  12         inc DE
  97C8  e227       ld (HL),(DE)
  97CA  13         inc HL
  97CB  12         inc DE
  97CC  e227       ld (HL),(DE)
  97CE  13         inc HL
  97CF  12         inc DE
  97D0  e227       ld (HL),(DE)
  97D2  13         inc HL
  97D3  12         inc DE
  97D4  e227       ld (HL),(DE)
  97D6  13         inc HL
  97D7  12         inc DE
  97D8  e227       ld (HL),(DE)
  97DA  13         inc HL
  97DB  12         inc DE
  97DC  e227       ld (HL),(DE)
  97DE  13         inc HL
  97DF  12         inc DE
  97E0  e227       ld (HL),(DE)
  97E2  13         inc HL
  97E3  12         inc DE
  97E4  e227       ld (HL),(DE)
  97E6  13         inc HL
  97E7  12         inc DE
  97E8  e227       ld (HL),(DE)
  97EA  13         inc HL
  97EB  12         inc DE
  97EC  e227       ld (HL),(DE)
  97EE  13         inc HL
  97EF  12         inc DE
  97F0  e227       ld (HL),(DE)
  97F2  13         inc HL
  97F3  12         inc DE
  97F4  e227       ld (HL),(DE)
  97F6  13         inc HL
  97F7  12         inc DE
  97F8  e227       ld (HL),(DE)
  97FA  13         inc HL
  97FB  12         inc DE
  97FC  e227       ld (HL),(DE)
  97FE  13         inc HL
  97FF  12         inc DE
  9800  e227       ld (HL),(DE)
  9802  13         inc HL
  9803  12         inc DE
  9804  e227       ld (HL),(DE)
  9806  13         inc HL
  9807  12         inc DE
  9808  e227       ld (HL),(DE)
  980A  13         inc HL
  980B  12         inc DE
  980C  e227       ld (HL),(DE)
  980E  13         inc HL
  980F  12         inc DE
  9810  e227       ld (HL),(DE)
  9812  13         inc HL
  9813  12         inc DE
  9814  e227       ld (HL),(DE)
  9816  13         inc HL
  9817  12         inc DE
  9818  e227       ld (HL),(DE)
  981A  12         inc DE
  981B  ea3f4002   cmp DE,$0240
  981F  d203       jr CS,L9824
  9821  160001     ld DE,$0100
L9824:
  9824  f07612     ld ($76),DE
  9827  2e82       clr ($82)
L9829:
  9829  178700     ld HL,$0087
  982C  164002     ld DE,$0240
  982F  3007       ld A,$07
  9831  e0825a     ld C,($82)
  9834  ea63       sub A,C
  9836  e89e       test (DE).A
  9838  e3c8       ld (HL).0,CF
  983A  12         inc DE
  983B  e89e       test (DE).A
  983D  e6c9       ld (HL+).1,CF
  983F  12         inc DE
  9840  e89e       test (DE).A
  9842  e3c8       ld (HL).0,CF
  9844  12         inc DE
  9845  e89e       test (DE).A
  9847  e6c9       ld (HL+).1,CF
  9849  12         inc DE
  984A  e89e       test (DE).A
  984C  e3c8       ld (HL).0,CF
  984E  12         inc DE
  984F  e89e       test (DE).A
  9851  e6c9       ld (HL+).1,CF
  9853  12         inc DE
  9854  e89e       test (DE).A
  9856  e3c8       ld (HL).0,CF
  9858  12         inc DE
  9859  e89e       test (DE).A
  985B  e6c9       ld (HL+).1,CF
  985D  12         inc DE
  985E  e89e       test (DE).A
  9860  e3c8       ld (HL).0,CF
  9862  12         inc DE
  9863  e89e       test (DE).A
  9865  e6c9       ld (HL+).1,CF
  9867  12         inc DE
  9868  e89e       test (DE).A
  986A  e3c8       ld (HL).0,CF
  986C  12         inc DE
  986D  e89e       test (DE).A
  986F  e6c9       ld (HL+).1,CF
  9871  12         inc DE
  9872  e89e       test (DE).A
  9874  e3c8       ld (HL).0,CF
  9876  12         inc DE
  9877  e89e       test (DE).A
  9879  e6c9       ld (HL+).1,CF
  987B  12         inc DE
  987C  e89e       test (DE).A
  987E  e3c8       ld (HL).0,CF
  9880  12         inc DE
  9881  e89e       test (DE).A
  9883  e6c9       ld (HL+).1,CF
  9885  12         inc DE
  9886  e89e       test (DE).A
  9888  e3c8       ld (HL).0,CF
  988A  12         inc DE
  988B  e89e       test (DE).A
  988D  e6c9       ld (HL+).1,CF
  988F  12         inc DE
  9890  e89e       test (DE).A
  9892  e3c8       ld (HL).0,CF
  9894  12         inc DE
  9895  e89e       test (DE).A
  9897  e6c9       ld (HL+).1,CF
  9899  12         inc DE
  989A  e89e       test (DE).A
  989C  e3c8       ld (HL).0,CF
  989E  12         inc DE
  989F  e89e       test (DE).A
  98A1  e6c9       ld (HL+).1,CF
  98A3  12         inc DE
  98A4  e89e       test (DE).A
  98A6  e3c8       ld (HL).0,CF
  98A8  12         inc DE
  98A9  e89e       test (DE).A
  98AB  e6c9       ld (HL+).1,CF
  98AD  12         inc DE
  98AE  e89e       test (DE).A
  98B0  e3c8       ld (HL).0,CF
  98B2  12         inc DE
  98B3  e89e       test (DE).A
  98B5  e6c9       ld (HL+).1,CF
  98B7  12         inc DE
  98B8  e89e       test (DE).A
  98BA  e3c8       ld (HL).0,CF
  98BC  12         inc DE
  98BD  e89e       test (DE).A
  98BF  e6c9       ld (HL+).1,CF
  98C1  12         inc DE
  98C2  e89e       test (DE).A
  98C4  e3c8       ld (HL).0,CF
  98C6  12         inc DE
  98C7  e89e       test (DE).A
  98C9  e6c9       ld (HL+).1,CF
  98CB  12         inc DE
  98CC  e89e       test (DE).A
  98CE  e3c8       ld (HL).0,CF
  98D0  12         inc DE
  98D1  e89e       test (DE).A
  98D3  e3c9       ld (HL).1,CF
  98D5  22ff       ld A,($FF)
  98D7  d037       jr Z,L9910
  98D9  74c0       and A,$C0
  98DB  01         swap A
  98DC  1d         shrc A
  98DD  1d         shrc A
  98DE  5b         ld B,A
  98DF  22ff       ld A,($FF)
  98E1  7430       and A,$30
  98E3  01         swap A
  98E4  5a         ld C,A
  98E5  22ff       ld A,($FF)
  98E7  740c       and A,$0C
  98E9  1d         shrc A
  98EA  1d         shrc A
  98EB  5d         ld D,A
  98EC  e0ff5c     ld E,($FF)
  98EF  ec7403     and E,$03
  98F2  178700     ld HL,$0087
L98F5:
  98F5  23         ld A,(HL)
  98F6  7703       cmp A,$03
  98F8  a2         jrs F,L98FC
  98F9  f653       ld (HL+),B
  98FB  8d         jrs T,L990A
L98FC:
  98FC  7702       cmp A,$02
  98FE  a2         jrs F,L9902
  98FF  f652       ld (HL+),C
  9901  87         jrs T,L990A
L9902:
  9902  7701       cmp A,$01
  9904  a2         jrs F,L9908
  9905  f655       ld (HL+),D
  9907  81         jrs T,L990A
L9908:
  9908  f654       ld (HL+),E
L990A:
  990A  eb3f9600   cmp HL,$0096
  990E  d4e5       jr LE,L98F5
L9910:
  9910  17b6cc     ld HL,$CCB6
  9913  2287       ld A,($87)
  9915  e0a708     rold A,($A7)
  9918  e0a75a     ld C,($A7)
  991B  e52697     ld ($97),(HL+C)
  991E  2288       ld A,($88)
  9920  e0a808     rold A,($A8)
  9923  e0a85a     ld C,($A8)
  9926  e52698     ld ($98),(HL+C)
  9929  2289       ld A,($89)
  992B  e0a908     rold A,($A9)
  992E  e0a95a     ld C,($A9)
  9931  e52699     ld ($99),(HL+C)
  9934  228a       ld A,($8A)
  9936  e0aa08     rold A,($AA)
  9939  e0aa5a     ld C,($AA)
  993C  e5269a     ld ($9A),(HL+C)
  993F  228b       ld A,($8B)
  9941  e0ab08     rold A,($AB)
  9944  e0ab5a     ld C,($AB)
  9947  e5269b     ld ($9B),(HL+C)
  994A  228c       ld A,($8C)
  994C  e0ac08     rold A,($AC)
  994F  e0ac5a     ld C,($AC)
  9952  e5269c     ld ($9C),(HL+C)
  9955  228d       ld A,($8D)
  9957  e0ad08     rold A,($AD)
  995A  e0ad5a     ld C,($AD)
  995D  e5269d     ld ($9D),(HL+C)
  9960  228e       ld A,($8E)
  9962  e0ae08     rold A,($AE)
  9965  e0ae5a     ld C,($AE)
  9968  e5269e     ld ($9E),(HL+C)
  996B  228f       ld A,($8F)
  996D  e0af08     rold A,($AF)
  9970  e0af5a     ld C,($AF)
  9973  e5269f     ld ($9F),(HL+C)
  9976  2290       ld A,($90)
  9978  e0b008     rold A,($B0)
  997B  e0b05a     ld C,($B0)
  997E  e526a0     ld ($A0),(HL+C)
  9981  2291       ld A,($91)
  9983  e0b108     rold A,($B1)
  9986  e0b15a     ld C,($B1)
  9989  e526a1     ld ($A1),(HL+C)
  998C  2292       ld A,($92)
  998E  e0b208     rold A,($B2)
  9991  e0b25a     ld C,($B2)
  9994  e526a2     ld ($A2),(HL+C)
  9997  2293       ld A,($93)
  9999  e0b308     rold A,($B3)
  999C  e0b35a     ld C,($B3)
  999F  e526a3     ld ($A3),(HL+C)
  99A2  2294       ld A,($94)
  99A4  e0b408     rold A,($B4)
  99A7  e0b45a     ld C,($B4)
  99AA  e526a4     ld ($A4),(HL+C)
  99AD  2295       ld A,($95)
  99AF  e0b508     rold A,($B5)
  99B2  e0b55a     ld C,($B5)
  99B5  e526a5     ld ($A5),(HL+C)
  99B8  2296       ld A,($96)
  99BA  e0b608     rold A,($B6)
  99BD  e0b65a     ld C,($B6)
  99C0  e526a6     ld ($A6),(HL+C)
  99C3  16e002     ld DE,$02E0
  99C6  2282       ld A,($82)
  99C8  01         swap A
  99C9  3100       ld W,$00
  99CB  ea31       add WA,DE
  99CD  e816       ld DE,WA
  99CF  2287       ld A,($87)
  99D1  1c         shlc A
  99D2  5a         ld C,A
  99D3  17b6be     ld HL,$BEB6
  99D6  e517       ld HL,(HL+C)
  99D8  2260       ld A,($60)
  99DA  3100       ld W,$00
  99DC  eb31       add WA,HL
  99DE  e817       ld HL,WA
  99E0  e09759     ld W,($97)
  99E3  2278       ld A,($78)
  99E5  e379       add A,(HL)
  99E7  e8df       test A.7
  99E9  a8         jrs F,L99F3
  99EA  e961       add A,W
  99EC  7764       cmp A,$64
  99EE  d408       jr LE,L99F8
  99F0  3064       ld A,$64
  99F2  84         jrs T,L99F8
L99F3:
  99F3  e961       add A,W
  99F5  81         jrs T,L99F8
  99F6  3000       ld A,$00
L99F8:
  99F8  f250       ld (DE),A
  99FA  12         inc DE
  99FB  2288       ld A,($88)
  99FD  1c         shlc A
  99FE  5a         ld C,A
  99FF  17b6be     ld HL,$BEB6
  9A02  e517       ld HL,(HL+C)
  9A04  2261       ld A,($61)
  9A06  3100       ld W,$00
  9A08  eb31       add WA,HL
  9A0A  e817       ld HL,WA
  9A0C  e09859     ld W,($98)
  9A0F  2278       ld A,($78)
  9A11  e379       add A,(HL)
  9A13  e8df       test A.7
  9A15  a8         jrs F,L9A1F
  9A16  e961       add A,W
  9A18  7764       cmp A,$64
  9A1A  d408       jr LE,L9A24
  9A1C  3064       ld A,$64
  9A1E  84         jrs T,L9A24
L9A1F:
  9A1F  e961       add A,W
  9A21  81         jrs T,L9A24
  9A22  3000       ld A,$00
L9A24:
  9A24  f250       ld (DE),A
  9A26  12         inc DE
  9A27  2289       ld A,($89)
  9A29  1c         shlc A
  9A2A  5a         ld C,A
  9A2B  17b6be     ld HL,$BEB6
  9A2E  e517       ld HL,(HL+C)
  9A30  2262       ld A,($62)
  9A32  3100       ld W,$00
  9A34  eb31       add WA,HL
  9A36  e817       ld HL,WA
  9A38  e09959     ld W,($99)
  9A3B  2278       ld A,($78)
  9A3D  e379       add A,(HL)
  9A3F  e8df       test A.7
  9A41  a8         jrs F,L9A4B
  9A42  e961       add A,W
  9A44  7764       cmp A,$64
  9A46  d408       jr LE,L9A50
  9A48  3064       ld A,$64
  9A4A  84         jrs T,L9A50
L9A4B:
  9A4B  e961       add A,W
  9A4D  81         jrs T,L9A50
  9A4E  3000       ld A,$00
L9A50:
  9A50  f250       ld (DE),A
  9A52  12         inc DE
  9A53  228a       ld A,($8A)
  9A55  1c         shlc A
  9A56  5a         ld C,A
  9A57  17b6be     ld HL,$BEB6
  9A5A  e517       ld HL,(HL+C)
  9A5C  2263       ld A,($63)
  9A5E  3100       ld W,$00
  9A60  eb31       add WA,HL
  9A62  e817       ld HL,WA
  9A64  e09a59     ld W,($9A)
  9A67  2278       ld A,($78)
  9A69  e379       add A,(HL)
  9A6B  e8df       test A.7
  9A6D  a8         jrs F,L9A77
  9A6E  e961       add A,W
  9A70  7764       cmp A,$64
  9A72  d408       jr LE,L9A7C
  9A74  3064       ld A,$64
  9A76  84         jrs T,L9A7C
L9A77:
  9A77  e961       add A,W
  9A79  81         jrs T,L9A7C
  9A7A  3000       ld A,$00
L9A7C:
  9A7C  f250       ld (DE),A
  9A7E  12         inc DE
  9A7F  228b       ld A,($8B)
  9A81  1c         shlc A
  9A82  5a         ld C,A
  9A83  17b6be     ld HL,$BEB6
  9A86  e517       ld HL,(HL+C)
  9A88  2264       ld A,($64)
  9A8A  3100       ld W,$00
  9A8C  eb31       add WA,HL
  9A8E  e817       ld HL,WA
  9A90  e09b59     ld W,($9B)
  9A93  2278       ld A,($78)
  9A95  e379       add A,(HL)
  9A97  e8df       test A.7
  9A99  a8         jrs F,L9AA3
  9A9A  e961       add A,W
  9A9C  7764       cmp A,$64
  9A9E  d408       jr LE,L9AA8
  9AA0  3064       ld A,$64
  9AA2  84         jrs T,L9AA8
L9AA3:
  9AA3  e961       add A,W
  9AA5  81         jrs T,L9AA8
  9AA6  3000       ld A,$00
L9AA8:
  9AA8  f250       ld (DE),A
  9AAA  12         inc DE
  9AAB  228c       ld A,($8C)
  9AAD  1c         shlc A
  9AAE  5a         ld C,A
  9AAF  17b6be     ld HL,$BEB6
  9AB2  e517       ld HL,(HL+C)
  9AB4  2265       ld A,($65)
  9AB6  3100       ld W,$00
  9AB8  eb31       add WA,HL
  9ABA  e817       ld HL,WA
  9ABC  e09c59     ld W,($9C)
  9ABF  2278       ld A,($78)
  9AC1  e379       add A,(HL)
  9AC3  e8df       test A.7
  9AC5  a8         jrs F,L9ACF
  9AC6  e961       add A,W
  9AC8  7764       cmp A,$64
  9ACA  d408       jr LE,L9AD4
  9ACC  3064       ld A,$64
  9ACE  84         jrs T,L9AD4
L9ACF:
  9ACF  e961       add A,W
  9AD1  81         jrs T,L9AD4
  9AD2  3000       ld A,$00
L9AD4:
  9AD4  f250       ld (DE),A
  9AD6  12         inc DE
  9AD7  228d       ld A,($8D)
  9AD9  1c         shlc A
  9ADA  5a         ld C,A
  9ADB  17b6be     ld HL,$BEB6
  9ADE  e517       ld HL,(HL+C)
  9AE0  2266       ld A,($66)
  9AE2  3100       ld W,$00
  9AE4  eb31       add WA,HL
  9AE6  e817       ld HL,WA
  9AE8  e09d59     ld W,($9D)
  9AEB  2278       ld A,($78)
  9AED  e379       add A,(HL)
  9AEF  e8df       test A.7
  9AF1  a8         jrs F,L9AFB
  9AF2  e961       add A,W
  9AF4  7764       cmp A,$64
  9AF6  d408       jr LE,L9B00
  9AF8  3064       ld A,$64
  9AFA  84         jrs T,L9B00
L9AFB:
  9AFB  e961       add A,W
  9AFD  81         jrs T,L9B00
  9AFE  3000       ld A,$00
L9B00:
  9B00  f250       ld (DE),A
  9B02  12         inc DE
  9B03  228e       ld A,($8E)
  9B05  1c         shlc A
  9B06  5a         ld C,A
  9B07  17b6be     ld HL,$BEB6
  9B0A  e517       ld HL,(HL+C)
  9B0C  2267       ld A,($67)
  9B0E  3100       ld W,$00
  9B10  eb31       add WA,HL
  9B12  e817       ld HL,WA
  9B14  e09e59     ld W,($9E)
  9B17  2278       ld A,($78)
  9B19  e379       add A,(HL)
  9B1B  e8df       test A.7
  9B1D  a8         jrs F,L9B27
  9B1E  e961       add A,W
  9B20  7764       cmp A,$64
  9B22  d408       jr LE,L9B2C
  9B24  3064       ld A,$64
  9B26  84         jrs T,L9B2C
L9B27:
  9B27  e961       add A,W
  9B29  81         jrs T,L9B2C
  9B2A  3000       ld A,$00
L9B2C:
  9B2C  f250       ld (DE),A
  9B2E  12         inc DE
  9B2F  228f       ld A,($8F)
  9B31  1c         shlc A
  9B32  5a         ld C,A
  9B33  17b6be     ld HL,$BEB6
  9B36  e517       ld HL,(HL+C)
  9B38  2268       ld A,($68)
  9B3A  3100       ld W,$00
  9B3C  eb31       add WA,HL
  9B3E  e817       ld HL,WA
  9B40  e09f59     ld W,($9F)
  9B43  2278       ld A,($78)
  9B45  e379       add A,(HL)
  9B47  e8df       test A.7
  9B49  a8         jrs F,L9B53
  9B4A  e961       add A,W
  9B4C  7764       cmp A,$64
  9B4E  d408       jr LE,L9B58
  9B50  3064       ld A,$64
  9B52  84         jrs T,L9B58
L9B53:
  9B53  e961       add A,W
  9B55  81         jrs T,L9B58
  9B56  3000       ld A,$00
L9B58:
  9B58  f250       ld (DE),A
  9B5A  12         inc DE
  9B5B  2290       ld A,($90)
  9B5D  1c         shlc A
  9B5E  5a         ld C,A
  9B5F  17b6be     ld HL,$BEB6
  9B62  e517       ld HL,(HL+C)
  9B64  2269       ld A,($69)
  9B66  3100       ld W,$00
  9B68  eb31       add WA,HL
  9B6A  e817       ld HL,WA
  9B6C  e0a059     ld W,($A0)
  9B6F  2278       ld A,($78)
  9B71  e379       add A,(HL)
  9B73  e8df       test A.7
  9B75  a8         jrs F,L9B7F
  9B76  e961       add A,W
  9B78  7764       cmp A,$64
  9B7A  d408       jr LE,L9B84
  9B7C  3064       ld A,$64
  9B7E  84         jrs T,L9B84
L9B7F:
  9B7F  e961       add A,W
  9B81  81         jrs T,L9B84
  9B82  3000       ld A,$00
L9B84:
  9B84  f250       ld (DE),A
  9B86  12         inc DE
  9B87  2291       ld A,($91)
  9B89  1c         shlc A
  9B8A  5a         ld C,A
  9B8B  17b6be     ld HL,$BEB6
  9B8E  e517       ld HL,(HL+C)
  9B90  226a       ld A,($6A)
  9B92  3100       ld W,$00
  9B94  eb31       add WA,HL
  9B96  e817       ld HL,WA
  9B98  e0a159     ld W,($A1)
  9B9B  2278       ld A,($78)
  9B9D  e379       add A,(HL)
  9B9F  e8df       test A.7
  9BA1  a8         jrs F,L9BAB
  9BA2  e961       add A,W
  9BA4  7764       cmp A,$64
  9BA6  d408       jr LE,L9BB0
  9BA8  3064       ld A,$64
  9BAA  84         jrs T,L9BB0
L9BAB:
  9BAB  e961       add A,W
  9BAD  81         jrs T,L9BB0
  9BAE  3000       ld A,$00
L9BB0:
  9BB0  f250       ld (DE),A
  9BB2  12         inc DE
  9BB3  2292       ld A,($92)
  9BB5  1c         shlc A
  9BB6  5a         ld C,A
  9BB7  17b6be     ld HL,$BEB6
  9BBA  e517       ld HL,(HL+C)
  9BBC  226b       ld A,($6B)
  9BBE  3100       ld W,$00
  9BC0  eb31       add WA,HL
  9BC2  e817       ld HL,WA
  9BC4  e0a259     ld W,($A2)
  9BC7  2278       ld A,($78)
  9BC9  e379       add A,(HL)
  9BCB  e8df       test A.7
  9BCD  a8         jrs F,L9BD7
  9BCE  e961       add A,W
  9BD0  7764       cmp A,$64
  9BD2  d408       jr LE,L9BDC
  9BD4  3064       ld A,$64
  9BD6  84         jrs T,L9BDC
L9BD7:
  9BD7  e961       add A,W
  9BD9  81         jrs T,L9BDC
  9BDA  3000       ld A,$00
L9BDC:
  9BDC  f250       ld (DE),A
  9BDE  12         inc DE
  9BDF  2293       ld A,($93)
  9BE1  1c         shlc A
  9BE2  5a         ld C,A
  9BE3  17b6be     ld HL,$BEB6
  9BE6  e517       ld HL,(HL+C)
  9BE8  226c       ld A,($6C)
  9BEA  3100       ld W,$00
  9BEC  eb31       add WA,HL
  9BEE  e817       ld HL,WA
  9BF0  e0a359     ld W,($A3)
  9BF3  2278       ld A,($78)
  9BF5  e379       add A,(HL)
  9BF7  e8df       test A.7
  9BF9  a8         jrs F,L9C03
  9BFA  e961       add A,W
  9BFC  7764       cmp A,$64
  9BFE  d408       jr LE,L9C08
  9C00  3064       ld A,$64
  9C02  84         jrs T,L9C08
L9C03:
  9C03  e961       add A,W
  9C05  81         jrs T,L9C08
  9C06  3000       ld A,$00
L9C08:
  9C08  f250       ld (DE),A
  9C0A  12         inc DE
  9C0B  2294       ld A,($94)
  9C0D  1c         shlc A
  9C0E  5a         ld C,A
  9C0F  17b6be     ld HL,$BEB6
  9C12  e517       ld HL,(HL+C)
  9C14  226d       ld A,($6D)
  9C16  3100       ld W,$00
  9C18  eb31       add WA,HL
  9C1A  e817       ld HL,WA
  9C1C  e0a459     ld W,($A4)
  9C1F  2278       ld A,($78)
  9C21  e379       add A,(HL)
  9C23  e8df       test A.7
  9C25  a8         jrs F,L9C2F
  9C26  e961       add A,W
  9C28  7764       cmp A,$64
  9C2A  d408       jr LE,L9C34
  9C2C  3064       ld A,$64
  9C2E  84         jrs T,L9C34
L9C2F:
  9C2F  e961       add A,W
  9C31  81         jrs T,L9C34
  9C32  3000       ld A,$00
L9C34:
  9C34  f250       ld (DE),A
  9C36  12         inc DE
  9C37  2295       ld A,($95)
  9C39  1c         shlc A
  9C3A  5a         ld C,A
  9C3B  17b6be     ld HL,$BEB6
  9C3E  e517       ld HL,(HL+C)
  9C40  226e       ld A,($6E)
  9C42  3100       ld W,$00
  9C44  eb31       add WA,HL
  9C46  e817       ld HL,WA
  9C48  e0a559     ld W,($A5)
  9C4B  2278       ld A,($78)
  9C4D  e379       add A,(HL)
  9C4F  e8df       test A.7
  9C51  a8         jrs F,L9C5B
  9C52  e961       add A,W
  9C54  7764       cmp A,$64
  9C56  d408       jr LE,L9C60
  9C58  3064       ld A,$64
  9C5A  84         jrs T,L9C60
L9C5B:
  9C5B  e961       add A,W
  9C5D  81         jrs T,L9C60
  9C5E  3000       ld A,$00
L9C60:
  9C60  f250       ld (DE),A
  9C62  12         inc DE
  9C63  2296       ld A,($96)
  9C65  1c         shlc A
  9C66  5a         ld C,A
  9C67  17b6be     ld HL,$BEB6
  9C6A  e517       ld HL,(HL+C)
  9C6C  226f       ld A,($6F)
  9C6E  3100       ld W,$00
  9C70  eb31       add WA,HL
  9C72  e817       ld HL,WA
  9C74  e0a659     ld W,($A6)
  9C77  2278       ld A,($78)
  9C79  e379       add A,(HL)
  9C7B  e8df       test A.7
  9C7D  a8         jrs F,L9C87
  9C7E  e961       add A,W
  9C80  7764       cmp A,$64
  9C82  d408       jr LE,L9C8C
  9C84  3064       ld A,$64
  9C86  84         jrs T,L9C8C
L9C87:
  9C87  e961       add A,W
  9C89  81         jrs T,L9C8C
  9C8A  3000       ld A,$00
L9C8C:
  9C8C  f250       ld (DE),A
  9C8E  16e002     ld DE,$02E0
  9C91  2282       ld A,($82)
  9C93  01         swap A
  9C94  3100       ld W,$00
  9C96  ea31       add WA,DE
  9C98  e817       ld HL,WA
  9C9A  e35a       ld C,(HL)
  9C9C  1776d1     ld HL,$D176
  9C9F  e558       ld A,(HL+C)
  9CA1  d021       jr Z,L9CC4
  9CA3  40fa       set ($FA).0
  9CA5  d71f       jr F,L9CC6
  9CA7  e0a77703   cmp ($A7),$03
  9CAB  d519       jr GT,L9CC6
  9CAD  e0fd5a     ld C,($FD)
  9CB0  3300       ld B,$00
  9CB2  ea1c       shlc C
  9CB4  eb1e       rolc B
  9CB6  1476d2     ld WA,$D276
  9CB9  e931       add WA,BC
  9CBB  e817       ld HL,WA
  9CBD  e314       ld WA,(HL)
  9CBF  e0b717     ld HL,($B7)
  9CC2  fb13       jr L9CD7
L9CC4:
  9CC4  22f9       ld A,($F9)
L9CC6:
  9CC6  e0b717     ld HL,($B7)
  9CC9  e8df       test A.7
  9CCB  88         jrs T,L9CD5
  9CCC  31ff       ld W,$FF
  9CCE  eb31       add WA,HL
  9CD0  8b         jrs T,L9CDD
  9CD1  140000     ld WA,$0000
  9CD4  87         jrs T,L9CDD
L9CD5:
  9CD5  3100       ld W,$00
L9CD7:
  9CD7  eb31       add WA,HL
  9CD9  a2         jrs F,L9CDD
  9CDA  14ffff     ld WA,$FFFF
L9CDD:
  9CDD  f0b710     ld ($B7),WA
  9CE0  12         inc DE
  9CE1  2282       ld A,($82)
  9CE3  01         swap A
  9CE4  3100       ld W,$00
  9CE6  ea31       add WA,DE
  9CE8  e817       ld HL,WA
  9CEA  e35a       ld C,(HL)
  9CEC  1776d1     ld HL,$D176
  9CEF  e558       ld A,(HL+C)
  9CF1  d021       jr Z,L9D14
  9CF3  41fa       set ($FA).1
  9CF5  d71f       jr F,L9D16
  9CF7  e0a87703   cmp ($A8),$03
  9CFB  d519       jr GT,L9D16
  9CFD  e0fd5a     ld C,($FD)
  9D00  3300       ld B,$00
  9D02  ea1c       shlc C
  9D04  eb1e       rolc B
  9D06  1476d2     ld WA,$D276
  9D09  e931       add WA,BC
  9D0B  e817       ld HL,WA
  9D0D  e314       ld WA,(HL)
  9D0F  e0b917     ld HL,($B9)
  9D12  fb13       jr L9D27
L9D14:
  9D14  22f9       ld A,($F9)
L9D16:
  9D16  e0b917     ld HL,($B9)
  9D19  e8df       test A.7
  9D1B  88         jrs T,L9D25
  9D1C  31ff       ld W,$FF
  9D1E  eb31       add WA,HL
  9D20  8b         jrs T,L9D2D
  9D21  140000     ld WA,$0000
  9D24  87         jrs T,L9D2D
L9D25:
  9D25  3100       ld W,$00
L9D27:
  9D27  eb31       add WA,HL
  9D29  a2         jrs F,L9D2D
  9D2A  14ffff     ld WA,$FFFF
L9D2D:
  9D2D  f0b910     ld ($B9),WA
  9D30  12         inc DE
  9D31  2282       ld A,($82)
  9D33  01         swap A
  9D34  3100       ld W,$00
  9D36  ea31       add WA,DE
  9D38  e817       ld HL,WA
  9D3A  e35a       ld C,(HL)
  9D3C  1776d1     ld HL,$D176
  9D3F  e558       ld A,(HL+C)
  9D41  d021       jr Z,L9D64
  9D43  42fa       set ($FA).2
  9D45  d71f       jr F,L9D66
  9D47  e0a97703   cmp ($A9),$03
  9D4B  d519       jr GT,L9D66
  9D4D  e0fd5a     ld C,($FD)
  9D50  3300       ld B,$00
  9D52  ea1c       shlc C
  9D54  eb1e       rolc B
  9D56  1476d2     ld WA,$D276
  9D59  e931       add WA,BC
  9D5B  e817       ld HL,WA
  9D5D  e314       ld WA,(HL)
  9D5F  e0bb17     ld HL,($BB)
  9D62  fb13       jr L9D77
L9D64:
  9D64  22f9       ld A,($F9)
L9D66:
  9D66  e0bb17     ld HL,($BB)
  9D69  e8df       test A.7
  9D6B  88         jrs T,L9D75
  9D6C  31ff       ld W,$FF
  9D6E  eb31       add WA,HL
  9D70  8b         jrs T,L9D7D
  9D71  140000     ld WA,$0000
  9D74  87         jrs T,L9D7D
L9D75:
  9D75  3100       ld W,$00
L9D77:
  9D77  eb31       add WA,HL
  9D79  a2         jrs F,L9D7D
  9D7A  14ffff     ld WA,$FFFF
L9D7D:
  9D7D  f0bb10     ld ($BB),WA
  9D80  12         inc DE
  9D81  2282       ld A,($82)
  9D83  01         swap A
  9D84  3100       ld W,$00
  9D86  ea31       add WA,DE
  9D88  e817       ld HL,WA
  9D8A  e35a       ld C,(HL)
  9D8C  1776d1     ld HL,$D176
  9D8F  e558       ld A,(HL+C)
  9D91  d021       jr Z,L9DB4
  9D93  43fa       set ($FA).3
  9D95  d71f       jr F,L9DB6
  9D97  e0aa7703   cmp ($AA),$03
  9D9B  d519       jr GT,L9DB6
  9D9D  e0fd5a     ld C,($FD)
  9DA0  3300       ld B,$00
  9DA2  ea1c       shlc C
  9DA4  eb1e       rolc B
  9DA6  1476d2     ld WA,$D276
  9DA9  e931       add WA,BC
  9DAB  e817       ld HL,WA
  9DAD  e314       ld WA,(HL)
  9DAF  e0bd17     ld HL,($BD)
  9DB2  fb13       jr L9DC7
L9DB4:
  9DB4  22f9       ld A,($F9)
L9DB6:
  9DB6  e0bd17     ld HL,($BD)
  9DB9  e8df       test A.7
  9DBB  88         jrs T,L9DC5
  9DBC  31ff       ld W,$FF
  9DBE  eb31       add WA,HL
  9DC0  8b         jrs T,L9DCD
  9DC1  140000     ld WA,$0000
  9DC4  87         jrs T,L9DCD
L9DC5:
  9DC5  3100       ld W,$00
L9DC7:
  9DC7  eb31       add WA,HL
  9DC9  a2         jrs F,L9DCD
  9DCA  14ffff     ld WA,$FFFF
L9DCD:
  9DCD  f0bd10     ld ($BD),WA
  9DD0  12         inc DE
  9DD1  2282       ld A,($82)
  9DD3  01         swap A
  9DD4  3100       ld W,$00
  9DD6  ea31       add WA,DE
  9DD8  e817       ld HL,WA
  9DDA  e35a       ld C,(HL)
  9DDC  1776d1     ld HL,$D176
  9DDF  e558       ld A,(HL+C)
  9DE1  d021       jr Z,L9E04
  9DE3  44fa       set ($FA).4
  9DE5  d71f       jr F,L9E06
  9DE7  e0ab7703   cmp ($AB),$03
  9DEB  d519       jr GT,L9E06
  9DED  e0fd5a     ld C,($FD)
  9DF0  3300       ld B,$00
  9DF2  ea1c       shlc C
  9DF4  eb1e       rolc B
  9DF6  1476d2     ld WA,$D276
  9DF9  e931       add WA,BC
  9DFB  e817       ld HL,WA
  9DFD  e314       ld WA,(HL)
  9DFF  e0bf17     ld HL,($BF)
  9E02  fb13       jr L9E17
L9E04:
  9E04  22f9       ld A,($F9)
L9E06:
  9E06  e0bf17     ld HL,($BF)
  9E09  e8df       test A.7
  9E0B  88         jrs T,L9E15
  9E0C  31ff       ld W,$FF
  9E0E  eb31       add WA,HL
  9E10  8b         jrs T,L9E1D
  9E11  140000     ld WA,$0000
  9E14  87         jrs T,L9E1D
L9E15:
  9E15  3100       ld W,$00
L9E17:
  9E17  eb31       add WA,HL
  9E19  a2         jrs F,L9E1D
  9E1A  14ffff     ld WA,$FFFF
L9E1D:
  9E1D  f0bf10     ld ($BF),WA
  9E20  12         inc DE
  9E21  2282       ld A,($82)
  9E23  01         swap A
  9E24  3100       ld W,$00
  9E26  ea31       add WA,DE
  9E28  e817       ld HL,WA
  9E2A  e35a       ld C,(HL)
  9E2C  1776d1     ld HL,$D176
  9E2F  e558       ld A,(HL+C)
  9E31  d021       jr Z,L9E54
  9E33  45fa       set ($FA).5
  9E35  d71f       jr F,L9E56
  9E37  e0ac7703   cmp ($AC),$03
  9E3B  d519       jr GT,L9E56
  9E3D  e0fd5a     ld C,($FD)
  9E40  3300       ld B,$00
  9E42  ea1c       shlc C
  9E44  eb1e       rolc B
  9E46  1476d2     ld WA,$D276
  9E49  e931       add WA,BC
  9E4B  e817       ld HL,WA
  9E4D  e314       ld WA,(HL)
  9E4F  e0c117     ld HL,($C1)
  9E52  fb13       jr L9E67
L9E54:
  9E54  22f9       ld A,($F9)
L9E56:
  9E56  e0c117     ld HL,($C1)
  9E59  e8df       test A.7
  9E5B  88         jrs T,L9E65
  9E5C  31ff       ld W,$FF
  9E5E  eb31       add WA,HL
  9E60  8b         jrs T,L9E6D
  9E61  140000     ld WA,$0000
  9E64  87         jrs T,L9E6D
L9E65:
  9E65  3100       ld W,$00
L9E67:
  9E67  eb31       add WA,HL
  9E69  a2         jrs F,L9E6D
  9E6A  14ffff     ld WA,$FFFF
L9E6D:
  9E6D  f0c110     ld ($C1),WA
  9E70  12         inc DE
  9E71  2282       ld A,($82)
  9E73  01         swap A
  9E74  3100       ld W,$00
  9E76  ea31       add WA,DE
  9E78  e817       ld HL,WA
  9E7A  e35a       ld C,(HL)
  9E7C  1776d1     ld HL,$D176
  9E7F  e558       ld A,(HL+C)
  9E81  d021       jr Z,L9EA4
  9E83  46fa       set ($FA).6
  9E85  d71f       jr F,L9EA6
  9E87  e0ad7703   cmp ($AD),$03
  9E8B  d519       jr GT,L9EA6
  9E8D  e0fd5a     ld C,($FD)
  9E90  3300       ld B,$00
  9E92  ea1c       shlc C
  9E94  eb1e       rolc B
  9E96  1476d2     ld WA,$D276
  9E99  e931       add WA,BC
  9E9B  e817       ld HL,WA
  9E9D  e314       ld WA,(HL)
  9E9F  e0c317     ld HL,($C3)
  9EA2  fb13       jr L9EB7
L9EA4:
  9EA4  22f9       ld A,($F9)
L9EA6:
  9EA6  e0c317     ld HL,($C3)
  9EA9  e8df       test A.7
  9EAB  88         jrs T,L9EB5
  9EAC  31ff       ld W,$FF
  9EAE  eb31       add WA,HL
  9EB0  8b         jrs T,L9EBD
  9EB1  140000     ld WA,$0000
  9EB4  87         jrs T,L9EBD
L9EB5:
  9EB5  3100       ld W,$00
L9EB7:
  9EB7  eb31       add WA,HL
  9EB9  a2         jrs F,L9EBD
  9EBA  14ffff     ld WA,$FFFF
L9EBD:
  9EBD  f0c310     ld ($C3),WA
  9EC0  12         inc DE
  9EC1  2282       ld A,($82)
  9EC3  01         swap A
  9EC4  3100       ld W,$00
  9EC6  ea31       add WA,DE
  9EC8  e817       ld HL,WA
  9ECA  e35a       ld C,(HL)
  9ECC  1776d1     ld HL,$D176
  9ECF  e558       ld A,(HL+C)
  9ED1  d021       jr Z,L9EF4
  9ED3  47fa       set ($FA).7
  9ED5  d71f       jr F,L9EF6
  9ED7  e0ae7703   cmp ($AE),$03
  9EDB  d519       jr GT,L9EF6
  9EDD  e0fd5a     ld C,($FD)
  9EE0  3300       ld B,$00
  9EE2  ea1c       shlc C
  9EE4  eb1e       rolc B
  9EE6  1476d2     ld WA,$D276
  9EE9  e931       add WA,BC
  9EEB  e817       ld HL,WA
  9EED  e314       ld WA,(HL)
  9EEF  e0c517     ld HL,($C5)
  9EF2  fb13       jr L9F07
L9EF4:
  9EF4  22f9       ld A,($F9)
L9EF6:
  9EF6  e0c517     ld HL,($C5)
  9EF9  e8df       test A.7
  9EFB  88         jrs T,L9F05
  9EFC  31ff       ld W,$FF
  9EFE  eb31       add WA,HL
  9F00  8b         jrs T,L9F0D
  9F01  140000     ld WA,$0000
  9F04  87         jrs T,L9F0D
L9F05:
  9F05  3100       ld W,$00
L9F07:
  9F07  eb31       add WA,HL
  9F09  a2         jrs F,L9F0D
  9F0A  14ffff     ld WA,$FFFF
L9F0D:
  9F0D  f0c510     ld ($C5),WA
  9F10  12         inc DE
  9F11  2282       ld A,($82)
  9F13  01         swap A
  9F14  3100       ld W,$00
  9F16  ea31       add WA,DE
  9F18  e817       ld HL,WA
  9F1A  e35a       ld C,(HL)
  9F1C  1776d1     ld HL,$D176
  9F1F  e558       ld A,(HL+C)
  9F21  d021       jr Z,L9F44
  9F23  40fb       set ($FB).0
  9F25  d71f       jr F,L9F46
  9F27  e0af7703   cmp ($AF),$03
  9F2B  d519       jr GT,L9F46
  9F2D  e0fd5a     ld C,($FD)
  9F30  3300       ld B,$00
  9F32  ea1c       shlc C
  9F34  eb1e       rolc B
  9F36  1476d2     ld WA,$D276
  9F39  e931       add WA,BC
  9F3B  e817       ld HL,WA
  9F3D  e314       ld WA,(HL)
  9F3F  e0c717     ld HL,($C7)
  9F42  fb13       jr L9F57
L9F44:
  9F44  22f9       ld A,($F9)
L9F46:
  9F46  e0c717     ld HL,($C7)
  9F49  e8df       test A.7
  9F4B  88         jrs T,L9F55
  9F4C  31ff       ld W,$FF
  9F4E  eb31       add WA,HL
  9F50  8b         jrs T,L9F5D
  9F51  140000     ld WA,$0000
  9F54  87         jrs T,L9F5D
L9F55:
  9F55  3100       ld W,$00
L9F57:
  9F57  eb31       add WA,HL
  9F59  a2         jrs F,L9F5D
  9F5A  14ffff     ld WA,$FFFF
L9F5D:
  9F5D  f0c710     ld ($C7),WA
  9F60  12         inc DE
  9F61  2282       ld A,($82)
  9F63  01         swap A
  9F64  3100       ld W,$00
  9F66  ea31       add WA,DE
  9F68  e817       ld HL,WA
  9F6A  e35a       ld C,(HL)
  9F6C  1776d1     ld HL,$D176
  9F6F  e558       ld A,(HL+C)
  9F71  d021       jr Z,L9F94
  9F73  41fb       set ($FB).1
  9F75  d71f       jr F,L9F96
  9F77  e0b07703   cmp ($B0),$03
  9F7B  d519       jr GT,L9F96
  9F7D  e0fd5a     ld C,($FD)
  9F80  3300       ld B,$00
  9F82  ea1c       shlc C
  9F84  eb1e       rolc B
  9F86  1476d2     ld WA,$D276
  9F89  e931       add WA,BC
  9F8B  e817       ld HL,WA
  9F8D  e314       ld WA,(HL)
  9F8F  e0c917     ld HL,($C9)
  9F92  fb13       jr L9FA7
L9F94:
  9F94  22f9       ld A,($F9)
L9F96:
  9F96  e0c917     ld HL,($C9)
  9F99  e8df       test A.7
  9F9B  88         jrs T,L9FA5
  9F9C  31ff       ld W,$FF
  9F9E  eb31       add WA,HL
  9FA0  8b         jrs T,L9FAD
  9FA1  140000     ld WA,$0000
  9FA4  87         jrs T,L9FAD
L9FA5:
  9FA5  3100       ld W,$00
L9FA7:
  9FA7  eb31       add WA,HL
  9FA9  a2         jrs F,L9FAD
  9FAA  14ffff     ld WA,$FFFF
L9FAD:
  9FAD  f0c910     ld ($C9),WA
  9FB0  12         inc DE
  9FB1  2282       ld A,($82)
  9FB3  01         swap A
  9FB4  3100       ld W,$00
  9FB6  ea31       add WA,DE
  9FB8  e817       ld HL,WA
  9FBA  e35a       ld C,(HL)
  9FBC  1776d1     ld HL,$D176
  9FBF  e558       ld A,(HL+C)
  9FC1  d021       jr Z,L9FE4
  9FC3  42fb       set ($FB).2
  9FC5  d71f       jr F,L9FE6
  9FC7  e0b17703   cmp ($B1),$03
  9FCB  d519       jr GT,L9FE6
  9FCD  e0fd5a     ld C,($FD)
  9FD0  3300       ld B,$00
  9FD2  ea1c       shlc C
  9FD4  eb1e       rolc B
  9FD6  1476d2     ld WA,$D276
  9FD9  e931       add WA,BC
  9FDB  e817       ld HL,WA
  9FDD  e314       ld WA,(HL)
  9FDF  e0cb17     ld HL,($CB)
  9FE2  fb13       jr L9FF7
L9FE4:
  9FE4  22f9       ld A,($F9)
L9FE6:
  9FE6  e0cb17     ld HL,($CB)
  9FE9  e8df       test A.7
  9FEB  88         jrs T,L9FF5
  9FEC  31ff       ld W,$FF
  9FEE  eb31       add WA,HL
  9FF0  8b         jrs T,L9FFD
  9FF1  140000     ld WA,$0000
  9FF4  87         jrs T,L9FFD
L9FF5:
  9FF5  3100       ld W,$00
L9FF7:
  9FF7  eb31       add WA,HL
  9FF9  a2         jrs F,L9FFD
  9FFA  14ffff     ld WA,$FFFF
L9FFD:
  9FFD  f0cb10     ld ($CB),WA
  A000  12         inc DE
  A001  2282       ld A,($82)
  A003  01         swap A
  A004  3100       ld W,$00
  A006  ea31       add WA,DE
  A008  e817       ld HL,WA
  A00A  e35a       ld C,(HL)
  A00C  1776d1     ld HL,$D176
  A00F  e558       ld A,(HL+C)
  A011  d021       jr Z,LA034
  A013  43fb       set ($FB).3
  A015  d71f       jr F,LA036
  A017  e0b27703   cmp ($B2),$03
  A01B  d519       jr GT,LA036
  A01D  e0fd5a     ld C,($FD)
  A020  3300       ld B,$00
  A022  ea1c       shlc C
  A024  eb1e       rolc B
  A026  1476d2     ld WA,$D276
  A029  e931       add WA,BC
  A02B  e817       ld HL,WA
  A02D  e314       ld WA,(HL)
  A02F  e0cd17     ld HL,($CD)
  A032  fb13       jr LA047
LA034:
  A034  22f9       ld A,($F9)
LA036:
  A036  e0cd17     ld HL,($CD)
  A039  e8df       test A.7
  A03B  88         jrs T,LA045
  A03C  31ff       ld W,$FF
  A03E  eb31       add WA,HL
  A040  8b         jrs T,LA04D
  A041  140000     ld WA,$0000
  A044  87         jrs T,LA04D
LA045:
  A045  3100       ld W,$00
LA047:
  A047  eb31       add WA,HL
  A049  a2         jrs F,LA04D
  A04A  14ffff     ld WA,$FFFF
LA04D:
  A04D  f0cd10     ld ($CD),WA
  A050  12         inc DE
  A051  2282       ld A,($82)
  A053  01         swap A
  A054  3100       ld W,$00
  A056  ea31       add WA,DE
  A058  e817       ld HL,WA
  A05A  e35a       ld C,(HL)
  A05C  1776d1     ld HL,$D176
  A05F  e558       ld A,(HL+C)
  A061  d021       jr Z,LA084
  A063  44fb       set ($FB).4
  A065  d71f       jr F,LA086
  A067  e0b37703   cmp ($B3),$03
  A06B  d519       jr GT,LA086
  A06D  e0fd5a     ld C,($FD)
  A070  3300       ld B,$00
  A072  ea1c       shlc C
  A074  eb1e       rolc B
  A076  1476d2     ld WA,$D276
  A079  e931       add WA,BC
  A07B  e817       ld HL,WA
  A07D  e314       ld WA,(HL)
  A07F  e0cf17     ld HL,($CF)
  A082  fb13       jr LA097
LA084:
  A084  22f9       ld A,($F9)
LA086:
  A086  e0cf17     ld HL,($CF)
  A089  e8df       test A.7
  A08B  88         jrs T,LA095
  A08C  31ff       ld W,$FF
  A08E  eb31       add WA,HL
  A090  8b         jrs T,LA09D
  A091  140000     ld WA,$0000
  A094  87         jrs T,LA09D
LA095:
  A095  3100       ld W,$00
LA097:
  A097  eb31       add WA,HL
  A099  a2         jrs F,LA09D
  A09A  14ffff     ld WA,$FFFF
LA09D:
  A09D  f0cf10     ld ($CF),WA
  A0A0  12         inc DE
  A0A1  2282       ld A,($82)
  A0A3  01         swap A
  A0A4  3100       ld W,$00
  A0A6  ea31       add WA,DE
  A0A8  e817       ld HL,WA
  A0AA  e35a       ld C,(HL)
  A0AC  1776d1     ld HL,$D176
  A0AF  e558       ld A,(HL+C)
  A0B1  d021       jr Z,LA0D4
  A0B3  45fb       set ($FB).5
  A0B5  d71f       jr F,LA0D6
  A0B7  e0b47703   cmp ($B4),$03
  A0BB  d519       jr GT,LA0D6
  A0BD  e0fd5a     ld C,($FD)
  A0C0  3300       ld B,$00
  A0C2  ea1c       shlc C
  A0C4  eb1e       rolc B
  A0C6  1476d2     ld WA,$D276
  A0C9  e931       add WA,BC
  A0CB  e817       ld HL,WA
  A0CD  e314       ld WA,(HL)
  A0CF  e0d117     ld HL,($D1)
  A0D2  fb13       jr LA0E7
LA0D4:
  A0D4  22f9       ld A,($F9)
LA0D6:
  A0D6  e0d117     ld HL,($D1)
  A0D9  e8df       test A.7
  A0DB  88         jrs T,LA0E5
  A0DC  31ff       ld W,$FF
  A0DE  eb31       add WA,HL
  A0E0  8b         jrs T,LA0ED
  A0E1  140000     ld WA,$0000
  A0E4  87         jrs T,LA0ED
LA0E5:
  A0E5  3100       ld W,$00
LA0E7:
  A0E7  eb31       add WA,HL
  A0E9  a2         jrs F,LA0ED
  A0EA  14ffff     ld WA,$FFFF
LA0ED:
  A0ED  f0d110     ld ($D1),WA
  A0F0  12         inc DE
  A0F1  2282       ld A,($82)
  A0F3  01         swap A
  A0F4  3100       ld W,$00
  A0F6  ea31       add WA,DE
  A0F8  e817       ld HL,WA
  A0FA  e35a       ld C,(HL)
  A0FC  1776d1     ld HL,$D176
  A0FF  e558       ld A,(HL+C)
  A101  d021       jr Z,LA124
  A103  46fb       set ($FB).6
  A105  d71f       jr F,LA126
  A107  e0b57703   cmp ($B5),$03
  A10B  d519       jr GT,LA126
  A10D  e0fd5a     ld C,($FD)
  A110  3300       ld B,$00
  A112  ea1c       shlc C
  A114  eb1e       rolc B
  A116  1476d2     ld WA,$D276
  A119  e931       add WA,BC
  A11B  e817       ld HL,WA
  A11D  e314       ld WA,(HL)
  A11F  e0d317     ld HL,($D3)
  A122  fb13       jr LA137
LA124:
  A124  22f9       ld A,($F9)
LA126:
  A126  e0d317     ld HL,($D3)
  A129  e8df       test A.7
  A12B  88         jrs T,LA135
  A12C  31ff       ld W,$FF
  A12E  eb31       add WA,HL
  A130  8b         jrs T,LA13D
  A131  140000     ld WA,$0000
  A134  87         jrs T,LA13D
LA135:
  A135  3100       ld W,$00
LA137:
  A137  eb31       add WA,HL
  A139  a2         jrs F,LA13D
  A13A  14ffff     ld WA,$FFFF
LA13D:
  A13D  f0d310     ld ($D3),WA
  A140  12         inc DE
  A141  2282       ld A,($82)
  A143  01         swap A
  A144  3100       ld W,$00
  A146  ea31       add WA,DE
  A148  e817       ld HL,WA
  A14A  e35a       ld C,(HL)
  A14C  1776d1     ld HL,$D176
  A14F  e558       ld A,(HL+C)
  A151  d021       jr Z,LA174
  A153  47fb       set ($FB).7
  A155  d71f       jr F,LA176
  A157  e0b67703   cmp ($B6),$03
  A15B  d519       jr GT,LA176
  A15D  e0fd5a     ld C,($FD)
  A160  3300       ld B,$00
  A162  ea1c       shlc C
  A164  eb1e       rolc B
  A166  1476d2     ld WA,$D276
  A169  e931       add WA,BC
  A16B  e817       ld HL,WA
  A16D  e314       ld WA,(HL)
  A16F  e0d517     ld HL,($D5)
  A172  fb13       jr LA187
LA174:
  A174  22f9       ld A,($F9)
LA176:
  A176  e0d517     ld HL,($D5)
  A179  e8df       test A.7
  A17B  88         jrs T,LA185
  A17C  31ff       ld W,$FF
  A17E  eb31       add WA,HL
  A180  8b         jrs T,LA18D
  A181  140000     ld WA,$0000
  A184  87         jrs T,LA18D
LA185:
  A185  3100       ld W,$00
LA187:
  A187  eb31       add WA,HL
  A189  a2         jrs F,LA18D
  A18A  14ffff     ld WA,$FFFF
LA18D:
  A18D  f0d510     ld ($D5),WA
  A190  2082       inc ($82)
  A192  e0827708   cmp ($82),$08
  A196  d303       jr CC,LA19B
  A198  fe2998     jp L9829
LA19B:
  A19B  4170       set ($70).1
LA19D:
  A19D  28f8       dec ($F8)
  A19F  d003       jr Z,LA1A4
  A1A1  fe9da2     jp LA29D
LA1A4:
  A1A4  2cf814     ld ($F8),$14
  A1A7  2ea7       clr ($A7)
  A1A9  2ea8       clr ($A8)
  A1AB  2ea9       clr ($A9)
  A1AD  2eaa       clr ($AA)
  A1AF  2eab       clr ($AB)
  A1B1  2eac       clr ($AC)
  A1B3  2ead       clr ($AD)
  A1B5  2eae       clr ($AE)
  A1B7  2eaf       clr ($AF)
  A1B9  2eb0       clr ($B0)
  A1BB  2eb1       clr ($B1)
  A1BD  2eb2       clr ($B2)
  A1BF  2eb3       clr ($B3)
  A1C1  2eb4       clr ($B4)
  A1C3  2eb5       clr ($B5)
  A1C5  2eb6       clr ($B6)
  A1C7  1476d8     ld WA,$D876
  A1CA  e0fd5a     ld C,($FD)
  A1CD  3300       ld B,$00
  A1CF  ea1c       shlc C
  A1D1  eb1e       rolc B
  A1D3  e931       add WA,BC
  A1D5  e817       ld HL,WA
  A1D7  e315       ld BC,(HL)
  A1D9  e0b714     ld WA,($B7)
  A1DC  e933       sub WA,BC
  A1DE  a2         jrs F,LA1E2
  A1DF  140000     ld WA,$0000
LA1E2:
  A1E2  f0b710     ld ($B7),WA
  A1E5  e0b914     ld WA,($B9)
  A1E8  e933       sub WA,BC
  A1EA  a2         jrs F,LA1EE
  A1EB  140000     ld WA,$0000
LA1EE:
  A1EE  f0b910     ld ($B9),WA
  A1F1  e0bb14     ld WA,($BB)
  A1F4  e933       sub WA,BC
  A1F6  a2         jrs F,LA1FA
  A1F7  140000     ld WA,$0000
LA1FA:
  A1FA  f0bb10     ld ($BB),WA
  A1FD  e0bd14     ld WA,($BD)
  A200  e933       sub WA,BC
  A202  a2         jrs F,LA206
  A203  140000     ld WA,$0000
LA206:
  A206  f0bd10     ld ($BD),WA
  A209  e0bf14     ld WA,($BF)
  A20C  e933       sub WA,BC
  A20E  a2         jrs F,LA212
  A20F  140000     ld WA,$0000
LA212:
  A212  f0bf10     ld ($BF),WA
  A215  e0c114     ld WA,($C1)
  A218  e933       sub WA,BC
  A21A  a2         jrs F,LA21E
  A21B  140000     ld WA,$0000
LA21E:
  A21E  f0c110     ld ($C1),WA
  A221  e0c314     ld WA,($C3)
  A224  e933       sub WA,BC
  A226  a2         jrs F,LA22A
  A227  140000     ld WA,$0000
LA22A:
  A22A  f0c310     ld ($C3),WA
  A22D  e0c514     ld WA,($C5)
  A230  e933       sub WA,BC
  A232  a2         jrs F,LA236
  A233  140000     ld WA,$0000
LA236:
  A236  f0c510     ld ($C5),WA
  A239  e0c714     ld WA,($C7)
  A23C  e933       sub WA,BC
  A23E  a2         jrs F,LA242
  A23F  140000     ld WA,$0000
LA242:
  A242  f0c710     ld ($C7),WA
  A245  e0c914     ld WA,($C9)
  A248  e933       sub WA,BC
  A24A  a2         jrs F,LA24E
  A24B  140000     ld WA,$0000
LA24E:
  A24E  f0c910     ld ($C9),WA
  A251  e0cb14     ld WA,($CB)
  A254  e933       sub WA,BC
  A256  a2         jrs F,LA25A
  A257  140000     ld WA,$0000
LA25A:
  A25A  f0cb10     ld ($CB),WA
  A25D  e0cd14     ld WA,($CD)
  A260  e933       sub WA,BC
  A262  a2         jrs F,LA266
  A263  140000     ld WA,$0000
LA266:
  A266  f0cd10     ld ($CD),WA
  A269  e0cf14     ld WA,($CF)
  A26C  e933       sub WA,BC
  A26E  a2         jrs F,LA272
  A26F  140000     ld WA,$0000
LA272:
  A272  f0cf10     ld ($CF),WA
  A275  e0d114     ld WA,($D1)
  A278  e933       sub WA,BC
  A27A  a2         jrs F,LA27E
  A27B  140000     ld WA,$0000
LA27E:
  A27E  f0d110     ld ($D1),WA
  A281  e0d314     ld WA,($D3)
  A284  e933       sub WA,BC
  A286  a2         jrs F,LA28A
  A287  140000     ld WA,$0000
LA28A:
  A28A  f0d310     ld ($D3),WA
  A28D  e0d514     ld WA,($D5)
  A290  e933       sub WA,BC
  A292  a2         jrs F,LA296
  A293  140000     ld WA,$0000
LA296:
  A296  f0d510     ld ($D5),WA
  A299  24fa0000   ldw ($FA),$0000
LA29D:
  A29D  de70       test ($70).6
  A29F  d648       jr T,LA2E9
  A2A1  e08314     ld WA,($83)
  A2A4  e08517     ld HL,($85)
  A2A7  eb37       cmp WA,HL
  A2A9  d340       jr CC,LA2EB
  A2AB  e07414     ld WA,($74)
  A2AE  e07617     ld HL,($76)
  A2B1  eb37       cmp WA,HL
  A2B3  d615       jr T,LA2CA
  A2B5  d30b       jr CC,LA2C2
  A2B7  eb10       xch WA,HL
  A2B9  eb33       sub WA,HL
  A2BB  e83f4000   cmp WA,$0040
  A2BF  d228       jr CS,LA2E9
  A2C1  87         jrs T,LA2CA
LA2C2:
  A2C2  eb33       sub WA,HL
  A2C4  e83f0001   cmp WA,$0100
  A2C8  d31f       jr CC,LA2E9
LA2CA:
  A2CA  e07417     ld HL,($74)
  A2CD  e08315     ld BC,($83)
  A2D0  341f       ld E,$1F
LA2D2:
  A2D2  fc8fa4     call SA48F
  A2D5  f650       ld (HL+),A
  A2D7  11         inc BC
  A2D8  6c         dec E
  A2D9  b7         jrs F,LA2D2
  A2DA  f08311     ld ($83),BC
  A2DD  eb3f4002   cmp HL,$0240
  A2E1  d203       jr CS,LA2E6
  A2E3  170001     ld HL,$0100
LA2E6:
  A2E6  f07413     ld ($74),HL
LA2E9:
  A2E9  fb02       jr LA2ED
LA2EB:
  A2EB  4e70       clr ($70).6
LA2ED:
  A2ED  d9e0       test ($E0).1
  A2EF  d736       jr F,LA327
  A2F1  48e0       clr ($E0).0
  A2F3  a2         jrs F,LA2F7
  A2F4  fed580     jp L80D5
LA2F7:
  A2F7  d871       test ($71).0
  A2F9  82         jrs T,LA2FD
  A2FA  fed580     jp L80D5
LA2FD:
  A2FD  ded9       test ($D9).6
  A2FF  e0dacb     ld ($DA).3,CF
  A302  41e0       set ($E0).1
  A304  42e0       set ($E0).2
  A306  ad         jrs F,LA315
  A307  24e20000   ldw ($E2),$0000
  A30B  24850000   ldw ($85),$0000
  A30F  24e40000   ldw ($E4),$0000
  A313  4be0       clr ($E0).3
LA315:
  A315  e0e217     ld HL,($E2)
  A318  f0ea13     ld ($EA),HL
  A31B  e08517     ld HL,($85)
  A31E  f0ec13     ld ($EC),HL
  A321  e0e417     ld HL,($E4)
  A324  f0ee13     ld ($EE),HL
LA327:
  A327  2c354e     ld ($35),$4E
  A32A  dfda       test ($DA).7
  A32C  d754       jr F,LA382
  A32E  fcc0a4     call SA4C0
  A331  d37a       jr CC,LA3AD
  A333  dfd9       test ($D9).7
  A335  82         jrs T,LA339
  A336  fed580     jp L80D5
LA339:
  A339  fcc0a4     call SA4C0
  A33C  d36f       jr CC,LA3AD
  A33E  e0e414     ld WA,($E4)
  A341  e83f0000   cmp WA,$0000
  A345  d654       jr T,LA39B
  A347  dbda       test ($DA).3
  A349  d650       jr T,LA39B
LA34B:
  A34B  2c354e     ld ($35),$4E
  A34E  fc64a5     call SA564
  A351  3000       ld A,$00
  A353  fca4a4     call SA4A4
  A356  e0e414     ld WA,($E4)
  A359  e83f8002   cmp WA,$0280
  A35D  d2ec       jr CS,LA34B
  A35F  4be0       clr ($E0).3
  A361  24e40000   ldw ($E4),$0000
  A365  e0e214     ld WA,($E2)
  A368  e8398002   add WA,$0280
  A36C  f0e210     ld ($E2),WA
  A36F  e83f8016   cmp WA,$1680
  A373  d226       jr CS,LA39B
  A375  24858016   ldw ($85),$1680
  A379  4071       set ($71).0
  A37B  49e0       clr ($E0).1
  A37D  48e0       clr ($E0).0
  A37F  fed580     jp L80D5
LA382:
  A382  e0ea17     ld HL,($EA)
  A385  f0e213     ld ($E2),HL
  A388  e0ec17     ld HL,($EC)
  A38B  f08513     ld ($85),HL
  A38E  e0ee17     ld HL,($EE)
  A391  f0e413     ld ($E4),HL
  A394  4be0       clr ($E0).3
  A396  49e0       clr ($E0).1
  A398  fed580     jp L80D5
LA39B:
  A39B  447c       set ($7C).4
  A39D  e0e214     ld WA,($E2)
  A3A0  e0e417     ld HL,($E4)
  A3A3  eb31       add WA,HL
  A3A5  f08510     ld ($85),WA
  A3A8  49e0       clr ($E0).1
  A3AA  fed580     jp L80D5
LA3AD:
  A3AD  e807       push WA
  A3AF  e0e414     ld WA,($E4)
  A3B2  e83f0000   cmp WA,$0000
  A3B6  d712       jr F,LA3CA
  A3B8  e0e217     ld HL,($E2)
  A3BB  f0ea13     ld ($EA),HL
  A3BE  e08517     ld HL,($85)
  A3C1  f0ec13     ld ($EC),HL
  A3C4  e0e417     ld HL,($E4)
  A3C7  f0ee13     ld ($EE),HL
LA3CA:
  A3CA  e806       pop WA
  A3CC  fc64a5     call SA564
  A3CF  fca4a4     call SA4A4
  A3D2  e0e414     ld WA,($E4)
  A3D5  e83f8002   cmp WA,$0280
  A3D9  d303       jr CC,LA3DE
  A3DB  fe27a3     jp LA327
LA3DE:
  A3DE  4be0       clr ($E0).3
  A3E0  ded9       test ($D9).6
  A3E2  e0dacb     ld ($DA).3,CF
  A3E5  24e40000   ldw ($E4),$0000
  A3E9  e0e214     ld WA,($E2)
  A3EC  e8398002   add WA,$0280
  A3F0  f0e210     ld ($E2),WA
  A3F3  e83f8016   cmp WA,$1680
  A3F7  d303       jr CC,LA3FC
  A3F9  fe27a3     jp LA327
LA3FC:
  A3FC  24858016   ldw ($85),$1680
  A400  4071       set ($71).0
  A402  49e0       clr ($E0).1
  A404  48e0       clr ($E0).0
  A406  fed580     jp L80D5
SA409:
  A409  dde1       test ($E1).5
  A40B  d750       jr F,LA45D
  A40D  dfe1       test ($E1).7
  A40F  d74c       jr F,LA45D
  A411  2c0e00     ld ($0E),$00
  A414  460e       set ($0E).6
LA416:
  A416  df0e       test ($0E).7
  A418  9c         jrs T,LA416
  A419  e00f5a     ld C,($0F)
  A41C  f0fd52     ld ($FD),C
  A41F  ea7734     cmp C,$34
  A422  d405       jr LE,LA429
  A424  ea77d7     cmp C,$D7
  A427  d402       jr LE,LA42B
LA429:
  A429  417c       set ($7C).1
LA42B:
  A42B  d87c       test ($7C).0
  A42D  d72e       jr F,LA45D
  A42F  dde1       test ($E1).5
  A431  d72a       jr F,LA45D
  A433  dfe1       test ($E1).7
  A435  d726       jr F,LA45D
  A437  2c0e01     ld ($0E),$01
  A43A  460e       set ($0E).6
LA43C:
  A43C  df0e       test ($0E).7
  A43E  9c         jrs T,LA43C
  A43F  e00f777e   cmp ($0F),$7E
  A443  d518       jr GT,LA45D
  A445  24000000   ldw ($00),$0000
  A449  407c       set ($7C).0
  A44B  41d9       set ($D9).1
  A44D  e0737711   cmp ($73),$11
  A451  d208       jr CS,LA45B
  A453  4a70       clr ($70).2
  A455  2c7318     ld ($73),$18
  A458  2efe       clr ($FE)
  A45A  05         ret
LA45B:
  A45B  4205       set ($05).2
LA45D:
  A45D  05         ret
SA45E:
  A45E  2c0207     ld ($02),$07
  A461  2c0d00     ld ($0D),$00
  A464  170001     ld HL,$0100
  A467  339f       ld B,$9F
LA469:
  A469  f62c00     ld (HL+),$00
  A46C  f62c00     ld (HL+),$00
  A46F  6b         dec B
  A470  b7         jrs F,LA469
  A471  170001     ld HL,$0100
  A474  150000     ld BC,$0000
LA477:
  A477  fc8fa4     call SA48F
  A47A  f650       ld (HL+),A
  A47C  11         inc BC
  A47D  e93f2001   cmp BC,$0120
  A481  d2f4       jr CS,LA477
  A483  f08311     ld ($83),BC
  A486  24742002   ldw ($74),$0220
  A48A  24760001   ldw ($76),$0100
  A48E  05         ret
SA48F:
  A48F  f00352     ld ($03),C
  A492  53         ld A,B
  A493  76e0       or A,$E0
  A495  2a04       ld ($04),A
  A497  4a02       clr ($02).2
  A499  4c05       clr ($05).4
  A49B  00         nop
  A49C  00         nop
  A49D  2207       ld A,($07)
  A49F  4405       set ($05).4
  A4A1  4202       set ($02).2
  A4A3  05         ret
SA4A4:
  A4A4  2c0dff     ld ($0D),$FF
  A4A7  2a07       ld ($07),A
  A4A9  f00352     ld ($03),C
  A4AC  53         ld A,B
  A4AD  76e0       or A,$E0
  A4AF  2a04       ld ($04),A
  A4B1  00         nop
  A4B2  4a02       clr ($02).2
  A4B4  00         nop
  A4B5  4902       clr ($02).1
  A4B7  00         nop
  A4B8  4102       set ($02).1
  A4BA  4202       set ($02).2
  A4BC  2c0d00     ld ($0D),$00
  A4BF  05         ret
SA4C0:
  A4C0  dbda       test ($DA).3
  A4C2  d71b       jr F,LA4DF
  A4C4  e0dc14     ld WA,($DC)
  A4C7  e0de17     ld HL,($DE)
  A4CA  eb37       cmp WA,HL
  A4CC  a1         jrs F,LA4CF
  A4CD  0d         set CF
  A4CE  05         ret
LA4CF:
  A4CF  e658       ld A,(HL+)
  A4D1  eb3f1404   cmp HL,$0414
  A4D5  d203       jr CS,LA4DA
  A4D7  17f403     ld HL,$03F4
LA4DA:
  A4DA  f0de13     ld ($DE),HL
  A4DD  0c         clr CF
  A4DE  05         ret
LA4DF:
  A4DF  dbe0       test ($E0).3
  A4E1  d731       jr F,LA514
  A4E3  e0dc14     ld WA,($DC)
  A4E6  e0de17     ld HL,($DE)
  A4E9  eb37       cmp WA,HL
  A4EB  a1         jrs F,LA4EE
  A4EC  0d         set CF
  A4ED  05         ret
LA4EE:
  A4EE  43e0       set ($E0).3
  A4F0  4ce0       clr ($E0).4
  A4F2  4de0       clr ($E0).5
  A4F4  4ee0       clr ($E0).6
  A4F6  e658       ld A,(HL+)
  A4F8  eb3f1404   cmp HL,$0414
  A4FC  d203       jr CS,LA501
  A4FE  17f403     ld HL,$03F4
LA501:
  A501  f0de13     ld ($DE),HL
  A504  7780       cmp A,$80
  A506  d306       jr CC,LA50E
  A508  44e0       set ($E0).4
  A50A  60         inc A
  A50B  2ae7       ld ($E7),A
  A50D  85         jrs T,LA514
LA50E:
  A50E  45e0       set ($E0).5
  A510  737e       sub A,$7E
  A512  2ae7       ld ($E7),A
LA514:
  A514  dde0       test ($E0).5
  A516  d721       jr F,LA539
  A518  e0dc14     ld WA,($DC)
  A51B  e0de17     ld HL,($DE)
  A51E  eb37       cmp WA,HL
  A520  a1         jrs F,LA523
  A521  0d         set CF
  A522  05         ret
LA523:
  A523  e658       ld A,(HL+)
  A525  eb3f1404   cmp HL,$0414
  A529  d203       jr CS,LA52E
  A52B  17f403     ld HL,$03F4
LA52E:
  A52E  f0de13     ld ($DE),HL
  A531  28e7       dec ($E7)
  A533  d102       jr NZ,LA537
  A535  4be0       clr ($E0).3
LA537:
  A537  0c         clr CF
  A538  05         ret
LA539:
  A539  dee0       test ($E0).6
  A53B  d71d       jr F,LA55A
  A53D  e0dc14     ld WA,($DC)
  A540  e0de17     ld HL,($DE)
  A543  eb37       cmp WA,HL
  A545  a1         jrs F,LA548
  A546  0d         set CF
  A547  05         ret
LA548:
  A548  e658       ld A,(HL+)
  A54A  2ae6       ld ($E6),A
  A54C  46e0       set ($E0).6
  A54E  eb3f1404   cmp HL,$0414
  A552  d203       jr CS,LA557
  A554  17f403     ld HL,$03F4
LA557:
  A557  f0de13     ld ($DE),HL
LA55A:
  A55A  22e6       ld A,($E6)
  A55C  28e7       dec ($E7)
  A55E  d102       jr NZ,LA562
  A560  4be0       clr ($E0).3
LA562:
  A562  0c         clr CF
  A563  05         ret
SA564:
  A564  5a         ld C,A
  A565  e0e414     ld WA,($E4)
  A568  10         inc WA
  A569  f0e410     ld ($E4),WA
  A56C  e831       add WA,WA
  A56E  e8397ca5   add WA,$A57C
  A572  e817       ld HL,WA
  A574  e314       ld WA,(HL)
  A576  e0e217     ld HL,($E2)
  A579  eb31       add WA,HL
  A57B  e910       xch WA,BC
  A57D  05         ret
  A57E  db 00 00 01 00 02 00 03 00 04 00 05 00 06 00 07 00
  A58E  db 08 00 09 00 0A 00 0B 00 0C 00 0D 00 0E 00 0F 00
  A59E  db 20 00 21 00 22 00 23 00 24 00 25 00 26 00 27 00
  A5AE  db 28 00 29 00 2A 00 2B 00 2C 00 2D 00 2E 00 2F 00
  A5BE  db 40 00 41 00 42 00 43 00 44 00 45 00 46 00 47 00
  A5CE  db 48 00 49 00 4A 00 4B 00 4C 00 4D 00 4E 00 4F 00
  A5DE  db 60 00 61 00 62 00 63 00 64 00 65 00 66 00 67 00
  A5EE  db 68 00 69 00 6A 00 6B 00 6C 00 6D 00 6E 00 6F 00
  A5FE  db 80 00 81 00 82 00 83 00 84 00 85 00 86 00 87 00
  A60E  db 88 00 89 00 8A 00 8B 00 8C 00 8D 00 8E 00 8F 00
  A61E  db A0 00 A1 00 A2 00 A3 00 A4 00 A5 00 A6 00 A7 00
  A62E  db A8 00 A9 00 AA 00 AB 00 AC 00 AD 00 AE 00 AF 00
  A63E  db C0 00 C1 00 C2 00 C3 00 C4 00 C5 00 C6 00 C7 00
  A64E  db C8 00 C9 00 CA 00 CB 00 CC 00 CD 00 CE 00 CF 00
  A65E  db E0 00 E1 00 E2 00 E3 00 E4 00 E5 00 E6 00 E7 00
  A66E  db E8 00 E9 00 EA 00 EB 00 EC 00 ED 00 EE 00 EF 00
  A67E  db 00 01 01 01 02 01 03 01 04 01 05 01 06 01 07 01
  A68E  db 08 01 09 01 0A 01 0B 01 0C 01 0D 01 0E 01 0F 01
  A69E  db 20 01 21 01 22 01 23 01 24 01 25 01 26 01 27 01
  A6AE  db 28 01 29 01 2A 01 2B 01 2C 01 2D 01 2E 01 2F 01
  A6BE  db 40 01 41 01 42 01 43 01 44 01 45 01 46 01 47 01
  A6CE  db 48 01 49 01 4A 01 4B 01 4C 01 4D 01 4E 01 4F 01
  A6DE  db 60 01 61 01 62 01 63 01 64 01 65 01 66 01 67 01
  A6EE  db 68 01 69 01 6A 01 6B 01 6C 01 6D 01 6E 01 6F 01
  A6FE  db 80 01 81 01 82 01 83 01 84 01 85 01 86 01 87 01
  A70E  db 88 01 89 01 8A 01 8B 01 8C 01 8D 01 8E 01 8F 01
  A71E  db A0 01 A1 01 A2 01 A3 01 A4 01 A5 01 A6 01 A7 01
  A72E  db A8 01 A9 01 AA 01 AB 01 AC 01 AD 01 AE 01 AF 01
  A73E  db C0 01 C1 01 C2 01 C3 01 C4 01 C5 01 C6 01 C7 01
  A74E  db C8 01 C9 01 CA 01 CB 01 CC 01 CD 01 CE 01 CF 01
  A75E  db E0 01 E1 01 E2 01 E3 01 E4 01 E5 01 E6 01 E7 01
  A76E  db E8 01 E9 01 EA 01 EB 01 EC 01 ED 01 EE 01 EF 01
  A77E  db 00 02 01 02 02 02 03 02 04 02 05 02 06 02 07 02
  A78E  db 08 02 09 02 0A 02 0B 02 0C 02 0D 02 0E 02 0F 02
  A79E  db 20 02 21 02 22 02 23 02 24 02 25 02 26 02 27 02
  A7AE  db 28 02 29 02 2A 02 2B 02 2C 02 2D 02 2E 02 2F 02
  A7BE  db 40 02 41 02 42 02 43 02 44 02 45 02 46 02 47 02
  A7CE  db 48 02 49 02 4A 02 4B 02 4C 02 4D 02 4E 02 4F 02
  A7DE  db 60 02 61 02 62 02 63 02 64 02 65 02 66 02 67 02
  A7EE  db 68 02 69 02 6A 02 6B 02 6C 02 6D 02 6E 02 6F 02
  A7FE  db 10 00 11 00 12 00 13 00 14 00 15 00 16 00 17 00
  A80E  db 18 00 19 00 1A 00 1B 00 1C 00 1D 00 1E 00 1F 00
  A81E  db 30 00 31 00 32 00 33 00 34 00 35 00 36 00 37 00
  A82E  db 38 00 39 00 3A 00 3B 00 3C 00 3D 00 3E 00 3F 00
  A83E  db 50 00 51 00 52 00 53 00 54 00 55 00 56 00 57 00
  A84E  db 58 00 59 00 5A 00 5B 00 5C 00 5D 00 5E 00 5F 00
  A85E  db 70 00 71 00 72 00 73 00 74 00 75 00 76 00 77 00
  A86E  db 78 00 79 00 7A 00 7B 00 7C 00 7D 00 7E 00 7F 00
  A87E  db 90 00 91 00 92 00 93 00 94 00 95 00 96 00 97 00
  A88E  db 98 00 99 00 9A 00 9B 00 9C 00 9D 00 9E 00 9F 00
  A89E  db B0 00 B1 00 B2 00 B3 00 B4 00 B5 00 B6 00 B7 00
  A8AE  db B8 00 B9 00 BA 00 BB 00 BC 00 BD 00 BE 00 BF 00
  A8BE  db D0 00 D1 00 D2 00 D3 00 D4 00 D5 00 D6 00 D7 00
  A8CE  db D8 00 D9 00 DA 00 DB 00 DC 00 DD 00 DE 00 DF 00
  A8DE  db F0 00 F1 00 F2 00 F3 00 F4 00 F5 00 F6 00 F7 00
  A8EE  db F8 00 F9 00 FA 00 FB 00 FC 00 FD 00 FE 00 FF 00
  A8FE  db 10 01 11 01 12 01 13 01 14 01 15 01 16 01 17 01
  A90E  db 18 01 19 01 1A 01 1B 01 1C 01 1D 01 1E 01 1F 01
  A91E  db 30 01 31 01 32 01 33 01 34 01 35 01 36 01 37 01
  A92E  db 38 01 39 01 3A 01 3B 01 3C 01 3D 01 3E 01 3F 01
  A93E  db 50 01 51 01 52 01 53 01 54 01 55 01 56 01 57 01
  A94E  db 58 01 59 01 5A 01 5B 01 5C 01 5D 01 5E 01 5F 01
  A95E  db 70 01 71 01 72 01 73 01 74 01 75 01 76 01 77 01
  A96E  db 78 01 79 01 7A 01 7B 01 7C 01 7D 01 7E 01 7F 01
  A97E  db 90 01 91 01 92 01 93 01 94 01 95 01 96 01 97 01
  A98E  db 98 01 99 01 9A 01 9B 01 9C 01 9D 01 9E 01 9F 01
  A99E  db B0 01 B1 01 B2 01 B3 01 B4 01 B5 01 B6 01 B7 01
  A9AE  db B8 01 B9 01 BA 01 BB 01 BC 01 BD 01 BE 01 BF 01
  A9BE  db D0 01 D1 01 D2 01 D3 01 D4 01 D5 01 D6 01 D7 01
  A9CE  db D8 01 D9 01 DA 01 DB 01 DC 01 DD 01 DE 01 DF 01
  A9DE  db F0 01 F1 01 F2 01 F3 01 F4 01 F5 01 F6 01 F7 01
  A9EE  db F8 01 F9 01 FA 01 FB 01 FC 01 FD 01 FE 01 FF 01
  A9FE  db 10 02 11 02 12 02 13 02 14 02 15 02 16 02 17 02
  AA0E  db 18 02 19 02 1A 02 1B 02 1C 02 1D 02 1E 02 1F 02
  AA1E  db 30 02 31 02 32 02 33 02 34 02 35 02 36 02 37 02
  AA2E  db 38 02 39 02 3A 02 3B 02 3C 02 3D 02 3E 02 3F 02
  AA3E  db 50 02 51 02 52 02 53 02 54 02 55 02 56 02 57 02
  AA4E  db 58 02 59 02 5A 02 5B 02 5C 02 5D 02 5E 02 5F 02
  AA5E  db 70 02 71 02 72 02 73 02 74 02 75 02 76 02 77 02
  AA6E  db 78 02 79 02 7A 02 7B 02 7C 02 7D 02 7E 02 7F 02
V_FFF6:
  AA7E  0f01       ld RBS,1
  AA80  63         inc B
  AA81  8b         jrs T,LAA8E
  AA82  140000     ld WA,$0000
  AA85  e6a8       xch A,(HL+)
  AA87  e2a9       xch W,(DE)
  AA89  f00010     ld ($00),WA
  AA8C  12         inc DE
  AA8D  04         reti
LAA8E:
  AA8E  2c1408     ld ($14),$08
  AA91  24000000   ldw ($00),$0000
  AA95  dfe1       test ($E1).7
  AA97  a0         jrs F,LAA99
  AA98  04         reti
LAA99:
  AA99  4fe1       clr ($E1).7
  AA9B  2c0e01     ld ($0E),$01
  AA9E  460e       set ($0E).6
LAAA0:
  AAA0  df0e       test ($0E).7
  AAA2  9c         jrs T,LAAA0
  AAA3  220f       ld A,($0F)
  AAA5  779c       cmp A,$9C
  AAA7  d516       jr GT,LAABF
  AAA9  777e       cmp A,$7E
  AAAB  d40c       jr LE,LAAB9
  AAAD  171b04     ld HL,$041B
  AAB0  e359       ld W,(HL)
  AAB2  e96b       sub W,A
  AAB4  e97708     cmp W,$08
  AAB7  d206       jr CS,LAABF
LAAB9:
  AAB9  4205       set ($05).2
  AABB  407c       set ($7C).0
  AABD  4b05       clr ($05).3
LAABF:
  AABF  04         reti
V_FFEE:
  AAC0  243a0120   ldw ($3A),$2001
  AAC4  2c1a08     ld ($1A),$08
  AAC7  2c0e01     ld ($0E),$01
  AACA  460e       set ($0E).6
LAACC:
  AACC  df0e       test ($0E).7
  AACE  9c         jrs T,LAACC
  AACF  e00f777e   cmp ($0F),$7E
  AAD3  d508       jr GT,LAADD
  AAD5  24000000   ldw ($00),$0000
  AAD9  407c       set ($7C).0
  AADB  41d9       set ($D9).1
LAADD:
  AADD  4de1       clr ($E1).5
  AADF  483a       di
  AAE1  243a10fd   ldw ($3A),$FD10
  AAE5  04         reti
V_FFE0:
  AAE6  04         reti
V_FFE6:
  AAE7  d905       test ($05).1
  AAE9  81         jrs T,LAAEC
  AAEA  4270       set ($70).2
LAAEC:
  AAEC  04         reti
V_FFE8:
  AAED  0f02       ld RBS,2
  AAEF  d805       test ($05).0
  AAF1  80         jrs T,LAAF3
  AAF2  04         reti
LAAF3:
  AAF3  e07b7120   add ($7B),$20
  AAF7  a1         jrs F,LAAFA
  AAF8  4371       set ($71).3
LAAFA:
  AAFA  4570       set ($70).5
  AAFC  2273       ld A,($73)
  AAFE  d062       jr Z,LAB62
  AB00  7710       cmp A,$10
  AB02  d416       jr LE,LAB1A
  AB04  dbe1       test ($E1).3
  AB06  d65a       jr T,LAB62
  AB08  7718       cmp A,$18
  AB0A  d656       jr T,LAB62
  AB0C  4a70       clr ($70).2
  AB0E  2efe       clr ($FE)
  AB10  2c7318     ld ($73),$18
  AB13  483a       di
  AB15  243a10fd   ldw ($3A),$FD10
  AB19  04         reti
LAB1A:
  AB1A  0f01       ld RBS,1
  AB1C  33df       ld B,$DF
  AB1E  e070c4     cpl ($70).4
  AB21  a6         jrs F,LAB29
  AB22  176003     ld HL,$0360
  AB25  168303     ld DE,$0383
  AB28  85         jrs T,LAB2F
LAB29:
  AB29  17a603     ld HL,$03A6
  AB2C  16c903     ld DE,$03C9
LAB2F:
  AB2F  140000     ld WA,$0000
  AB32  e6a8       xch A,(HL+)
  AB34  e2a9       xch W,(DE)
  AB36  f00010     ld ($00),WA
  AB39  12         inc DE
  AB3A  0f02       ld RBS,2
  AB3C  161904     ld DE,$0419
  AB3F  e217       ld HL,(DE)
  AB41  e0725a     ld C,($72)
  AB44  6a         dec C
  AB45  e558       ld A,(HL+C)
  AB47  171e04     ld HL,$041E
  AB4A  e35a       ld C,(HL)
  AB4C  175cdd     ld HL,$DD5C
  AB4F  e57b       sub A,(HL+C)
  AB51  3100       ld W,$00
  AB53  f01010     ld ($10),WA
  AB56  2c1418     ld ($14),$18
  AB59  243a1120   ldw ($3A),$2011
  AB5D  2c1a18     ld ($1A),$18
  AB60  2273       ld A,($73)
LAB62:
  AB62  1c         shlc A
  AB63  e1fe       jp (PC+A)
  AB65  dw JABA3
  AB67  dw JABAE
  AB69  dw JAC06
  AB6B  dw JAC43
  AB6D  dw JAC80
  AB6F  dw JACBD
  AB71  dw JACFA
  AB73  dw JAD37
  AB75  dw JAD76
  AB77  dw JADB3
  AB79  dw JADF0
  AB7B  dw JAE2D
  AB7D  dw JAE6A
  AB7F  dw JAEA7
  AB81  dw JAEE4
  AB83  dw JAF21
  AB85  dw JAF60
  AB87  dw JB05F
  AB89  dw JB0FB
  AB8B  dw JB10D
  AB8D  dw JB121
  AB8F  dw JB181
  AB91  dw JB22C
  AB93  dw JB2A6
  AB95  dw JB328
  AB97  dw JB369
  AB99  dw JB369
  AB9B  dw JB369
  AB9D  dw JB369
  AB9F  dw JB369
  ABA1  dw JB369
JABA3:
  ABA3  df71       test ($71).7
  ABA5  86         jrs T,LABAD
  ABA6  171804     ld HL,$0418
  ABA9  21         inc (HL)
  ABAA  a1         jrs F,LABAD
  ABAB  4b05       clr ($05).3
LABAD:
  ABAD  04         reti
JABAE:
  ABAE  22fc       ld A,($FC)
  ABB0  1c         shlc A
  ABB1  3100       ld W,$00
  ABB3  dada       test ($DA).2
  ABB5  85         jrs T,LABBC
  ABB6  e83969dc   add WA,$DC69
  ABBA  fb04       jr LABC0
LABBC:
  ABBC  e83976db   add WA,$DB76
LABC0:
  ABC0  e817       ld HL,WA
  ABC2  e316       ld DE,(HL)
  ABC4  171904     ld HL,$0419
  ABC7  f312       ld (HL),DE
  ABC9  167002     ld DE,$0270
  ABCC  fcaec4     call SC4AE
  ABCF  fc0dc5     call SC50D
  ABD2  fc6cc5     call SC56C
  ABD5  fccbc5     call SC5CB
  ABD8  fc2ac6     call SC62A
  ABDB  fc89c6     call SC689
  ABDE  fce8c6     call SC6E8
  ABE1  fc47c7     call SC747
  ABE4  fca6c7     call SC7A6
  ABE7  fc05c8     call SC805
  ABEA  fc64c8     call SC864
  ABED  fcc3c8     call SC8C3
  ABF0  fc22c9     call SC922
  ABF3  fc81c9     call SC981
  ABF6  fce0c9     call SC9E0
  ABF9  fc3fca     call SCA3F
  ABFC  2c7302     ld ($73),$02
  ABFF  483a       di
  AC01  243a10fd   ldw ($3A),$FD10
  AC05  04         reti
JAC06:
  AC06  168002     ld DE,$0280
  AC09  fcbebe     call SBEBE
  AC0C  fc1dbf     call SBF1D
  AC0F  fc7cbf     call SBF7C
  AC12  fcdbbf     call SBFDB
  AC15  fc3ac0     call SC03A
  AC18  fc99c0     call SC099
  AC1B  fcf8c0     call SC0F8
  AC1E  fc57c1     call SC157
  AC21  fcb6c1     call SC1B6
  AC24  fc15c2     call SC215
  AC27  fc74c2     call SC274
  AC2A  fcd3c2     call SC2D3
  AC2D  fc32c3     call SC332
  AC30  fc91c3     call SC391
  AC33  fcf0c3     call SC3F0
  AC36  fc4fc4     call SC44F
  AC39  2c7303     ld ($73),$03
  AC3C  483a       di
  AC3E  243a10fd   ldw ($3A),$FD10
  AC42  04         reti
JAC43:
  AC43  169002     ld DE,$0290
  AC46  fcaec4     call SC4AE
  AC49  fc0dc5     call SC50D
  AC4C  fc6cc5     call SC56C
  AC4F  fccbc5     call SC5CB
  AC52  fc2ac6     call SC62A
  AC55  fc89c6     call SC689
  AC58  fce8c6     call SC6E8
  AC5B  fc47c7     call SC747
  AC5E  fca6c7     call SC7A6
  AC61  fc05c8     call SC805
  AC64  fc64c8     call SC864
  AC67  fcc3c8     call SC8C3
  AC6A  fc22c9     call SC922
  AC6D  fc81c9     call SC981
  AC70  fce0c9     call SC9E0
  AC73  fc3fca     call SCA3F
  AC76  2c7304     ld ($73),$04
  AC79  483a       di
  AC7B  243a10fd   ldw ($3A),$FD10
  AC7F  04         reti
JAC80:
  AC80  16a002     ld DE,$02A0
  AC83  fcbebe     call SBEBE
  AC86  fc1dbf     call SBF1D
  AC89  fc7cbf     call SBF7C
  AC8C  fcdbbf     call SBFDB
  AC8F  fc3ac0     call SC03A
  AC92  fc99c0     call SC099
  AC95  fcf8c0     call SC0F8
  AC98  fc57c1     call SC157
  AC9B  fcb6c1     call SC1B6
  AC9E  fc15c2     call SC215
  ACA1  fc74c2     call SC274
  ACA4  fcd3c2     call SC2D3
  ACA7  fc32c3     call SC332
  ACAA  fc91c3     call SC391
  ACAD  fcf0c3     call SC3F0
  ACB0  fc4fc4     call SC44F
  ACB3  2c7305     ld ($73),$05
  ACB6  483a       di
  ACB8  243a10fd   ldw ($3A),$FD10
  ACBC  04         reti
JACBD:
  ACBD  16b002     ld DE,$02B0
  ACC0  fcaec4     call SC4AE
  ACC3  fc0dc5     call SC50D
  ACC6  fc6cc5     call SC56C
  ACC9  fccbc5     call SC5CB
  ACCC  fc2ac6     call SC62A
  ACCF  fc89c6     call SC689
  ACD2  fce8c6     call SC6E8
  ACD5  fc47c7     call SC747
  ACD8  fca6c7     call SC7A6
  ACDB  fc05c8     call SC805
  ACDE  fc64c8     call SC864
  ACE1  fcc3c8     call SC8C3
  ACE4  fc22c9     call SC922
  ACE7  fc81c9     call SC981
  ACEA  fce0c9     call SC9E0
  ACED  fc3fca     call SCA3F
  ACF0  2c7306     ld ($73),$06
  ACF3  483a       di
  ACF5  243a10fd   ldw ($3A),$FD10
  ACF9  04         reti
JACFA:
  ACFA  16c002     ld DE,$02C0
  ACFD  fcbebe     call SBEBE
  AD00  fc1dbf     call SBF1D
  AD03  fc7cbf     call SBF7C
  AD06  fcdbbf     call SBFDB
  AD09  fc3ac0     call SC03A
  AD0C  fc99c0     call SC099
  AD0F  fcf8c0     call SC0F8
  AD12  fc57c1     call SC157
  AD15  fcb6c1     call SC1B6
  AD18  fc15c2     call SC215
  AD1B  fc74c2     call SC274
  AD1E  fcd3c2     call SC2D3
  AD21  fc32c3     call SC332
  AD24  fc91c3     call SC391
  AD27  fcf0c3     call SC3F0
  AD2A  fc4fc4     call SC44F
  AD2D  2c7307     ld ($73),$07
  AD30  483a       di
  AD32  243a10fd   ldw ($3A),$FD10
  AD36  04         reti
JAD37:
  AD37  16d002     ld DE,$02D0
  AD3A  fcaec4     call SC4AE
  AD3D  fc0dc5     call SC50D
  AD40  fc6cc5     call SC56C
  AD43  fccbc5     call SC5CB
  AD46  fc2ac6     call SC62A
  AD49  fc89c6     call SC689
  AD4C  fce8c6     call SC6E8
  AD4F  fc47c7     call SC747
  AD52  fca6c7     call SC7A6
  AD55  fc05c8     call SC805
  AD58  fc64c8     call SC864
  AD5B  fcc3c8     call SC8C3
  AD5E  fc22c9     call SC922
  AD61  fc81c9     call SC981
  AD64  fce0c9     call SC9E0
  AD67  fc3fca     call SCA3F
  AD6A  4870       clr ($70).0
  AD6C  2c7308     ld ($73),$08
  AD6F  483a       di
  AD71  243a10fd   ldw ($3A),$FD10
  AD75  04         reti
JAD76:
  AD76  16e002     ld DE,$02E0
  AD79  fcbebe     call SBEBE
  AD7C  fc1dbf     call SBF1D
  AD7F  fc7cbf     call SBF7C
  AD82  fcdbbf     call SBFDB
  AD85  fc3ac0     call SC03A
  AD88  fc99c0     call SC099
  AD8B  fcf8c0     call SC0F8
  AD8E  fc57c1     call SC157
  AD91  fcb6c1     call SC1B6
  AD94  fc15c2     call SC215
  AD97  fc74c2     call SC274
  AD9A  fcd3c2     call SC2D3
  AD9D  fc32c3     call SC332
  ADA0  fc91c3     call SC391
  ADA3  fcf0c3     call SC3F0
  ADA6  fc4fc4     call SC44F
  ADA9  2c7309     ld ($73),$09
  ADAC  483a       di
  ADAE  243a10fd   ldw ($3A),$FD10
  ADB2  04         reti
JADB3:
  ADB3  16f002     ld DE,$02F0
  ADB6  fcaec4     call SC4AE
  ADB9  fc0dc5     call SC50D
  ADBC  fc6cc5     call SC56C
  ADBF  fccbc5     call SC5CB
  ADC2  fc2ac6     call SC62A
  ADC5  fc89c6     call SC689
  ADC8  fce8c6     call SC6E8
  ADCB  fc47c7     call SC747
  ADCE  fca6c7     call SC7A6
  ADD1  fc05c8     call SC805
  ADD4  fc64c8     call SC864
  ADD7  fcc3c8     call SC8C3
  ADDA  fc22c9     call SC922
  ADDD  fc81c9     call SC981
  ADE0  fce0c9     call SC9E0
  ADE3  fc3fca     call SCA3F
  ADE6  2c730a     ld ($73),$0A
  ADE9  483a       di
  ADEB  243a10fd   ldw ($3A),$FD10
  ADEF  04         reti
JADF0:
  ADF0  160003     ld DE,$0300
  ADF3  fcbebe     call SBEBE
  ADF6  fc1dbf     call SBF1D
  ADF9  fc7cbf     call SBF7C
  ADFC  fcdbbf     call SBFDB
  ADFF  fc3ac0     call SC03A
  AE02  fc99c0     call SC099
  AE05  fcf8c0     call SC0F8
  AE08  fc57c1     call SC157
  AE0B  fcb6c1     call SC1B6
  AE0E  fc15c2     call SC215
  AE11  fc74c2     call SC274
  AE14  fcd3c2     call SC2D3
  AE17  fc32c3     call SC332
  AE1A  fc91c3     call SC391
  AE1D  fcf0c3     call SC3F0
  AE20  fc4fc4     call SC44F
  AE23  2c730b     ld ($73),$0B
  AE26  483a       di
  AE28  243a10fd   ldw ($3A),$FD10
  AE2C  04         reti
JAE2D:
  AE2D  161003     ld DE,$0310
  AE30  fcaec4     call SC4AE
  AE33  fc0dc5     call SC50D
  AE36  fc6cc5     call SC56C
  AE39  fccbc5     call SC5CB
  AE3C  fc2ac6     call SC62A
  AE3F  fc89c6     call SC689
  AE42  fce8c6     call SC6E8
  AE45  fc47c7     call SC747
  AE48  fca6c7     call SC7A6
  AE4B  fc05c8     call SC805
  AE4E  fc64c8     call SC864
  AE51  fcc3c8     call SC8C3
  AE54  fc22c9     call SC922
  AE57  fc81c9     call SC981
  AE5A  fce0c9     call SC9E0
  AE5D  fc3fca     call SCA3F
  AE60  2c730c     ld ($73),$0C
  AE63  483a       di
  AE65  243a10fd   ldw ($3A),$FD10
  AE69  04         reti
JAE6A:
  AE6A  162003     ld DE,$0320
  AE6D  fcbebe     call SBEBE
  AE70  fc1dbf     call SBF1D
  AE73  fc7cbf     call SBF7C
  AE76  fcdbbf     call SBFDB
  AE79  fc3ac0     call SC03A
  AE7C  fc99c0     call SC099
  AE7F  fcf8c0     call SC0F8
  AE82  fc57c1     call SC157
  AE85  fcb6c1     call SC1B6
  AE88  fc15c2     call SC215
  AE8B  fc74c2     call SC274
  AE8E  fcd3c2     call SC2D3
  AE91  fc32c3     call SC332
  AE94  fc91c3     call SC391
  AE97  fcf0c3     call SC3F0
  AE9A  fc4fc4     call SC44F
  AE9D  2c730d     ld ($73),$0D
  AEA0  483a       di
  AEA2  243a10fd   ldw ($3A),$FD10
  AEA6  04         reti
JAEA7:
  AEA7  163003     ld DE,$0330
  AEAA  fcaec4     call SC4AE
  AEAD  fc0dc5     call SC50D
  AEB0  fc6cc5     call SC56C
  AEB3  fccbc5     call SC5CB
  AEB6  fc2ac6     call SC62A
  AEB9  fc89c6     call SC689
  AEBC  fce8c6     call SC6E8
  AEBF  fc47c7     call SC747
  AEC2  fca6c7     call SC7A6
  AEC5  fc05c8     call SC805
  AEC8  fc64c8     call SC864
  AECB  fcc3c8     call SC8C3
  AECE  fc22c9     call SC922
  AED1  fc81c9     call SC981
  AED4  fce0c9     call SC9E0
  AED7  fc3fca     call SCA3F
  AEDA  2c730e     ld ($73),$0E
  AEDD  483a       di
  AEDF  243a10fd   ldw ($3A),$FD10
  AEE3  04         reti
JAEE4:
  AEE4  164003     ld DE,$0340
  AEE7  fcbebe     call SBEBE
  AEEA  fc1dbf     call SBF1D
  AEED  fc7cbf     call SBF7C
  AEF0  fcdbbf     call SBFDB
  AEF3  fc3ac0     call SC03A
  AEF6  fc99c0     call SC099
  AEF9  fcf8c0     call SC0F8
  AEFC  fc57c1     call SC157
  AEFF  fcb6c1     call SC1B6
  AF02  fc15c2     call SC215
  AF05  fc74c2     call SC274
  AF08  fcd3c2     call SC2D3
  AF0B  fc32c3     call SC332
  AF0E  fc91c3     call SC391
  AF11  fcf0c3     call SC3F0
  AF14  fc4fc4     call SC44F
  AF17  2c730f     ld ($73),$0F
  AF1A  483a       di
  AF1C  243a10fd   ldw ($3A),$FD10
  AF20  04         reti
JAF21:
  AF21  165003     ld DE,$0350
  AF24  fcaec4     call SC4AE
  AF27  fc0dc5     call SC50D
  AF2A  fc6cc5     call SC56C
  AF2D  fccbc5     call SC5CB
  AF30  fc2ac6     call SC62A
  AF33  fc89c6     call SC689
  AF36  fce8c6     call SC6E8
  AF39  fc47c7     call SC747
  AF3C  fca6c7     call SC7A6
  AF3F  fc05c8     call SC805
  AF42  fc64c8     call SC864
  AF45  fcc3c8     call SC8C3
  AF48  fc22c9     call SC922
  AF4B  fc81c9     call SC981
  AF4E  fce0c9     call SC9E0
  AF51  fc3fca     call SCA3F
  AF54  4970       clr ($70).1
  AF56  2c7310     ld ($73),$10
  AF59  483a       di
  AF5B  243a10fd   ldw ($3A),$FD10
  AF5F  04         reti
JAF60:
  AF60  2072       inc ($72)
  AF62  e0727717   cmp ($72),$17
  AF66  d33d       jr CC,LAFA5
  AF68  166002     ld DE,$0260
  AF6B  fcbebe     call SBEBE
  AF6E  fc1dbf     call SBF1D
  AF71  fc7cbf     call SBF7C
  AF74  fcdbbf     call SBFDB
  AF77  fc3ac0     call SC03A
  AF7A  fc99c0     call SC099
  AF7D  fcf8c0     call SC0F8
  AF80  fc57c1     call SC157
  AF83  fcb6c1     call SC1B6
  AF86  fc15c2     call SC215
  AF89  fc74c2     call SC274
  AF8C  fcd3c2     call SC2D3
  AF8F  fc32c3     call SC332
  AF92  fc91c3     call SC391
  AF95  fcf0c3     call SC3F0
  AF98  fc4fc4     call SC44F
  AF9B  2c7301     ld ($73),$01
  AF9E  483a       di
  AFA0  243a10fd   ldw ($3A),$FD10
  AFA4  04         reti
LAFA5:
  AFA5  22f5       ld A,($F5)
  AFA7  d021       jr Z,LAFCA
  AFA9  45e1       set ($E1).5
  AFAB  24740001   ldw ($74),$0100
  AFAF  24760001   ldw ($76),$0100
  AFB3  4870       clr ($70).0
  AFB5  4970       clr ($70).1
  AFB7  2c8003     ld ($80),$03
  AFBA  2e72       clr ($72)
  AFBC  4a70       clr ($70).2
  AFBE  2c7315     ld ($73),$15
  AFC1  2efe       clr ($FE)
  AFC3  483a       di
  AFC5  243a10fd   ldw ($3A),$FD10
  AFC9  04         reti
LAFCA:
  AFCA  d87c       test ($7C).0
  AFCC  8d         jrs T,LAFDB
  AFCD  4a70       clr ($70).2
  AFCF  2c7318     ld ($73),$18
  AFD2  2efe       clr ($FE)
  AFD4  483a       di
  AFD6  243a10fd   ldw ($3A),$FD10
  AFDA  04         reti
LAFDB:
  AFDB  45e1       set ($E1).5
  AFDD  e07414     ld WA,($74)
  AFE0  e07617     ld HL,($76)
  AFE3  eb37       cmp WA,HL
  AFE5  d728       jr F,LB00F
  AFE7  2270       ld A,($70)
  AFE9  7403       and A,$03
  AFEB  d722       jr F,LB00F
  AFED  4a70       clr ($70).2
  AFEF  227f       ld A,($7F)
  AFF1  d010       jr Z,LB003
  AFF3  2a80       ld ($80),A
  AFF5  2e72       clr ($72)
  AFF7  2c7315     ld ($73),$15
  AFFA  2efe       clr ($FE)
  AFFC  483a       di
  AFFE  243a10fd   ldw ($3A),$FD10
  B002  04         reti
LB003:
  B003  2c7318     ld ($73),$18
  B006  2efe       clr ($FE)
  B008  483a       di
  B00A  243a10fd   ldw ($3A),$FD10
  B00E  04         reti
LB00F:
  B00F  dbe1       test ($E1).3
  B011  8d         jrs T,LB020
  B012  4a70       clr ($70).2
  B014  2efe       clr ($FE)
  B016  2c7318     ld ($73),$18
  B019  483a       di
  B01B  243a10fd   ldw ($3A),$FD10
  B01F  04         reti
LB020:
  B020  20fc       inc ($FC)
  B022  166002     ld DE,$0260
  B025  fcbebe     call SBEBE
  B028  fc1dbf     call SBF1D
  B02B  fc7cbf     call SBF7C
  B02E  fcdbbf     call SBFDB
  B031  fc3ac0     call SC03A
  B034  fc99c0     call SC099
  B037  fcf8c0     call SC0F8
  B03A  fc57c1     call SC157
  B03D  fcb6c1     call SC1B6
  B040  fc15c2     call SC215
  B043  fc74c2     call SC274
  B046  fcd3c2     call SC2D3
  B049  fc32c3     call SC332
  B04C  fc91c3     call SC391
  B04F  fcf0c3     call SC3F0
  B052  fc4fc4     call SC44F
  B055  2c7313     ld ($73),$13
  B058  483a       di
  B05A  243a10fd   ldw ($3A),$FD10
  B05E  04         reti
JB05F:
  B05F  e0f57700   cmp ($F5),$00
  B063  88         jrs T,LB06D
  B064  d802       test ($02).0
  B066  85         jrs T,LB06D
  B067  d802       test ($02).0
  B069  82         jrs T,LB06D
  B06A  2cf500     ld ($F5),$00
LB06D:
  B06D  17fe00     ld HL,$00FE
  B070  e37700     cmp (HL),$00
  B073  d719       jr F,LB08E
  B075  4a70       clr ($70).2
  B077  d905       test ($05).1
  B079  a8         jrs F,LB083
  B07A  2d01       ld (HL),$01
  B07C  483a       di
  B07E  243a10fd   ldw ($3A),$FD10
  B082  04         reti
LB083:
  B083  2d02       ld (HL),$02
  B085  2e72       clr ($72)
  B087  483a       di
  B089  243a10fd   ldw ($3A),$FD10
  B08D  04         reti
LB08E:
  B08E  e37701     cmp (HL),$01
  B091  ad         jrs F,LB0A0
  B092  4a70       clr ($70).2
  B094  83         jrs T,LB099
  B095  2d02       ld (HL),$02
  B097  2e72       clr ($72)
LB099:
  B099  483a       di
  B09B  243a10fd   ldw ($3A),$FD10
  B09F  04         reti
LB0A0:
  B0A0  e37702     cmp (HL),$02
  B0A3  d713       jr F,LB0B8
  B0A5  2072       inc ($72)
  B0A7  e072771b   cmp ($72),$1B
  B0AB  d204       jr CS,LB0B1
  B0AD  4a70       clr ($70).2
  B0AF  2d03       ld (HL),$03
LB0B1:
  B0B1  483a       di
  B0B3  243a10fd   ldw ($3A),$FD10
  B0B7  04         reti
LB0B8:
  B0B8  e37703     cmp (HL),$03
  B0BB  ad         jrs F,LB0CA
  B0BC  4a70       clr ($70).2
  B0BE  83         jrs T,LB0C3
  B0BF  2d04       ld (HL),$04
  B0C1  2e72       clr ($72)
LB0C3:
  B0C3  483a       di
  B0C5  243a10fd   ldw ($3A),$FD10
  B0C9  04         reti
LB0CA:
  B0CA  d905       test ($05).1
  B0CC  aa         jrs F,LB0D8
  B0CD  4a70       clr ($70).2
  B0CF  2d03       ld (HL),$03
  B0D1  483a       di
  B0D3  243a10fd   ldw ($3A),$FD10
  B0D7  04         reti
LB0D8:
  B0D8  2072       inc ($72)
  B0DA  e0727703   cmp ($72),$03
  B0DE  d214       jr CS,LB0F4
  B0E0  4205       set ($05).2
  B0E2  2c7300     ld ($73),$00
  B0E5  2e72       clr ($72)
  B0E7  4d71       clr ($71).5
  B0E9  22f5       ld A,($F5)
  B0EB  d007       jr Z,LB0F4
  B0ED  e0f57702   cmp ($F5),$02
  B0F1  81         jrs T,LB0F4
  B0F2  427b       set ($7B).2
LB0F4:
  B0F4  483a       di
  B0F6  243a10fd   ldw ($3A),$FD10
  B0FA  04         reti
JB0FB:
  B0FB  2072       inc ($72)
  B0FD  e072770d   cmp ($72),$0D
  B101  d203       jr CS,LB106
  B103  2c7301     ld ($73),$01
LB106:
  B106  483a       di
  B108  243a10fd   ldw ($3A),$FD10
  B10C  04         reti
JB10D:
  B10D  2072       inc ($72)
  B10F  e072778a   cmp ($72),$8A
  B113  d205       jr CS,LB11A
  B115  2e72       clr ($72)
  B117  2c7312     ld ($73),$12
LB11A:
  B11A  483a       di
  B11C  243a10fd   ldw ($3A),$FD10
  B120  04         reti
JB121:
  B121  17fe00     ld HL,$00FE
  B124  e37700     cmp (HL),$00
  B127  d715       jr F,LB13E
  B129  2072       inc ($72)
  B12B  e072771b   cmp ($72),$1B
  B12F  d206       jr CS,LB137
  B131  2d01       ld (HL),$01
  B133  4a70       clr ($70).2
  B135  2e72       clr ($72)
LB137:
  B137  483a       di
  B139  243a10fd   ldw ($3A),$FD10
  B13D  04         reti
LB13E:
  B13E  e37701     cmp (HL),$01
  B141  ad         jrs F,LB150
  B142  4a70       clr ($70).2
  B144  83         jrs T,LB149
  B145  2d0b       ld (HL),$0B
  B147  2e72       clr ($72)
LB149:
  B149  483a       di
  B14B  243a10fd   ldw ($3A),$FD10
  B14F  04         reti
LB150:
  B150  4a70       clr ($70).2
  B152  d905       test ($05).1
  B154  a8         jrs F,LB15E
  B155  2d01       ld (HL),$01
  B157  483a       di
  B159  243a10fd   ldw ($3A),$FD10
  B15D  04         reti
LB15E:
  B15E  2072       inc ($72)
  B160  e0727706   cmp ($72),$06
  B164  d214       jr CS,LB17A
  B166  2e72       clr ($72)
  B168  e07e7700   cmp ($7E),$00
  B16C  85         jrs T,LB173
  B16D  2d00       ld (HL),$00
  B16F  287e       dec ($7E)
  B171  d107       jr NZ,LB17A
LB173:
  B173  2e72       clr ($72)
  B175  2c7312     ld ($73),$12
  B178  2efe       clr ($FE)
LB17A:
  B17A  483a       di
  B17C  243a10fd   ldw ($3A),$FD10
  B180  04         reti
JB181:
  B181  17fe00     ld HL,$00FE
  B184  e37700     cmp (HL),$00
  B187  ad         jrs F,LB196
  B188  4a70       clr ($70).2
  B18A  83         jrs T,LB18F
  B18B  2d0b       ld (HL),$0B
  B18D  2e72       clr ($72)
LB18F:
  B18F  483a       di
  B191  243a10fd   ldw ($3A),$FD10
  B195  04         reti
LB196:
  B196  e3770b     cmp (HL),$0B
  B199  d721       jr F,LB1BC
  B19B  4a70       clr ($70).2
  B19D  d905       test ($05).1
  B19F  a8         jrs F,LB1A9
  B1A0  2d00       ld (HL),$00
  B1A2  483a       di
  B1A4  243a10fd   ldw ($3A),$FD10
  B1A8  04         reti
LB1A9:
  B1A9  2072       inc ($72)
  B1AB  e0727703   cmp ($72),$03
  B1AF  d204       jr CS,LB1B5
  B1B1  2d01       ld (HL),$01
  B1B3  2e72       clr ($72)
LB1B5:
  B1B5  483a       di
  B1B7  243a10fd   ldw ($3A),$FD10
  B1BB  04         reti
LB1BC:
  B1BC  e37701     cmp (HL),$01
  B1BF  d713       jr F,LB1D4
  B1C1  2072       inc ($72)
  B1C3  e072771b   cmp ($72),$1B
  B1C7  d204       jr CS,LB1CD
  B1C9  2d02       ld (HL),$02
  B1CB  4a70       clr ($70).2
LB1CD:
  B1CD  483a       di
  B1CF  243a10fd   ldw ($3A),$FD10
  B1D3  04         reti
LB1D4:
  B1D4  e37702     cmp (HL),$02
  B1D7  ad         jrs F,LB1E6
  B1D8  4a70       clr ($70).2
  B1DA  83         jrs T,LB1DF
  B1DB  2d03       ld (HL),$03
  B1DD  2e72       clr ($72)
LB1DF:
  B1DF  483a       di
  B1E1  243a10fd   ldw ($3A),$FD10
  B1E5  04         reti
LB1E6:
  B1E6  d905       test ($05).1
  B1E8  aa         jrs F,LB1F4
  B1E9  4a70       clr ($70).2
  B1EB  2d02       ld (HL),$02
  B1ED  483a       di
  B1EF  243a10fd   ldw ($3A),$FD10
  B1F3  04         reti
LB1F4:
  B1F4  2072       inc ($72)
  B1F6  e0727703   cmp ($72),$03
  B1FA  d229       jr CS,LB225
  B1FC  2e72       clr ($72)
  B1FE  e0807700   cmp ($80),$00
  B202  8c         jrs T,LB210
  B203  2880       dec ($80)
  B205  d009       jr Z,LB210
  B207  2d01       ld (HL),$01
  B209  483a       di
  B20B  243a10fd   ldw ($3A),$FD10
  B20F  04         reti
LB210:
  B210  4205       set ($05).2
  B212  2ef5       clr ($F5)
  B214  2c7300     ld ($73),$00
  B217  dbe1       test ($E1).3
  B219  aa         jrs F,LB225
  B21A  e0e97700   cmp ($E9),$00
  B21E  85         jrs T,LB225
  B21F  28e9       dec ($E9)
  B221  d002       jr Z,LB225
  B223  427b       set ($7B).2
LB225:
  B225  483a       di
  B227  243a10fd   ldw ($3A),$FD10
  B22B  04         reti
JB22C:
  B22C  17fe00     ld HL,$00FE
  B22F  e37700     cmp (HL),$00
  B232  d713       jr F,LB247
  B234  2072       inc ($72)
  B236  e072771b   cmp ($72),$1B
  B23A  d204       jr CS,LB240
  B23C  4a70       clr ($70).2
  B23E  2d01       ld (HL),$01
LB240:
  B240  483a       di
  B242  243a10fd   ldw ($3A),$FD10
  B246  04         reti
LB247:
  B247  e37701     cmp (HL),$01
  B24A  ad         jrs F,LB259
  B24B  4a70       clr ($70).2
  B24D  83         jrs T,LB252
  B24E  2d02       ld (HL),$02
  B250  2e72       clr ($72)
LB252:
  B252  483a       di
  B254  243a10fd   ldw ($3A),$FD10
  B258  04         reti
LB259:
  B259  d905       test ($05).1
  B25B  aa         jrs F,LB267
  B25C  4a70       clr ($70).2
  B25E  2d01       ld (HL),$01
  B260  483a       di
  B262  243a10fd   ldw ($3A),$FD10
  B266  04         reti
LB267:
  B267  2072       inc ($72)
  B269  e0727703   cmp ($72),$03
  B26D  d230       jr CS,LB29F
  B26F  2e72       clr ($72)
  B271  e0807700   cmp ($80),$00
  B275  8c         jrs T,LB283
  B276  2880       dec ($80)
  B278  d009       jr Z,LB283
  B27A  2d00       ld (HL),$00
  B27C  483a       di
  B27E  243a10fd   ldw ($3A),$FD10
  B282  04         reti
LB283:
  B283  e0e97700   cmp ($E9),$00
  B287  8f         jrs T,LB298
  B288  28e9       dec ($E9)
  B28A  d00c       jr Z,LB298
  B28C  268180     ld ($80),($81)
  B28F  2d00       ld (HL),$00
  B291  483a       di
  B293  243a10fd   ldw ($3A),$FD10
  B297  04         reti
LB298:
  B298  4205       set ($05).2
  B29A  2e72       clr ($72)
  B29C  2c7300     ld ($73),$00
LB29F:
  B29F  483a       di
  B2A1  243a10fd   ldw ($3A),$FD10
  B2A5  04         reti
JB2A6:
  B2A6  d802       test ($02).0
  B2A8  d625       jr T,LB2CF
  B2AA  d802       test ($02).0
  B2AC  d621       jr T,LB2CF
  B2AE  17fe00     ld HL,$00FE
  B2B1  e37700     cmp (HL),$00
  B2B4  d722       jr F,LB2D8
  B2B6  4a70       clr ($70).2
  B2B8  d905       test ($05).1
  B2BA  a8         jrs F,LB2C4
  B2BB  2d02       ld (HL),$02
  B2BD  483a       di
  B2BF  243a10fd   ldw ($3A),$FD10
  B2C3  04         reti
LB2C4:
  B2C4  2d01       ld (HL),$01
  B2C6  2e72       clr ($72)
  B2C8  483a       di
  B2CA  243a10fd   ldw ($3A),$FD10
  B2CE  04         reti
LB2CF:
  B2CF  2efe       clr ($FE)
  B2D1  483a       di
  B2D3  243a10fd   ldw ($3A),$FD10
  B2D7  04         reti
LB2D8:
  B2D8  e37701     cmp (HL),$01
  B2DB  d713       jr F,LB2F0
  B2DD  2072       inc ($72)
  B2DF  e072771b   cmp ($72),$1B
  B2E3  d204       jr CS,LB2E9
  B2E5  2d02       ld (HL),$02
  B2E7  4a70       clr ($70).2
LB2E9:
  B2E9  483a       di
  B2EB  243a10fd   ldw ($3A),$FD10
  B2EF  04         reti
LB2F0:
  B2F0  e37702     cmp (HL),$02
  B2F3  ad         jrs F,LB302
  B2F4  4a70       clr ($70).2
  B2F6  83         jrs T,LB2FB
  B2F7  2d03       ld (HL),$03
  B2F9  2e72       clr ($72)
LB2FB:
  B2FB  483a       di
  B2FD  243a10fd   ldw ($3A),$FD10
  B301  04         reti
LB302:
  B302  d905       test ($05).1
  B304  aa         jrs F,LB310
  B305  4a70       clr ($70).2
  B307  2d02       ld (HL),$02
  B309  483a       di
  B30B  243a10fd   ldw ($3A),$FD10
  B30F  04         reti
LB310:
  B310  2072       inc ($72)
  B312  e0727703   cmp ($72),$03
  B316  d209       jr CS,LB321
  B318  4205       set ($05).2
  B31A  2c7300     ld ($73),$00
  B31D  2e72       clr ($72)
  B31F  4d71       clr ($71).5
LB321:
  B321  483a       di
  B323  243a10fd   ldw ($3A),$FD10
  B327  04         reti
JB328:
  B328  17fe00     ld HL,$00FE
  B32B  e37700     cmp (HL),$00
  B32E  ae         jrs F,LB33E
  B32F  4a70       clr ($70).2
  B331  d636       jr T,JB369
  B333  2e72       clr ($72)
  B335  2d01       ld (HL),$01
  B337  483a       di
  B339  243a10fd   ldw ($3A),$FD10
  B33D  04         reti
LB33E:
  B33E  d905       test ($05).1
  B340  aa         jrs F,LB34C
  B341  4a70       clr ($70).2
  B343  2d00       ld (HL),$00
  B345  483a       di
  B347  243a10fd   ldw ($3A),$FD10
  B34B  04         reti
LB34C:
  B34C  2072       inc ($72)
  B34E  e0727703   cmp ($72),$03
  B352  d215       jr CS,JB369
  B354  2e72       clr ($72)
  B356  2c7300     ld ($73),$00
  B359  4205       set ($05).2
  B35B  dbe1       test ($E1).3
  B35D  aa         jrs F,JB369
  B35E  e0e97700   cmp ($E9),$00
  B362  85         jrs T,JB369
  B363  28e9       dec ($E9)
  B365  d002       jr Z,JB369
  B367  427b       set ($7B).2
JB369:
  B369  483a       di
  B36B  243a10fd   ldw ($3A),$FD10
  B36F  04         reti
V_FFE2:
  B370  47e0       set ($E0).7
  B372  04         reti
V_FFE4:
  B373  0f03       ld RBS,3
  B375  e03a17     ld HL,($3A)
  B378  f0f013     ld ($F0),HL
  B37B  243a1100   ldw ($3A),$0011
  B37F  171c04     ld HL,$041C
  B382  2df3       ld (HL),$F3
  B384  d8d9       test ($D9).0
  B386  82         jrs T,LB38A
  B387  e0d7fe     jp ($D7)
LB38A:
  B38A  17f80f     ld HL,$0FF8
  B38D  23         ld A,(HL)
  B38E  dcda       test ($DA).4
  B390  d72d       jr F,LB3BF
  B392  7711       cmp A,$11
  B394  d729       jr F,LB3BF
  B396  da7c       test ($7C).2
  B398  a3         jrs F,LB39D
  B399  dd71       test ($71).5
  B39B  d717       jr F,LB3B4
LB39D:
  B39D  2d00       ld (HL),$00
  B39F  2c1cc0     ld ($1C),$C0
  B3A2  2c1b14     ld ($1B),$14
  B3A5  2c1cd0     ld ($1C),$D0
  B3A8  fcb4b9     call SB9B4
  B3AB  17f80f     ld HL,$0FF8
  B3AE  23         ld A,(HL)
  B3AF  77cc       cmp A,$CC
  B3B1  d62f       jr T,LB3E2
  B3B3  8a         jrs T,LB3BF
LB3B4:
  B3B4  2dff       ld (HL),$FF
LB3B6:
  B3B6  48d9       clr ($D9).0
  B3B8  e0f017     ld HL,($F0)
  B3BB  f03a13     ld ($3A),HL
  B3BE  04         reti
LB3BF:
  B3BF  d9e1       test ($E1).1
  B3C1  a1         jrs F,LB3C4
  B3C2  47db       set ($DB).7
LB3C4:
  B3C4  2dff       ld (HL),$FF
  B3C6  171c04     ld HL,$041C
  B3C9  2df3       ld (HL),$F3
  B3CB  de7c       test ($7C).6
  B3CD  81         jrs T,LB3D0
  B3CE  44da       set ($DA).4
LB3D0:
  B3D0  2c1cc0     ld ($1C),$C0
  B3D3  2c1b14     ld ($1B),$14
  B3D6  2c1cd0     ld ($1C),$D0
  B3D9  fcb4b9     call SB9B4
  B3DC  17f80f     ld HL,$0FF8
  B3DF  23         ld A,(HL)
  B3E0  fbe2       jr LB3C4
LB3E2:
  B3E2  2d00       ld (HL),$00
  B3E4  2c1cc0     ld ($1C),$C0
  B3E7  2c1cd0     ld ($1C),$D0
  B3EA  fcb4b9     call SB9B4
  B3ED  17ec03     ld HL,$03EC
  B3F0  16f80f     ld DE,$0FF8
  B3F3  e258       ld A,(DE)
  B3F5  f22c00     ld (DE),$00
  B3F8  1d         shrc A
  B3F9  e91e       rolc W
  B3FB  1d         shrc A
  B3FC  e91e       rolc W
  B3FE  1d         shrc A
  B3FF  e91e       rolc W
  B401  1d         shrc A
  B402  e91e       rolc W
  B404  1d         shrc A
  B405  e91e       rolc W
  B407  1d         shrc A
  B408  e91e       rolc W
  B40A  1d         shrc A
  B40B  e91e       rolc W
  B40D  1d         shrc A
  B40E  e91e       rolc W
  B410  51         ld A,W
  B411  2b         ld (HL),A
  B412  3100       ld W,$00
  B414  171404     ld HL,$0414
  B417  f310       ld (HL),WA
  B419  2c1cc0     ld ($1C),$C0
  B41C  2c1cd0     ld ($1C),$D0
  B41F  fcb4b9     call SB9B4
  B422  17ed03     ld HL,$03ED
  B425  16f80f     ld DE,$0FF8
  B428  e258       ld A,(DE)
  B42A  f22c00     ld (DE),$00
  B42D  1d         shrc A
  B42E  e91e       rolc W
  B430  1d         shrc A
  B431  e91e       rolc W
  B433  1d         shrc A
  B434  e91e       rolc W
  B436  1d         shrc A
  B437  e91e       rolc W
  B439  1d         shrc A
  B43A  e91e       rolc W
  B43C  1d         shrc A
  B43D  e91e       rolc W
  B43F  1d         shrc A
  B440  e91e       rolc W
  B442  1d         shrc A
  B443  e91e       rolc W
  B445  51         ld A,W
  B446  2b         ld (HL),A
  B447  171404     ld HL,$0414
  B44A  e316       ld DE,(HL)
  B44C  3100       ld W,$00
  B44E  ea31       add WA,DE
  B450  f310       ld (HL),WA
  B452  2c1cc0     ld ($1C),$C0
  B455  2c1cd0     ld ($1C),$D0
  B458  fcb4b9     call SB9B4
  B45B  17ee03     ld HL,$03EE
  B45E  16f80f     ld DE,$0FF8
  B461  e258       ld A,(DE)
  B463  f22c00     ld (DE),$00
  B466  1d         shrc A
  B467  e91e       rolc W
  B469  1d         shrc A
  B46A  e91e       rolc W
  B46C  1d         shrc A
  B46D  e91e       rolc W
  B46F  1d         shrc A
  B470  e91e       rolc W
  B472  1d         shrc A
  B473  e91e       rolc W
  B475  1d         shrc A
  B476  e91e       rolc W
  B478  1d         shrc A
  B479  e91e       rolc W
  B47B  1d         shrc A
  B47C  e91e       rolc W
  B47E  51         ld A,W
  B47F  2b         ld (HL),A
  B480  171404     ld HL,$0414
  B483  e316       ld DE,(HL)
  B485  3100       ld W,$00
  B487  ea31       add WA,DE
  B489  f310       ld (HL),WA
  B48B  2c1cc0     ld ($1C),$C0
  B48E  2c1cd0     ld ($1C),$D0
  B491  fcb4b9     call SB9B4
  B494  17ef03     ld HL,$03EF
  B497  16f80f     ld DE,$0FF8
  B49A  e258       ld A,(DE)
  B49C  f22c00     ld (DE),$00
  B49F  1d         shrc A
  B4A0  e91e       rolc W
  B4A2  1d         shrc A
  B4A3  e91e       rolc W
  B4A5  1d         shrc A
  B4A6  e91e       rolc W
  B4A8  1d         shrc A
  B4A9  e91e       rolc W
  B4AB  1d         shrc A
  B4AC  e91e       rolc W
  B4AE  1d         shrc A
  B4AF  e91e       rolc W
  B4B1  1d         shrc A
  B4B2  e91e       rolc W
  B4B4  1d         shrc A
  B4B5  e91e       rolc W
  B4B7  51         ld A,W
  B4B8  2b         ld (HL),A
  B4B9  171404     ld HL,$0414
  B4BC  e316       ld DE,(HL)
  B4BE  3100       ld W,$00
  B4C0  ea31       add WA,DE
  B4C2  f310       ld (HL),WA
  B4C4  2c1cc0     ld ($1C),$C0
  B4C7  2c1cd0     ld ($1C),$D0
  B4CA  171604     ld HL,$0416
  B4CD  16ee03     ld DE,$03EE
  B4D0  e214       ld WA,(DE)
  B4D2  f310       ld (HL),WA
  B4D4  49da       clr ($DA).1
  B4D6  4bd9       clr ($D9).3
  B4D8  4fda       clr ($DA).7
  B4DA  17ec03     ld HL,$03EC
  B4DD  e3770f     cmp (HL),$0F
  B4E0  ab         jrs F,LB4ED
  B4E1  4971       clr ($71).1
  B4E3  d9e1       test ($E1).1
  B4E5  a8         jrs F,LB4EF
  B4E6  da7c       test ($7C).2
  B4E8  a5         jrs F,LB4EF
  B4E9  4c7c       clr ($7C).4
  B4EB  fb02       jr LB4EF
LB4ED:
  B4ED  48da       clr ($DA).0
LB4EF:
  B4EF  e37701     cmp (HL),$01
  B4F2  aa         jrs F,LB4FE
  B4F3  de7c       test ($7C).6
  B4F5  a2         jrs F,LB4F9
  B4F6  fe88b7     jp LB788
LB4F9:
  B4F9  447c       set ($7C).4
  B4FB  fe44b7     jp LB744
LB4FE:
  B4FE  e37704     cmp (HL),$04
  B501  82         jrs T,LB505
  B502  fe44b7     jp LB744
LB505:
  B505  de7c       test ($7C).6
  B507  82         jrs T,LB50B
  B508  febcb8     jp LB8BC
LB50B:
  B50B  171604     ld HL,$0416
  B50E  e314       ld WA,(HL)
  B510  e83f0004   cmp WA,$0400
  B514  d203       jr CS,LB519
  B516  feb0b8     jp LB8B0
LB519:
  B519  e83f0000   cmp WA,$0000
  B51D  d717       jr F,LB536
  B51F  17ec03     ld HL,$03EC
  B522  e40158     ld A,(HL+1)
  B525  d10a       jr NZ,LB531
  B527  457c       set ($7C).5
  B529  a6         jrs F,LB531
  B52A  4171       set ($71).1
  B52C  45d9       set ($D9).5
  B52E  feefb5     jp LB5EF
LB531:
  B531  40da       set ($DA).0
  B533  feefb5     jp LB5EF
LB536:
  B536  ddda       test ($DA).5
  B538  84         jrs T,LB53E
  B539  40da       set ($DA).0
  B53B  febeb8     jp LB8BE
LB53E:
  B53E  48e1       clr ($E1).0
  B540  d62a       jr T,LB56C
  B542  17f80f     ld HL,$0FF8
  B545  dc7c       test ($7C).4
  B547  82         jrs T,LB54B
  B548  feb4b3     jp LB3B4
LB54B:
  B54B  4d7c       clr ($7C).5
  B54D  4871       clr ($71).0
  B54F  49e0       clr ($E0).1
  B551  4ae0       clr ($E0).2
  B553  4cd9       clr ($D9).4
  B555  4dd9       clr ($D9).5
  B557  24e20000   ldw ($E2),$0000
  B55B  24830000   ldw ($83),$0000
  B55F  24850000   ldw ($85),$0000
  B563  17f403     ld HL,$03F4
  B566  f0dc13     ld ($DC),HL
  B569  f0de13     ld ($DE),HL
LB56C:
  B56C  dd7c       test ($7C).5
  B56E  82         jrs T,LB572
  B56F  fe69b8     jp LB869
LB572:
  B572  17ed03     ld HL,$03ED
  B575  23         ld A,(HL)
  B576  7701       cmp A,$01
  B578  d403       jr LE,LB57D
  B57A  fe69b8     jp LB869
LB57D:
  B57D  e3d8       test (HL).0
  B57F  e0d9ce     ld ($D9).6,CF
  B582  43d9       set ($D9).3
  B584  40e0       set ($E0).0
  B586  47d9       set ($D9).7
LB588:
  B588  de7c       test ($7C).6
  B58A  8d         jrs T,LB599
  B58B  47da       set ($DA).7
  B58D  17f403     ld HL,$03F4
  B590  f0dc13     ld ($DC),HL
  B593  f0de13     ld ($DE),HL
  B596  febeb8     jp LB8BE
LB599:
  B599  fcb4b9     call SB9B4
  B59C  16dc00     ld DE,$00DC
  B59F  e217       ld HL,(DE)
  B5A1  16f80f     ld DE,$0FF8
  B5A4  e258       ld A,(DE)
  B5A6  f22c00     ld (DE),$00
  B5A9  1d         shrc A
  B5AA  e91e       rolc W
  B5AC  1d         shrc A
  B5AD  e91e       rolc W
  B5AF  1d         shrc A
  B5B0  e91e       rolc W
  B5B2  1d         shrc A
  B5B3  e91e       rolc W
  B5B5  1d         shrc A
  B5B6  e91e       rolc W
  B5B8  1d         shrc A
  B5B9  e91e       rolc W
  B5BB  1d         shrc A
  B5BC  e91e       rolc W
  B5BE  1d         shrc A
  B5BF  e91e       rolc W
  B5C1  51         ld A,W
  B5C2  2b         ld (HL),A
  B5C3  13         inc HL
  B5C4  eb3f1304   cmp HL,$0413
  B5C8  d403       jr LE,LB5CD
  B5CA  17f403     ld HL,$03F4
LB5CD:
  B5CD  16dc00     ld DE,$00DC
  B5D0  f213       ld (DE),HL
  B5D2  161404     ld DE,$0414
  B5D5  e217       ld HL,(DE)
  B5D7  3100       ld W,$00
  B5D9  eb31       add WA,HL
  B5DB  f210       ld (DE),WA
  B5DD  2c1cc0     ld ($1C),$C0
  B5E0  2c1cd0     ld ($1C),$D0
  B5E3  171604     ld HL,$0416
  B5E6  e314       ld WA,(HL)
  B5E8  18         dec WA
  B5E9  d004       jr Z,LB5EF
  B5EB  f310       ld (HL),WA
  B5ED  fb99       jr LB588
LB5EF:
  B5EF  fcb4b9     call SB9B4
  B5F2  16f80f     ld DE,$0FF8
  B5F5  e258       ld A,(DE)
  B5F7  f22c00     ld (DE),$00
  B5FA  1d         shrc A
  B5FB  e91e       rolc W
  B5FD  1d         shrc A
  B5FE  e91e       rolc W
  B600  1d         shrc A
  B601  e91e       rolc W
  B603  1d         shrc A
  B604  e91e       rolc W
  B606  1d         shrc A
  B607  e91e       rolc W
  B609  1d         shrc A
  B60A  e91e       rolc W
  B60C  1d         shrc A
  B60D  e91e       rolc W
  B60F  1d         shrc A
  B610  e91e       rolc W
  B612  51         ld A,W
  B613  3100       ld W,$00
  B615  e816       ld DE,WA
  B617  171404     ld HL,$0414
  B61A  e314       ld WA,(HL)
  B61C  ea33       sub WA,DE
  B61E  f310       ld (HL),WA
  B620  2c1cc0     ld ($1C),$C0
  B623  2c1cd0     ld ($1C),$D0
  B626  d8da       test ($DA).0
  B628  a3         jrs F,LB62D
  B629  4b7c       clr ($7C).3
  B62B  fb02       jr LB62F
LB62D:
  B62D  437c       set ($7C).3
LB62F:
  B62F  227c       ld A,($7C)
  B631  d971       test ($71).1
  B633  81         jrs T,LB636
  B634  74df       and A,$DF
LB636:
  B636  d87c       test ($7C).0
  B638  84         jrs T,LB63E
  B639  d9d9       test ($D9).1
  B63B  81         jrs T,LB63E
  B63C  74fe       and A,$FE
LB63E:
  B63E  dbd9       test ($D9).3
  B640  84         jrs T,LB646
  B641  d9da       test ($DA).1
  B643  a1         jrs F,LB646
  B644  74bf       and A,$BF
LB646:
  B646  5b         ld B,A
  B647  fcb4b9     call SB9B4
  B64A  2c1cc0     ld ($1C),$C0
  B64D  2c1cd0     ld ($1C),$D0
  B650  16f80f     ld DE,$0FF8
  B653  e258       ld A,(DE)
  B655  f22c00     ld (DE),$00
  B658  1d         shrc A
  B659  e91e       rolc W
  B65B  1d         shrc A
  B65C  e91e       rolc W
  B65E  1d         shrc A
  B65F  e91e       rolc W
  B661  1d         shrc A
  B662  e91e       rolc W
  B664  1d         shrc A
  B665  e91e       rolc W
  B667  1d         shrc A
  B668  e91e       rolc W
  B66A  1d         shrc A
  B66B  e91e       rolc W
  B66D  1d         shrc A
  B66E  e91e       rolc W
  B670  51         ld A,W
  B671  3000       ld A,$00
  B673  e816       ld DE,WA
  B675  171404     ld HL,$0414
  B678  e314       ld WA,(HL)
  B67A  ea33       sub WA,DE
  B67C  d104       jr NZ,LB682
  B67E  4f7c       clr ($7C).7
  B680  fb0f       jr LB691
LB682:
  B682  17ec03     ld HL,$03EC
  B685  e37702     cmp (HL),$02
  B688  85         jrs T,LB68F
  B689  e37708     cmp (HL),$08
  B68C  81         jrs T,LB68F
  B68D  4d7c       clr ($7C).5
LB68F:
  B68F  477c       set ($7C).7
LB691:
  B691  2c2267     ld ($22),$67
  B694  2c2301     ld ($23),$01
  B697  17f80f     ld HL,$0FF8
  B69A  f62c81     ld (HL+),$81
  B69D  f353       ld (HL),B
  B69F  2c22a7     ld ($22),$A7
  B6A2  fcb4b9     call SB9B4
  B6A5  17f80f     ld HL,$0FF8
  B6A8  2d00       ld (HL),$00
  B6AA  4fd9       clr ($D9).7
  B6AC  d87c       test ($7C).0
  B6AE  87         jrs T,LB6B7
  B6AF  ebd8       test B.0
  B6B1  84         jrs T,LB6B7
  B6B2  2ce86d     ld ($E8),$6D
  B6B5  42d9       set ($D9).2
LB6B7:
  B6B7  2c2267     ld ($22),$67
  B6BA  2c2300     ld ($23),$00
  B6BD  2c22a7     ld ($22),$A7
  B6C0  2c1cc0     ld ($1C),$C0
  B6C3  d9da       test ($DA).1
  B6C5  82         jrs T,LB6C9
  B6C6  feb6b3     jp LB3B6
LB6C9:
  B6C9  dbd9       test ($D9).3
  B6CB  d75b       jr F,LB728
  B6CD  df7c       test ($7C).7
  B6CF  82         jrs T,LB6D3
  B6D0  feb6b3     jp LB3B6
LB6D3:
  B6D3  db7c       test ($7C).3
  B6D5  82         jrs T,LB6D9
  B6D6  feb6b3     jp LB3B6
LB6D9:
  B6D9  17ec03     ld HL,$03EC
  B6DC  e37701     cmp (HL),$01
  B6DF  d71e       jr F,LB6FF
  B6E1  de7c       test ($7C).6
  B6E3  84         jrs T,LB6E9
  B6E4  e0737717   cmp ($73),$17
  B6E8  aa         jrs F,LB6F4
LB6E9:
  B6E9  47db       set ($DB).7
  B6EB  48d9       clr ($D9).0
  B6ED  e0f017     ld HL,($F0)
  B6F0  f03a13     ld ($3A),HL
  B6F3  04         reti
LB6F4:
  B6F4  46e1       set ($E1).6
  B6F6  48d9       clr ($D9).0
  B6F8  e0f017     ld HL,($F0)
  B6FB  f03a13     ld ($3A),HL
  B6FE  04         reti
LB6FF:
  B6FF  e37702     cmp (HL),$02
  B702  aa         jrs F,LB70E
  B703  46db       set ($DB).6
  B705  48d9       clr ($D9).0
  B707  e0f017     ld HL,($F0)
  B70A  f03a13     ld ($3A),HL
  B70D  04         reti
LB70E:
  B70E  e37708     cmp (HL),$08
  B711  aa         jrs F,LB71D
  B712  45db       set ($DB).5
  B714  48d9       clr ($D9).0
  B716  e0f017     ld HL,($F0)
  B719  f03a13     ld ($3A),HL
  B71C  04         reti
LB71D:
  B71D  44db       set ($DB).4
  B71F  48d9       clr ($D9).0
  B721  e0f017     ld HL,($F0)
  B724  f03a13     ld ($3A),HL
  B727  04         reti
LB728:
  B728  227c       ld A,($7C)
  B72A  7488       and A,$88
  B72C  d10b       jr NZ,LB739
  B72E  44d9       set ($D9).4
  B730  48d9       clr ($D9).0
  B732  e0f017     ld HL,($F0)
  B735  f03a13     ld ($3A),HL
  B738  04         reti
LB739:
  B739  47da       set ($DA).7
  B73B  48d9       clr ($D9).0
  B73D  e0f017     ld HL,($F0)
  B740  f03a13     ld ($3A),HL
  B743  04         reti
LB744:
  B744  e37702     cmp (HL),$02
  B747  d718       jr F,LB761
  B749  d9e1       test ($E1).1
  B74B  82         jrs T,LB74F
  B74C  febeb8     jp LB8BE
LB74F:
  B74F  ddd9       test ($D9).5
  B751  8a         jrs T,LB75D
  B752  171604     ld HL,$0416
  B755  e314       ld WA,(HL)
  B757  e83f0400   cmp WA,$0004
  B75B  d32b       jr CC,LB788
LB75D:
  B75D  40da       set ($DA).0
  B75F  fb27       jr LB788
LB761:
  B761  e37708     cmp (HL),$08
  B764  ae         jrs F,LB774
  B765  171604     ld HL,$0416
  B768  e314       ld WA,(HL)
  B76A  e83f0004   cmp WA,$0400
  B76E  d218       jr CS,LB788
  B770  40da       set ($DA).0
  B772  fb14       jr LB788
LB774:
  B774  e3770f     cmp (HL),$0F
  B777  82         jrs T,LB77B
  B778  febeb8     jp LB8BE
LB77B:
  B77B  171604     ld HL,$0416
  B77E  e314       ld WA,(HL)
  B780  e83f0004   cmp WA,$0400
  B784  d202       jr CS,LB788
  B786  40da       set ($DA).0
LB788:
  B788  17f003     ld HL,$03F0
  B78B  f62c00     ld (HL+),$00
  B78E  f62c00     ld (HL+),$00
  B791  f62c00     ld (HL+),$00
  B794  2d00       ld (HL),$00
  B796  171604     ld HL,$0416
  B799  e314       ld WA,(HL)
  B79B  e83f0000   cmp WA,$0000
  B79F  a2         jrs F,LB7A3
  B7A0  feefb5     jp LB5EF
LB7A3:
  B7A3  e83fff03   cmp WA,$03FF
  B7A7  d403       jr LE,LB7AC
  B7A9  fe69b8     jp LB869
LB7AC:
  B7AC  e83f0400   cmp WA,$0004
  B7B0  d406       jr LE,LB7B8
  B7B2  171604     ld HL,$0416
  B7B5  250400     ldw (HL),$0004
LB7B8:
  B7B8  fcb4b9     call SB9B4
  B7BB  171604     ld HL,$0416
  B7BE  e359       ld W,(HL)
  B7C0  3004       ld A,$04
  B7C2  e963       sub A,W
  B7C4  3100       ld W,$00
  B7C6  17f003     ld HL,$03F0
  B7C9  eb31       add WA,HL
  B7CB  e817       ld HL,WA
  B7CD  16f80f     ld DE,$0FF8
  B7D0  e258       ld A,(DE)
  B7D2  f22c00     ld (DE),$00
  B7D5  1d         shrc A
  B7D6  e91e       rolc W
  B7D8  1d         shrc A
  B7D9  e91e       rolc W
  B7DB  1d         shrc A
  B7DC  e91e       rolc W
  B7DE  1d         shrc A
  B7DF  e91e       rolc W
  B7E1  1d         shrc A
  B7E2  e91e       rolc W
  B7E4  1d         shrc A
  B7E5  e91e       rolc W
  B7E7  1d         shrc A
  B7E8  e91e       rolc W
  B7EA  1d         shrc A
  B7EB  e91e       rolc W
  B7ED  51         ld A,W
  B7EE  2b         ld (HL),A
  B7EF  3500       ld D,$00
  B7F1  5c         ld E,A
  B7F2  171404     ld HL,$0414
  B7F5  e314       ld WA,(HL)
  B7F7  ea31       add WA,DE
  B7F9  f310       ld (HL),WA
  B7FB  2c1cc0     ld ($1C),$C0
  B7FE  2c1cd0     ld ($1C),$D0
  B801  171604     ld HL,$0416
  B804  e314       ld WA,(HL)
  B806  18         dec WA
  B807  d004       jr Z,LB80D
  B809  f310       ld (HL),WA
  B80B  fbab       jr LB7B8
LB80D:
  B80D  17ee03     ld HL,$03EE
  B810  e314       ld WA,(HL)
  B812  e83f0400   cmp WA,$0004
  B816  d503       jr GT,LB81B
  B818  feefb5     jp LB5EF
LB81B:
  B81B  e83b0400   sub WA,$0004
  B81F  171604     ld HL,$0416
  B822  f310       ld (HL),WA
LB824:
  B824  fcb4b9     call SB9B4
  B827  16f80f     ld DE,$0FF8
  B82A  e258       ld A,(DE)
  B82C  f22c00     ld (DE),$00
  B82F  1d         shrc A
  B830  e91e       rolc W
  B832  1d         shrc A
  B833  e91e       rolc W
  B835  1d         shrc A
  B836  e91e       rolc W
  B838  1d         shrc A
  B839  e91e       rolc W
  B83B  1d         shrc A
  B83C  e91e       rolc W
  B83E  1d         shrc A
  B83F  e91e       rolc W
  B841  1d         shrc A
  B842  e91e       rolc W
  B844  1d         shrc A
  B845  e91e       rolc W
  B847  51         ld A,W
  B848  3500       ld D,$00
  B84A  5c         ld E,A
  B84B  171404     ld HL,$0414
  B84E  e314       ld WA,(HL)
  B850  ea31       add WA,DE
  B852  f310       ld (HL),WA
  B854  2c1cc0     ld ($1C),$C0
  B857  2c1cd0     ld ($1C),$D0
  B85A  171604     ld HL,$0416
  B85D  e314       ld WA,(HL)
  B85F  18         dec WA
  B860  d103       jr NZ,LB865
  B862  feefb5     jp LB5EF
LB865:
  B865  f310       ld (HL),WA
  B867  fbbb       jr LB824
LB869:
  B869  40da       set ($DA).0
LB86B:
  B86B  fcb4b9     call SB9B4
  B86E  16f80f     ld DE,$0FF8
  B871  e258       ld A,(DE)
  B873  f22c00     ld (DE),$00
  B876  1d         shrc A
  B877  e91e       rolc W
  B879  1d         shrc A
  B87A  e91e       rolc W
  B87C  1d         shrc A
  B87D  e91e       rolc W
  B87F  1d         shrc A
  B880  e91e       rolc W
  B882  1d         shrc A
  B883  e91e       rolc W
  B885  1d         shrc A
  B886  e91e       rolc W
  B888  1d         shrc A
  B889  e91e       rolc W
  B88B  1d         shrc A
  B88C  e91e       rolc W
  B88E  51         ld A,W
  B88F  3500       ld D,$00
  B891  5c         ld E,A
  B892  171404     ld HL,$0414
  B895  e314       ld WA,(HL)
  B897  ea31       add WA,DE
  B899  f310       ld (HL),WA
  B89B  2c1cc0     ld ($1C),$C0
  B89E  2c1cd0     ld ($1C),$D0
  B8A1  171604     ld HL,$0416
  B8A4  e314       ld WA,(HL)
  B8A6  18         dec WA
  B8A7  d103       jr NZ,LB8AC
  B8A9  feefb5     jp LB5EF
LB8AC:
  B8AC  f310       ld (HL),WA
  B8AE  fbbb       jr LB86B
LB8B0:
  B8B0  17ec03     ld HL,$03EC
  B8B3  e40158     ld A,(HL+1)
  B8B6  d119       jr NZ,LB8D1
  B8B8  40da       set ($DA).0
  B8BA  fb15       jr LB8D1
LB8BC:
  B8BC  47d9       set ($D9).7
LB8BE:
  B8BE  41da       set ($DA).1
  B8C0  de7c       test ($7C).6
  B8C2  d752       jr F,LB916
  B8C4  171604     ld HL,$0416
  B8C7  e314       ld WA,(HL)
  B8C9  e83f0000   cmp WA,$0000
  B8CD  a2         jrs F,LB8D1
  B8CE  feefb5     jp LB5EF
LB8D1:
  B8D1  fcb4b9     call SB9B4
  B8D4  16f80f     ld DE,$0FF8
  B8D7  e258       ld A,(DE)
  B8D9  f22c00     ld (DE),$00
  B8DC  1d         shrc A
  B8DD  e91e       rolc W
  B8DF  1d         shrc A
  B8E0  e91e       rolc W
  B8E2  1d         shrc A
  B8E3  e91e       rolc W
  B8E5  1d         shrc A
  B8E6  e91e       rolc W
  B8E8  1d         shrc A
  B8E9  e91e       rolc W
  B8EB  1d         shrc A
  B8EC  e91e       rolc W
  B8EE  1d         shrc A
  B8EF  e91e       rolc W
  B8F1  1d         shrc A
  B8F2  e91e       rolc W
  B8F4  51         ld A,W
  B8F5  3500       ld D,$00
  B8F7  5c         ld E,A
  B8F8  171404     ld HL,$0414
  B8FB  e314       ld WA,(HL)
  B8FD  ea31       add WA,DE
  B8FF  f310       ld (HL),WA
  B901  2c1cc0     ld ($1C),$C0
  B904  2c1cd0     ld ($1C),$D0
  B907  171604     ld HL,$0416
  B90A  e314       ld WA,(HL)
  B90C  18         dec WA
  B90D  d103       jr NZ,LB912
  B90F  feefb5     jp LB5EF
LB912:
  B912  f310       ld (HL),WA
  B914  fbbb       jr LB8D1
LB916:
  B916  171604     ld HL,$0416
  B919  e314       ld WA,(HL)
  B91B  e83f0000   cmp WA,$0000
  B91F  d61d       jr T,LB93E
LB921:
  B921  fcb4b9     call SB9B4
  B924  16f80f     ld DE,$0FF8
  B927  e258       ld A,(DE)
  B929  f22c00     ld (DE),$00
  B92C  2c1cc0     ld ($1C),$C0
  B92F  2c1cd0     ld ($1C),$D0
  B932  171604     ld HL,$0416
  B935  e314       ld WA,(HL)
  B937  18         dec WA
  B938  d004       jr Z,LB93E
  B93A  f310       ld (HL),WA
  B93C  fbe3       jr LB921
LB93E:
  B93E  fcb4b9     call SB9B4
  B941  16f80f     ld DE,$0FF8
  B944  e258       ld A,(DE)
  B946  f22c00     ld (DE),$00
  B949  2c1cc0     ld ($1C),$C0
  B94C  2c1cd0     ld ($1C),$D0
  B94F  d8da       test ($DA).0
  B951  a3         jrs F,LB956
  B952  4b7c       clr ($7C).3
  B954  fb02       jr LB958
LB956:
  B956  437c       set ($7C).3
LB958:
  B958  227c       ld A,($7C)
  B95A  d971       test ($71).1
  B95C  81         jrs T,LB95F
  B95D  74df       and A,$DF
LB95F:
  B95F  d87c       test ($7C).0
  B961  84         jrs T,LB967
  B962  d9d9       test ($D9).1
  B964  81         jrs T,LB967
  B965  74fe       and A,$FE
LB967:
  B967  dbd9       test ($D9).3
  B969  84         jrs T,LB96F
  B96A  d9da       test ($DA).1
  B96C  a1         jrs F,LB96F
  B96D  74bf       and A,$BF
LB96F:
  B96F  5b         ld B,A
  B970  fcb4b9     call SB9B4
  B973  16f80f     ld DE,$0FF8
  B976  e258       ld A,(DE)
  B978  f22c00     ld (DE),$00
  B97B  2c1cc0     ld ($1C),$C0
  B97E  2c1cd0     ld ($1C),$D0
  B981  fe91b6     jp LB691
  B984  db 1D E9 1E 1D E9 1E 1D E9 1E 1D E9 1E 1D E9 1E 1D
  B994  db E9 1E 1D E9 1E 1D E9 1E 51 05
V_FFEA:
  B99E  2c1cc0     ld ($1C),$C0
  B9A1  2c1b14     ld ($1B),$14
  B9A4  48d9       clr ($D9).0
  B9A6  2c2267     ld ($22),$67
  B9A9  2c2300     ld ($23),$00
  B9AC  2c22a7     ld ($22),$A7
  B9AF  47da       set ($DA).7
  B9B1  4fd9       clr ($D9).7
  B9B3  04         reti
SB9B4:
  B9B4  40d9       set ($D9).0
  B9B6  eb06       pop HL
  B9B8  f0d713     ld ($D7),HL
  B9BB  e0f017     ld HL,($F0)
  B9BE  f03a13     ld ($3A),HL
  B9C1  04         reti
SB9C2:
  B9C2  174002     ld HL,$0240
  B9C5  e227       ld (HL),(DE)
  B9C7  13         inc HL
  B9C8  12         inc DE
  B9C9  e227       ld (HL),(DE)
  B9CB  13         inc HL
  B9CC  12         inc DE
  B9CD  e227       ld (HL),(DE)
  B9CF  13         inc HL
  B9D0  12         inc DE
  B9D1  e227       ld (HL),(DE)
  B9D3  13         inc HL
  B9D4  12         inc DE
  B9D5  e227       ld (HL),(DE)
  B9D7  13         inc HL
  B9D8  12         inc DE
  B9D9  e227       ld (HL),(DE)
  B9DB  13         inc HL
  B9DC  12         inc DE
  B9DD  e227       ld (HL),(DE)
  B9DF  13         inc HL
  B9E0  12         inc DE
  B9E1  e227       ld (HL),(DE)
  B9E3  13         inc HL
  B9E4  12         inc DE
  B9E5  e227       ld (HL),(DE)
  B9E7  13         inc HL
  B9E8  12         inc DE
  B9E9  e227       ld (HL),(DE)
  B9EB  13         inc HL
  B9EC  12         inc DE
  B9ED  e227       ld (HL),(DE)
  B9EF  13         inc HL
  B9F0  12         inc DE
  B9F1  e227       ld (HL),(DE)
  B9F3  13         inc HL
  B9F4  12         inc DE
  B9F5  e227       ld (HL),(DE)
  B9F7  13         inc HL
  B9F8  12         inc DE
  B9F9  e227       ld (HL),(DE)
  B9FB  13         inc HL
  B9FC  12         inc DE
  B9FD  e227       ld (HL),(DE)
  B9FF  13         inc HL
  BA00  12         inc DE
  BA01  e227       ld (HL),(DE)
  BA03  13         inc HL
  BA04  12         inc DE
  BA05  e227       ld (HL),(DE)
  BA07  13         inc HL
  BA08  12         inc DE
  BA09  e227       ld (HL),(DE)
  BA0B  13         inc HL
  BA0C  12         inc DE
  BA0D  e227       ld (HL),(DE)
  BA0F  13         inc HL
  BA10  12         inc DE
  BA11  e227       ld (HL),(DE)
  BA13  13         inc HL
  BA14  12         inc DE
  BA15  e227       ld (HL),(DE)
  BA17  13         inc HL
  BA18  12         inc DE
  BA19  e227       ld (HL),(DE)
  BA1B  13         inc HL
  BA1C  12         inc DE
  BA1D  e227       ld (HL),(DE)
  BA1F  13         inc HL
  BA20  12         inc DE
  BA21  e227       ld (HL),(DE)
  BA23  13         inc HL
  BA24  12         inc DE
  BA25  e227       ld (HL),(DE)
  BA27  13         inc HL
  BA28  12         inc DE
  BA29  e227       ld (HL),(DE)
  BA2B  13         inc HL
  BA2C  12         inc DE
  BA2D  e227       ld (HL),(DE)
  BA2F  13         inc HL
  BA30  12         inc DE
  BA31  e227       ld (HL),(DE)
  BA33  13         inc HL
  BA34  12         inc DE
  BA35  e227       ld (HL),(DE)
  BA37  13         inc HL
  BA38  12         inc DE
  BA39  e227       ld (HL),(DE)
  BA3B  13         inc HL
  BA3C  12         inc DE
  BA3D  e227       ld (HL),(DE)
  BA3F  13         inc HL
  BA40  12         inc DE
  BA41  e227       ld (HL),(DE)
  BA43  12         inc DE
  BA44  ea3f4002   cmp DE,$0240
  BA48  d203       jr CS,LBA4D
  BA4A  160001     ld DE,$0100
LBA4D:
  BA4D  f07612     ld ($76),DE
  BA50  05         ret
SBA51:
  BA51  178700     ld HL,$0087
  BA54  164002     ld DE,$0240
  BA57  3007       ld A,$07
  BA59  e0825a     ld C,($82)
  BA5C  ea63       sub A,C
  BA5E  e89e       test (DE).A
  BA60  e3c8       ld (HL).0,CF
  BA62  12         inc DE
  BA63  e89e       test (DE).A
  BA65  e6c9       ld (HL+).1,CF
  BA67  12         inc DE
  BA68  e89e       test (DE).A
  BA6A  e3c8       ld (HL).0,CF
  BA6C  12         inc DE
  BA6D  e89e       test (DE).A
  BA6F  e6c9       ld (HL+).1,CF
  BA71  12         inc DE
  BA72  e89e       test (DE).A
  BA74  e3c8       ld (HL).0,CF
  BA76  12         inc DE
  BA77  e89e       test (DE).A
  BA79  e6c9       ld (HL+).1,CF
  BA7B  12         inc DE
  BA7C  e89e       test (DE).A
  BA7E  e3c8       ld (HL).0,CF
  BA80  12         inc DE
  BA81  e89e       test (DE).A
  BA83  e6c9       ld (HL+).1,CF
  BA85  12         inc DE
  BA86  e89e       test (DE).A
  BA88  e3c8       ld (HL).0,CF
  BA8A  12         inc DE
  BA8B  e89e       test (DE).A
  BA8D  e6c9       ld (HL+).1,CF
  BA8F  12         inc DE
  BA90  e89e       test (DE).A
  BA92  e3c8       ld (HL).0,CF
  BA94  12         inc DE
  BA95  e89e       test (DE).A
  BA97  e6c9       ld (HL+).1,CF
  BA99  12         inc DE
  BA9A  e89e       test (DE).A
  BA9C  e3c8       ld (HL).0,CF
  BA9E  12         inc DE
  BA9F  e89e       test (DE).A
  BAA1  e6c9       ld (HL+).1,CF
  BAA3  12         inc DE
  BAA4  e89e       test (DE).A
  BAA6  e3c8       ld (HL).0,CF
  BAA8  12         inc DE
  BAA9  e89e       test (DE).A
  BAAB  e6c9       ld (HL+).1,CF
  BAAD  12         inc DE
  BAAE  e89e       test (DE).A
  BAB0  e3c8       ld (HL).0,CF
  BAB2  12         inc DE
  BAB3  e89e       test (DE).A
  BAB5  e6c9       ld (HL+).1,CF
  BAB7  12         inc DE
  BAB8  e89e       test (DE).A
  BABA  e3c8       ld (HL).0,CF
  BABC  12         inc DE
  BABD  e89e       test (DE).A
  BABF  e6c9       ld (HL+).1,CF
  BAC1  12         inc DE
  BAC2  e89e       test (DE).A
  BAC4  e3c8       ld (HL).0,CF
  BAC6  12         inc DE
  BAC7  e89e       test (DE).A
  BAC9  e6c9       ld (HL+).1,CF
  BACB  12         inc DE
  BACC  e89e       test (DE).A
  BACE  e3c8       ld (HL).0,CF
  BAD0  12         inc DE
  BAD1  e89e       test (DE).A
  BAD3  e6c9       ld (HL+).1,CF
  BAD5  12         inc DE
  BAD6  e89e       test (DE).A
  BAD8  e3c8       ld (HL).0,CF
  BADA  12         inc DE
  BADB  e89e       test (DE).A
  BADD  e6c9       ld (HL+).1,CF
  BADF  12         inc DE
  BAE0  e89e       test (DE).A
  BAE2  e3c8       ld (HL).0,CF
  BAE4  12         inc DE
  BAE5  e89e       test (DE).A
  BAE7  e6c9       ld (HL+).1,CF
  BAE9  12         inc DE
  BAEA  e89e       test (DE).A
  BAEC  e3c8       ld (HL).0,CF
  BAEE  12         inc DE
  BAEF  e89e       test (DE).A
  BAF1  e6c9       ld (HL+).1,CF
  BAF3  12         inc DE
  BAF4  e89e       test (DE).A
  BAF6  e3c8       ld (HL).0,CF
  BAF8  12         inc DE
  BAF9  e89e       test (DE).A
  BAFB  e3c9       ld (HL).1,CF
  BAFD  22ff       ld A,($FF)
  BAFF  d037       jr Z,LBB38
  BB01  74c0       and A,$C0
  BB03  01         swap A
  BB04  1d         shrc A
  BB05  1d         shrc A
  BB06  5b         ld B,A
  BB07  22ff       ld A,($FF)
  BB09  7430       and A,$30
  BB0B  01         swap A
  BB0C  5a         ld C,A
  BB0D  22ff       ld A,($FF)
  BB0F  740c       and A,$0C
  BB11  1d         shrc A
  BB12  1d         shrc A
  BB13  5d         ld D,A
  BB14  e0ff5c     ld E,($FF)
  BB17  ec7403     and E,$03
  BB1A  178700     ld HL,$0087
LBB1D:
  BB1D  23         ld A,(HL)
  BB1E  7703       cmp A,$03
  BB20  a2         jrs F,LBB24
  BB21  f653       ld (HL+),B
  BB23  8d         jrs T,LBB32
LBB24:
  BB24  7702       cmp A,$02
  BB26  a2         jrs F,LBB2A
  BB27  f652       ld (HL+),C
  BB29  87         jrs T,LBB32
LBB2A:
  BB2A  7701       cmp A,$01
  BB2C  a2         jrs F,LBB30
  BB2D  f655       ld (HL+),D
  BB2F  81         jrs T,LBB32
LBB30:
  BB30  f654       ld (HL+),E
LBB32:
  BB32  eb3f9600   cmp HL,$0096
  BB36  d4e5       jr LE,LBB1D
LBB38:
  BB38  05         ret
SBB39:
  BB39  17b6cc     ld HL,$CCB6
  BB3C  2287       ld A,($87)
  BB3E  e0a708     rold A,($A7)
  BB41  e0a75a     ld C,($A7)
  BB44  e52697     ld ($97),(HL+C)
  BB47  2288       ld A,($88)
  BB49  e0a808     rold A,($A8)
  BB4C  e0a85a     ld C,($A8)
  BB4F  e52698     ld ($98),(HL+C)
  BB52  2289       ld A,($89)
  BB54  e0a908     rold A,($A9)
  BB57  e0a95a     ld C,($A9)
  BB5A  e52699     ld ($99),(HL+C)
  BB5D  228a       ld A,($8A)
  BB5F  e0aa08     rold A,($AA)
  BB62  e0aa5a     ld C,($AA)
  BB65  e5269a     ld ($9A),(HL+C)
  BB68  228b       ld A,($8B)
  BB6A  e0ab08     rold A,($AB)
  BB6D  e0ab5a     ld C,($AB)
  BB70  e5269b     ld ($9B),(HL+C)
  BB73  228c       ld A,($8C)
  BB75  e0ac08     rold A,($AC)
  BB78  e0ac5a     ld C,($AC)
  BB7B  e5269c     ld ($9C),(HL+C)
  BB7E  228d       ld A,($8D)
  BB80  e0ad08     rold A,($AD)
  BB83  e0ad5a     ld C,($AD)
  BB86  e5269d     ld ($9D),(HL+C)
  BB89  228e       ld A,($8E)
  BB8B  e0ae08     rold A,($AE)
  BB8E  e0ae5a     ld C,($AE)
  BB91  e5269e     ld ($9E),(HL+C)
  BB94  228f       ld A,($8F)
  BB96  e0af08     rold A,($AF)
  BB99  e0af5a     ld C,($AF)
  BB9C  e5269f     ld ($9F),(HL+C)
  BB9F  2290       ld A,($90)
  BBA1  e0b008     rold A,($B0)
  BBA4  e0b05a     ld C,($B0)
  BBA7  e526a0     ld ($A0),(HL+C)
  BBAA  2291       ld A,($91)
  BBAC  e0b108     rold A,($B1)
  BBAF  e0b15a     ld C,($B1)
  BBB2  e526a1     ld ($A1),(HL+C)
  BBB5  2292       ld A,($92)
  BBB7  e0b208     rold A,($B2)
  BBBA  e0b25a     ld C,($B2)
  BBBD  e526a2     ld ($A2),(HL+C)
  BBC0  2293       ld A,($93)
  BBC2  e0b308     rold A,($B3)
  BBC5  e0b35a     ld C,($B3)
  BBC8  e526a3     ld ($A3),(HL+C)
  BBCB  2294       ld A,($94)
  BBCD  e0b408     rold A,($B4)
  BBD0  e0b45a     ld C,($B4)
  BBD3  e526a4     ld ($A4),(HL+C)
  BBD6  2295       ld A,($95)
  BBD8  e0b508     rold A,($B5)
  BBDB  e0b55a     ld C,($B5)
  BBDE  e526a5     ld ($A5),(HL+C)
  BBE1  2296       ld A,($96)
  BBE3  e0b608     rold A,($B6)
  BBE6  e0b65a     ld C,($B6)
  BBE9  e526a6     ld ($A6),(HL+C)
  BBEC  05         ret
SBBED:
  BBED  2282       ld A,($82)
  BBEF  01         swap A
  BBF0  3100       ld W,$00
  BBF2  ea31       add WA,DE
  BBF4  e816       ld DE,WA
  BBF6  2287       ld A,($87)
  BBF8  1c         shlc A
  BBF9  5a         ld C,A
  BBFA  17b6be     ld HL,$BEB6
  BBFD  e517       ld HL,(HL+C)
  BBFF  2260       ld A,($60)
  BC01  3100       ld W,$00
  BC03  eb31       add WA,HL
  BC05  e817       ld HL,WA
  BC07  e09759     ld W,($97)
  BC0A  2278       ld A,($78)
  BC0C  e379       add A,(HL)
  BC0E  e8df       test A.7
  BC10  a8         jrs F,LBC1A
  BC11  e961       add A,W
  BC13  7764       cmp A,$64
  BC15  d408       jr LE,LBC1F
  BC17  3064       ld A,$64
  BC19  84         jrs T,LBC1F
LBC1A:
  BC1A  e961       add A,W
  BC1C  81         jrs T,LBC1F
  BC1D  3000       ld A,$00
LBC1F:
  BC1F  f250       ld (DE),A
  BC21  12         inc DE
  BC22  2288       ld A,($88)
  BC24  1c         shlc A
  BC25  5a         ld C,A
  BC26  17b6be     ld HL,$BEB6
  BC29  e517       ld HL,(HL+C)
  BC2B  2261       ld A,($61)
  BC2D  3100       ld W,$00
  BC2F  eb31       add WA,HL
  BC31  e817       ld HL,WA
  BC33  e09859     ld W,($98)
  BC36  2278       ld A,($78)
  BC38  e379       add A,(HL)
  BC3A  e8df       test A.7
  BC3C  a8         jrs F,LBC46
  BC3D  e961       add A,W
  BC3F  7764       cmp A,$64
  BC41  d408       jr LE,LBC4B
  BC43  3064       ld A,$64
  BC45  84         jrs T,LBC4B
LBC46:
  BC46  e961       add A,W
  BC48  81         jrs T,LBC4B
  BC49  3000       ld A,$00
LBC4B:
  BC4B  f250       ld (DE),A
  BC4D  12         inc DE
  BC4E  2289       ld A,($89)
  BC50  1c         shlc A
  BC51  5a         ld C,A
  BC52  17b6be     ld HL,$BEB6
  BC55  e517       ld HL,(HL+C)
  BC57  2262       ld A,($62)
  BC59  3100       ld W,$00
  BC5B  eb31       add WA,HL
  BC5D  e817       ld HL,WA
  BC5F  e09959     ld W,($99)
  BC62  2278       ld A,($78)
  BC64  e379       add A,(HL)
  BC66  e8df       test A.7
  BC68  a8         jrs F,LBC72
  BC69  e961       add A,W
  BC6B  7764       cmp A,$64
  BC6D  d408       jr LE,LBC77
  BC6F  3064       ld A,$64
  BC71  84         jrs T,LBC77
LBC72:
  BC72  e961       add A,W
  BC74  81         jrs T,LBC77
  BC75  3000       ld A,$00
LBC77:
  BC77  f250       ld (DE),A
  BC79  12         inc DE
  BC7A  228a       ld A,($8A)
  BC7C  1c         shlc A
  BC7D  5a         ld C,A
  BC7E  17b6be     ld HL,$BEB6
  BC81  e517       ld HL,(HL+C)
  BC83  2263       ld A,($63)
  BC85  3100       ld W,$00
  BC87  eb31       add WA,HL
  BC89  e817       ld HL,WA
  BC8B  e09a59     ld W,($9A)
  BC8E  2278       ld A,($78)
  BC90  e379       add A,(HL)
  BC92  e8df       test A.7
  BC94  a8         jrs F,LBC9E
  BC95  e961       add A,W
  BC97  7764       cmp A,$64
  BC99  d408       jr LE,LBCA3
  BC9B  3064       ld A,$64
  BC9D  84         jrs T,LBCA3
LBC9E:
  BC9E  e961       add A,W
  BCA0  81         jrs T,LBCA3
  BCA1  3000       ld A,$00
LBCA3:
  BCA3  f250       ld (DE),A
  BCA5  12         inc DE
  BCA6  228b       ld A,($8B)
  BCA8  1c         shlc A
  BCA9  5a         ld C,A
  BCAA  17b6be     ld HL,$BEB6
  BCAD  e517       ld HL,(HL+C)
  BCAF  2264       ld A,($64)
  BCB1  3100       ld W,$00
  BCB3  eb31       add WA,HL
  BCB5  e817       ld HL,WA
  BCB7  e09b59     ld W,($9B)
  BCBA  2278       ld A,($78)
  BCBC  e379       add A,(HL)
  BCBE  e8df       test A.7
  BCC0  a8         jrs F,LBCCA
  BCC1  e961       add A,W
  BCC3  7764       cmp A,$64
  BCC5  d408       jr LE,LBCCF
  BCC7  3064       ld A,$64
  BCC9  84         jrs T,LBCCF
LBCCA:
  BCCA  e961       add A,W
  BCCC  81         jrs T,LBCCF
  BCCD  3000       ld A,$00
LBCCF:
  BCCF  f250       ld (DE),A
  BCD1  12         inc DE
  BCD2  228c       ld A,($8C)
  BCD4  1c         shlc A
  BCD5  5a         ld C,A
  BCD6  17b6be     ld HL,$BEB6
  BCD9  e517       ld HL,(HL+C)
  BCDB  2265       ld A,($65)
  BCDD  3100       ld W,$00
  BCDF  eb31       add WA,HL
  BCE1  e817       ld HL,WA
  BCE3  e09c59     ld W,($9C)
  BCE6  2278       ld A,($78)
  BCE8  e379       add A,(HL)
  BCEA  e8df       test A.7
  BCEC  a8         jrs F,LBCF6
  BCED  e961       add A,W
  BCEF  7764       cmp A,$64
  BCF1  d408       jr LE,LBCFB
  BCF3  3064       ld A,$64
  BCF5  84         jrs T,LBCFB
LBCF6:
  BCF6  e961       add A,W
  BCF8  81         jrs T,LBCFB
  BCF9  3000       ld A,$00
LBCFB:
  BCFB  f250       ld (DE),A
  BCFD  12         inc DE
  BCFE  228d       ld A,($8D)
  BD00  1c         shlc A
  BD01  5a         ld C,A
  BD02  17b6be     ld HL,$BEB6
  BD05  e517       ld HL,(HL+C)
  BD07  2266       ld A,($66)
  BD09  3100       ld W,$00
  BD0B  eb31       add WA,HL
  BD0D  e817       ld HL,WA
  BD0F  e09d59     ld W,($9D)
  BD12  2278       ld A,($78)
  BD14  e379       add A,(HL)
  BD16  e8df       test A.7
  BD18  a8         jrs F,LBD22
  BD19  e961       add A,W
  BD1B  7764       cmp A,$64
  BD1D  d408       jr LE,LBD27
  BD1F  3064       ld A,$64
  BD21  84         jrs T,LBD27
LBD22:
  BD22  e961       add A,W
  BD24  81         jrs T,LBD27
  BD25  3000       ld A,$00
LBD27:
  BD27  f250       ld (DE),A
  BD29  12         inc DE
  BD2A  228e       ld A,($8E)
  BD2C  1c         shlc A
  BD2D  5a         ld C,A
  BD2E  17b6be     ld HL,$BEB6
  BD31  e517       ld HL,(HL+C)
  BD33  2267       ld A,($67)
  BD35  3100       ld W,$00
  BD37  eb31       add WA,HL
  BD39  e817       ld HL,WA
  BD3B  e09e59     ld W,($9E)
  BD3E  2278       ld A,($78)
  BD40  e379       add A,(HL)
  BD42  e8df       test A.7
  BD44  a8         jrs F,LBD4E
  BD45  e961       add A,W
  BD47  7764       cmp A,$64
  BD49  d408       jr LE,LBD53
  BD4B  3064       ld A,$64
  BD4D  84         jrs T,LBD53
LBD4E:
  BD4E  e961       add A,W
  BD50  81         jrs T,LBD53
  BD51  3000       ld A,$00
LBD53:
  BD53  f250       ld (DE),A
  BD55  12         inc DE
  BD56  228f       ld A,($8F)
  BD58  1c         shlc A
  BD59  5a         ld C,A
  BD5A  17b6be     ld HL,$BEB6
  BD5D  e517       ld HL,(HL+C)
  BD5F  2268       ld A,($68)
  BD61  3100       ld W,$00
  BD63  eb31       add WA,HL
  BD65  e817       ld HL,WA
  BD67  e09f59     ld W,($9F)
  BD6A  2278       ld A,($78)
  BD6C  e379       add A,(HL)
  BD6E  e8df       test A.7
  BD70  a8         jrs F,LBD7A
  BD71  e961       add A,W
  BD73  7764       cmp A,$64
  BD75  d408       jr LE,LBD7F
  BD77  3064       ld A,$64
  BD79  84         jrs T,LBD7F
LBD7A:
  BD7A  e961       add A,W
  BD7C  81         jrs T,LBD7F
  BD7D  3000       ld A,$00
LBD7F:
  BD7F  f250       ld (DE),A
  BD81  12         inc DE
  BD82  2290       ld A,($90)
  BD84  1c         shlc A
  BD85  5a         ld C,A
  BD86  17b6be     ld HL,$BEB6
  BD89  e517       ld HL,(HL+C)
  BD8B  2269       ld A,($69)
  BD8D  3100       ld W,$00
  BD8F  eb31       add WA,HL
  BD91  e817       ld HL,WA
  BD93  e0a059     ld W,($A0)
  BD96  2278       ld A,($78)
  BD98  e379       add A,(HL)
  BD9A  e8df       test A.7
  BD9C  a8         jrs F,LBDA6
  BD9D  e961       add A,W
  BD9F  7764       cmp A,$64
  BDA1  d408       jr LE,LBDAB
  BDA3  3064       ld A,$64
  BDA5  84         jrs T,LBDAB
LBDA6:
  BDA6  e961       add A,W
  BDA8  81         jrs T,LBDAB
  BDA9  3000       ld A,$00
LBDAB:
  BDAB  f250       ld (DE),A
  BDAD  12         inc DE
  BDAE  2291       ld A,($91)
  BDB0  1c         shlc A
  BDB1  5a         ld C,A
  BDB2  17b6be     ld HL,$BEB6
  BDB5  e517       ld HL,(HL+C)
  BDB7  226a       ld A,($6A)
  BDB9  3100       ld W,$00
  BDBB  eb31       add WA,HL
  BDBD  e817       ld HL,WA
  BDBF  e0a159     ld W,($A1)
  BDC2  2278       ld A,($78)
  BDC4  e379       add A,(HL)
  BDC6  e8df       test A.7
  BDC8  a8         jrs F,LBDD2
  BDC9  e961       add A,W
  BDCB  7764       cmp A,$64
  BDCD  d408       jr LE,LBDD7
  BDCF  3064       ld A,$64
  BDD1  84         jrs T,LBDD7
LBDD2:
  BDD2  e961       add A,W
  BDD4  81         jrs T,LBDD7
  BDD5  3000       ld A,$00
LBDD7:
  BDD7  f250       ld (DE),A
  BDD9  12         inc DE
  BDDA  2292       ld A,($92)
  BDDC  1c         shlc A
  BDDD  5a         ld C,A
  BDDE  17b6be     ld HL,$BEB6
  BDE1  e517       ld HL,(HL+C)
  BDE3  226b       ld A,($6B)
  BDE5  3100       ld W,$00
  BDE7  eb31       add WA,HL
  BDE9  e817       ld HL,WA
  BDEB  e0a259     ld W,($A2)
  BDEE  2278       ld A,($78)
  BDF0  e379       add A,(HL)
  BDF2  e8df       test A.7
  BDF4  a8         jrs F,LBDFE
  BDF5  e961       add A,W
  BDF7  7764       cmp A,$64
  BDF9  d408       jr LE,LBE03
  BDFB  3064       ld A,$64
  BDFD  84         jrs T,LBE03
LBDFE:
  BDFE  e961       add A,W
  BE00  81         jrs T,LBE03
  BE01  3000       ld A,$00
LBE03:
  BE03  f250       ld (DE),A
  BE05  12         inc DE
  BE06  2293       ld A,($93)
  BE08  1c         shlc A
  BE09  5a         ld C,A
  BE0A  17b6be     ld HL,$BEB6
  BE0D  e517       ld HL,(HL+C)
  BE0F  226c       ld A,($6C)
  BE11  3100       ld W,$00
  BE13  eb31       add WA,HL
  BE15  e817       ld HL,WA
  BE17  e0a359     ld W,($A3)
  BE1A  2278       ld A,($78)
  BE1C  e379       add A,(HL)
  BE1E  e8df       test A.7
  BE20  a8         jrs F,LBE2A
  BE21  e961       add A,W
  BE23  7764       cmp A,$64
  BE25  d408       jr LE,LBE2F
  BE27  3064       ld A,$64
  BE29  84         jrs T,LBE2F
LBE2A:
  BE2A  e961       add A,W
  BE2C  81         jrs T,LBE2F
  BE2D  3000       ld A,$00
LBE2F:
  BE2F  f250       ld (DE),A
  BE31  12         inc DE
  BE32  2294       ld A,($94)
  BE34  1c         shlc A
  BE35  5a         ld C,A
  BE36  17b6be     ld HL,$BEB6
  BE39  e517       ld HL,(HL+C)
  BE3B  226d       ld A,($6D)
  BE3D  3100       ld W,$00
  BE3F  eb31       add WA,HL
  BE41  e817       ld HL,WA
  BE43  e0a459     ld W,($A4)
  BE46  2278       ld A,($78)
  BE48  e379       add A,(HL)
  BE4A  e8df       test A.7
  BE4C  a8         jrs F,LBE56
  BE4D  e961       add A,W
  BE4F  7764       cmp A,$64
  BE51  d408       jr LE,LBE5B
  BE53  3064       ld A,$64
  BE55  84         jrs T,LBE5B
LBE56:
  BE56  e961       add A,W
  BE58  81         jrs T,LBE5B
  BE59  3000       ld A,$00
LBE5B:
  BE5B  f250       ld (DE),A
  BE5D  12         inc DE
  BE5E  2295       ld A,($95)
  BE60  1c         shlc A
  BE61  5a         ld C,A
  BE62  17b6be     ld HL,$BEB6
  BE65  e517       ld HL,(HL+C)
  BE67  226e       ld A,($6E)
  BE69  3100       ld W,$00
  BE6B  eb31       add WA,HL
  BE6D  e817       ld HL,WA
  BE6F  e0a559     ld W,($A5)
  BE72  2278       ld A,($78)
  BE74  e379       add A,(HL)
  BE76  e8df       test A.7
  BE78  a8         jrs F,LBE82
  BE79  e961       add A,W
  BE7B  7764       cmp A,$64
  BE7D  d408       jr LE,LBE87
  BE7F  3064       ld A,$64
  BE81  84         jrs T,LBE87
LBE82:
  BE82  e961       add A,W
  BE84  81         jrs T,LBE87
  BE85  3000       ld A,$00
LBE87:
  BE87  f250       ld (DE),A
  BE89  12         inc DE
  BE8A  2296       ld A,($96)
  BE8C  1c         shlc A
  BE8D  5a         ld C,A
  BE8E  17b6be     ld HL,$BEB6
  BE91  e517       ld HL,(HL+C)
  BE93  226f       ld A,($6F)
  BE95  3100       ld W,$00
  BE97  eb31       add WA,HL
  BE99  e817       ld HL,WA
  BE9B  e0a659     ld W,($A6)
  BE9E  2278       ld A,($78)
  BEA0  e379       add A,(HL)
  BEA2  e8df       test A.7
  BEA4  a8         jrs F,LBEAE
  BEA5  e961       add A,W
  BEA7  7764       cmp A,$64
  BEA9  d408       jr LE,LBEB3
  BEAB  3064       ld A,$64
  BEAD  84         jrs T,LBEB3
LBEAE:
  BEAE  e961       add A,W
  BEB0  81         jrs T,LBEB3
  BEB1  3000       ld A,$00
LBEB3:
  BEB3  f250       ld (DE),A
  BEB5  05         ret
  BEB6  db 76 D4 76 D5 76 D6 76 D7
SBEBE:
  BEBE  e258       ld A,(DE)
  BEC0  1c         shlc A
  BEC1  12         inc DE
  BEC2  5e         ld L,A
  BEC3  3700       ld H,$00
  BEC5  eb39f6cc   add HL,$CCF6
  BEC9  e658       ld A,(HL+)
  BECB  e35a       ld C,(HL)
  BECD  3100       ld W,$00
  BECF  e8396003   add WA,$0360
  BED3  e817       ld HL,WA
  BED5  52         ld A,C
  BED6  1c         shlc A
  BED7  e1fe       jp (PC+A)
  BED9  dw JCAE0
  BEDB  dw JCADE
  BEDD  dw JCADC
  BEDF  dw JCADA
  BEE1  dw JCAD8
  BEE3  dw JCAD6
  BEE5  dw JCAD4
  BEE7  dw JCAD2
  BEE9  dw JCAD0
  BEEB  dw JCACE
  BEED  dw JCACC
  BEEF  dw JCACA
  BEF1  dw JCAC8
  BEF3  dw JCAC6
  BEF5  dw JCAC4
  BEF7  dw JCAC2
  BEF9  dw JCAC0
  BEFB  dw JCABE
  BEFD  dw JCABC
  BEFF  dw JCABA
  BF01  dw JCAB8
  BF03  dw JCAB6
  BF05  dw JCAB4
  BF07  dw JCAB2
  BF09  dw JCAB0
  BF0B  dw JCAAE
  BF0D  dw JCAAC
  BF0F  dw JCAAA
  BF11  dw JCAA8
  BF13  dw JCAA6
  BF15  dw JCAA4
  BF17  dw JCAA2
  BF19  dw JCAA0
  BF1B  dw JCA9E
SBF1D:
  BF1D  e258       ld A,(DE)
  BF1F  1c         shlc A
  BF20  12         inc DE
  BF21  5e         ld L,A
  BF22  3700       ld H,$00
  BF24  eb39f6cc   add HL,$CCF6
  BF28  e658       ld A,(HL+)
  BF2A  e35a       ld C,(HL)
  BF2C  3100       ld W,$00
  BF2E  e8396003   add WA,$0360
  BF32  e817       ld HL,WA
  BF34  52         ld A,C
  BF35  1c         shlc A
  BF36  e1fe       jp (PC+A)
  BF38  dw JCB23
  BF3A  dw JCB21
  BF3C  dw JCB1F
  BF3E  dw JCB1D
  BF40  dw JCB1B
  BF42  dw JCB19
  BF44  dw JCB17
  BF46  dw JCB15
  BF48  dw JCB13
  BF4A  dw JCB11
  BF4C  dw JCB0F
  BF4E  dw JCB0D
  BF50  dw JCB0B
  BF52  dw JCB09
  BF54  dw JCB07
  BF56  dw JCB05
  BF58  dw JCB03
  BF5A  dw JCB01
  BF5C  dw JCAFF
  BF5E  dw JCAFD
  BF60  dw JCAFB
  BF62  dw JCAF9
  BF64  dw JCAF7
  BF66  dw JCAF5
  BF68  dw JCAF3
  BF6A  dw JCAF1
  BF6C  dw JCAEF
  BF6E  dw JCAED
  BF70  dw JCAEB
  BF72  dw JCAE9
  BF74  dw JCAE7
  BF76  dw JCAE5
  BF78  dw JCAE3
  BF7A  dw JCAE1
SBF7C:
  BF7C  e258       ld A,(DE)
  BF7E  1c         shlc A
  BF7F  12         inc DE
  BF80  5e         ld L,A
  BF81  3700       ld H,$00
  BF83  eb39f6cc   add HL,$CCF6
  BF87  e658       ld A,(HL+)
  BF89  e35a       ld C,(HL)
  BF8B  3100       ld W,$00
  BF8D  e8396003   add WA,$0360
  BF91  e817       ld HL,WA
  BF93  52         ld A,C
  BF94  1c         shlc A
  BF95  e1fe       jp (PC+A)
  BF97  dw JCB66
  BF99  dw JCB64
  BF9B  dw JCB62
  BF9D  dw JCB60
  BF9F  dw JCB5E
  BFA1  dw JCB5C
  BFA3  dw JCB5A
  BFA5  dw JCB58
  BFA7  dw JCB56
  BFA9  dw JCB54
  BFAB  dw JCB52
  BFAD  dw JCB50
  BFAF  dw JCB4E
  BFB1  dw JCB4C
  BFB3  dw JCB4A
  BFB5  dw JCB48
  BFB7  dw JCB46
  BFB9  dw JCB44
  BFBB  dw JCB42
  BFBD  dw JCB40
  BFBF  dw JCB3E
  BFC1  dw JCB3C
  BFC3  dw JCB3A
  BFC5  dw JCB38
  BFC7  dw JCB36
  BFC9  dw JCB34
  BFCB  dw JCB32
  BFCD  dw JCB30
  BFCF  dw JCB2E
  BFD1  dw JCB2C
  BFD3  dw JCB2A
  BFD5  dw JCB28
  BFD7  dw JCB26
  BFD9  dw JCB24
SBFDB:
  BFDB  e258       ld A,(DE)
  BFDD  1c         shlc A
  BFDE  12         inc DE
  BFDF  5e         ld L,A
  BFE0  3700       ld H,$00
  BFE2  eb39f6cc   add HL,$CCF6
  BFE6  e658       ld A,(HL+)
  BFE8  e35a       ld C,(HL)
  BFEA  3100       ld W,$00
  BFEC  e8396003   add WA,$0360
  BFF0  e817       ld HL,WA
  BFF2  52         ld A,C
  BFF3  1c         shlc A
  BFF4  e1fe       jp (PC+A)
  BFF6  dw JCBA9
  BFF8  dw JCBA7
  BFFA  dw JCBA5
  BFFC  dw JCBA3
  BFFE  dw JCBA1
  C000  dw JCB9F
  C002  dw JCB9D
  C004  dw JCB9B
  C006  dw JCB99
  C008  dw JCB97
  C00A  dw JCB95
  C00C  dw JCB93
  C00E  dw JCB91
  C010  dw JCB8F
  C012  dw JCB8D
  C014  dw JCB8B
  C016  dw JCB89
  C018  dw JCB87
  C01A  dw JCB85
  C01C  dw JCB83
  C01E  dw JCB81
  C020  dw JCB7F
  C022  dw JCB7D
  C024  dw JCB7B
  C026  dw JCB79
  C028  dw JCB77
  C02A  dw JCB75
  C02C  dw JCB73
  C02E  dw JCB71
  C030  dw JCB6F
  C032  dw JCB6D
  C034  dw JCB6B
  C036  dw JCB69
  C038  dw JCB67
SC03A:
  C03A  e258       ld A,(DE)
  C03C  1c         shlc A
  C03D  12         inc DE
  C03E  5e         ld L,A
  C03F  3700       ld H,$00
  C041  eb39f6cc   add HL,$CCF6
  C045  e658       ld A,(HL+)
  C047  e35a       ld C,(HL)
  C049  3100       ld W,$00
  C04B  e8396003   add WA,$0360
  C04F  e817       ld HL,WA
  C051  52         ld A,C
  C052  1c         shlc A
  C053  e1fe       jp (PC+A)
  C055  dw JCBEC
  C057  dw JCBEA
  C059  dw JCBE8
  C05B  dw JCBE6
  C05D  dw JCBE4
  C05F  dw JCBE2
  C061  dw JCBE0
  C063  dw JCBDE
  C065  dw JCBDC
  C067  dw JCBDA
  C069  dw JCBD8
  C06B  dw JCBD6
  C06D  dw JCBD4
  C06F  dw JCBD2
  C071  dw JCBD0
  C073  dw JCBCE
  C075  dw JCBCC
  C077  dw JCBCA
  C079  dw JCBC8
  C07B  dw JCBC6
  C07D  dw JCBC4
  C07F  dw JCBC2
  C081  dw JCBC0
  C083  dw JCBBE
  C085  dw JCBBC
  C087  dw JCBBA
  C089  dw JCBB8
  C08B  dw JCBB6
  C08D  dw JCBB4
  C08F  dw JCBB2
  C091  dw JCBB0
  C093  dw JCBAE
  C095  dw JCBAC
  C097  dw JCBAA
SC099:
  C099  e258       ld A,(DE)
  C09B  1c         shlc A
  C09C  12         inc DE
  C09D  5e         ld L,A
  C09E  3700       ld H,$00
  C0A0  eb39f6cc   add HL,$CCF6
  C0A4  e658       ld A,(HL+)
  C0A6  e35a       ld C,(HL)
  C0A8  3100       ld W,$00
  C0AA  e8396003   add WA,$0360
  C0AE  e817       ld HL,WA
  C0B0  52         ld A,C
  C0B1  1c         shlc A
  C0B2  e1fe       jp (PC+A)
  C0B4  dw JCC2F
  C0B6  dw JCC2D
  C0B8  dw JCC2B
  C0BA  dw JCC29
  C0BC  dw JCC27
  C0BE  dw JCC25
  C0C0  dw JCC23
  C0C2  dw JCC21
  C0C4  dw JCC1F
  C0C6  dw JCC1D
  C0C8  dw JCC1B
  C0CA  dw JCC19
  C0CC  dw JCC17
  C0CE  dw JCC15
  C0D0  dw JCC13
  C0D2  dw JCC11
  C0D4  dw JCC0F
  C0D6  dw JCC0D
  C0D8  dw JCC0B
  C0DA  dw JCC09
  C0DC  dw JCC07
  C0DE  dw JCC05
  C0E0  dw JCC03
  C0E2  dw JCC01
  C0E4  dw JCBFF
  C0E6  dw JCBFD
  C0E8  dw JCBFB
  C0EA  dw JCBF9
  C0EC  dw JCBF7
  C0EE  dw JCBF5
  C0F0  dw JCBF3
  C0F2  dw JCBF1
  C0F4  dw JCBEF
  C0F6  dw JCBED
SC0F8:
  C0F8  e258       ld A,(DE)
  C0FA  1c         shlc A
  C0FB  12         inc DE
  C0FC  5e         ld L,A
  C0FD  3700       ld H,$00
  C0FF  eb39f6cc   add HL,$CCF6
  C103  e658       ld A,(HL+)
  C105  e35a       ld C,(HL)
  C107  3100       ld W,$00
  C109  e8396003   add WA,$0360
  C10D  e817       ld HL,WA
  C10F  52         ld A,C
  C110  1c         shlc A
  C111  e1fe       jp (PC+A)
  C113  dw JCC72
  C115  dw JCC70
  C117  dw JCC6E
  C119  dw JCC6C
  C11B  dw JCC6A
  C11D  dw JCC68
  C11F  dw JCC66
  C121  dw JCC64
  C123  dw JCC62
  C125  dw JCC60
  C127  dw JCC5E
  C129  dw JCC5C
  C12B  dw JCC5A
  C12D  dw JCC58
  C12F  dw JCC56
  C131  dw JCC54
  C133  dw JCC52
  C135  dw JCC50
  C137  dw JCC4E
  C139  dw JCC4C
  C13B  dw JCC4A
  C13D  dw JCC48
  C13F  dw JCC46
  C141  dw JCC44
  C143  dw JCC42
  C145  dw JCC40
  C147  dw JCC3E
  C149  dw JCC3C
  C14B  dw JCC3A
  C14D  dw JCC38
  C14F  dw JCC36
  C151  dw JCC34
  C153  dw JCC32
  C155  dw JCC30
SC157:
  C157  e258       ld A,(DE)
  C159  1c         shlc A
  C15A  12         inc DE
  C15B  5e         ld L,A
  C15C  3700       ld H,$00
  C15E  eb39f6cc   add HL,$CCF6
  C162  e658       ld A,(HL+)
  C164  e35a       ld C,(HL)
  C166  3100       ld W,$00
  C168  e8396003   add WA,$0360
  C16C  e817       ld HL,WA
  C16E  52         ld A,C
  C16F  1c         shlc A
  C170  e1fe       jp (PC+A)
  C172  dw JCCB5
  C174  dw JCCB3
  C176  dw JCCB1
  C178  dw JCCAF
  C17A  dw JCCAD
  C17C  dw JCCAB
  C17E  dw JCCA9
  C180  dw JCCA7
  C182  dw JCCA5
  C184  dw JCCA3
  C186  dw JCCA1
  C188  dw JCC9F
  C18A  dw JCC9D
  C18C  dw JCC9B
  C18E  dw JCC99
  C190  dw JCC97
  C192  dw JCC95
  C194  dw JCC93
  C196  dw JCC91
  C198  dw JCC8F
  C19A  dw JCC8D
  C19C  dw JCC8B
  C19E  dw JCC89
  C1A0  dw JCC87
  C1A2  dw JCC85
  C1A4  dw JCC83
  C1A6  dw JCC81
  C1A8  dw JCC7F
  C1AA  dw JCC7D
  C1AC  dw JCC7B
  C1AE  dw JCC79
  C1B0  dw JCC77
  C1B2  dw JCC75
  C1B4  dw JCC73
SC1B6:
  C1B6  e258       ld A,(DE)
  C1B8  1c         shlc A
  C1B9  12         inc DE
  C1BA  5e         ld L,A
  C1BB  3700       ld H,$00
  C1BD  eb39f6cc   add HL,$CCF6
  C1C1  e658       ld A,(HL+)
  C1C3  e35a       ld C,(HL)
  C1C5  3100       ld W,$00
  C1C7  e8398303   add WA,$0383
  C1CB  e817       ld HL,WA
  C1CD  52         ld A,C
  C1CE  1c         shlc A
  C1CF  e1fe       jp (PC+A)
  C1D1  dw JCAE0
  C1D3  dw JCADE
  C1D5  dw JCADC
  C1D7  dw JCADA
  C1D9  dw JCAD8
  C1DB  dw JCAD6
  C1DD  dw JCAD4
  C1DF  dw JCAD2
  C1E1  dw JCAD0
  C1E3  dw JCACE
  C1E5  dw JCACC
  C1E7  dw JCACA
  C1E9  dw JCAC8
  C1EB  dw JCAC6
  C1ED  dw JCAC4
  C1EF  dw JCAC2
  C1F1  dw JCAC0
  C1F3  dw JCABE
  C1F5  dw JCABC
  C1F7  dw JCABA
  C1F9  dw JCAB8
  C1FB  dw JCAB6
  C1FD  dw JCAB4
  C1FF  dw JCAB2
  C201  dw JCAB0
  C203  dw JCAAE
  C205  dw JCAAC
  C207  dw JCAAA
  C209  dw JCAA8
  C20B  dw JCAA6
  C20D  dw JCAA4
  C20F  dw JCAA2
  C211  dw JCAA0
  C213  dw JCA9E
SC215:
  C215  e258       ld A,(DE)
  C217  1c         shlc A
  C218  12         inc DE
  C219  5e         ld L,A
  C21A  3700       ld H,$00
  C21C  eb39f6cc   add HL,$CCF6
  C220  e658       ld A,(HL+)
  C222  e35a       ld C,(HL)
  C224  3100       ld W,$00
  C226  e8398303   add WA,$0383
  C22A  e817       ld HL,WA
  C22C  52         ld A,C
  C22D  1c         shlc A
  C22E  e1fe       jp (PC+A)
  C230  dw JCB23
  C232  dw JCB21
  C234  dw JCB1F
  C236  dw JCB1D
  C238  dw JCB1B
  C23A  dw JCB19
  C23C  dw JCB17
  C23E  dw JCB15
  C240  dw JCB13
  C242  dw JCB11
  C244  dw JCB0F
  C246  dw JCB0D
  C248  dw JCB0B
  C24A  dw JCB09
  C24C  dw JCB07
  C24E  dw JCB05
  C250  dw JCB03
  C252  dw JCB01
  C254  dw JCAFF
  C256  dw JCAFD
  C258  dw JCAFB
  C25A  dw JCAF9
  C25C  dw JCAF7
  C25E  dw JCAF5
  C260  dw JCAF3
  C262  dw JCAF1
  C264  dw JCAEF
  C266  dw JCAED
  C268  dw JCAEB
  C26A  dw JCAE9
  C26C  dw JCAE7
  C26E  dw JCAE5
  C270  dw JCAE3
  C272  dw JCAE1
SC274:
  C274  e258       ld A,(DE)
  C276  1c         shlc A
  C277  12         inc DE
  C278  5e         ld L,A
  C279  3700       ld H,$00
  C27B  eb39f6cc   add HL,$CCF6
  C27F  e658       ld A,(HL+)
  C281  e35a       ld C,(HL)
  C283  3100       ld W,$00
  C285  e8398303   add WA,$0383
  C289  e817       ld HL,WA
  C28B  52         ld A,C
  C28C  1c         shlc A
  C28D  e1fe       jp (PC+A)
  C28F  dw JCB66
  C291  dw JCB64
  C293  dw JCB62
  C295  dw JCB60
  C297  dw JCB5E
  C299  dw JCB5C
  C29B  dw JCB5A
  C29D  dw JCB58
  C29F  dw JCB56
  C2A1  dw JCB54
  C2A3  dw JCB52
  C2A5  dw JCB50
  C2A7  dw JCB4E
  C2A9  dw JCB4C
  C2AB  dw JCB4A
  C2AD  dw JCB48
  C2AF  dw JCB46
  C2B1  dw JCB44
  C2B3  dw JCB42
  C2B5  dw JCB40
  C2B7  dw JCB3E
  C2B9  dw JCB3C
  C2BB  dw JCB3A
  C2BD  dw JCB38
  C2BF  dw JCB36
  C2C1  dw JCB34
  C2C3  dw JCB32
  C2C5  dw JCB30
  C2C7  dw JCB2E
  C2C9  dw JCB2C
  C2CB  dw JCB2A
  C2CD  dw JCB28
  C2CF  dw JCB26
  C2D1  dw JCB24
SC2D3:
  C2D3  e258       ld A,(DE)
  C2D5  1c         shlc A
  C2D6  12         inc DE
  C2D7  5e         ld L,A
  C2D8  3700       ld H,$00
  C2DA  eb39f6cc   add HL,$CCF6
  C2DE  e658       ld A,(HL+)
  C2E0  e35a       ld C,(HL)
  C2E2  3100       ld W,$00
  C2E4  e8398303   add WA,$0383
  C2E8  e817       ld HL,WA
  C2EA  52         ld A,C
  C2EB  1c         shlc A
  C2EC  e1fe       jp (PC+A)
  C2EE  dw JCBA9
  C2F0  dw JCBA7
  C2F2  dw JCBA5
  C2F4  dw JCBA3
  C2F6  dw JCBA1
  C2F8  dw JCB9F
  C2FA  dw JCB9D
  C2FC  dw JCB9B
  C2FE  dw JCB99
  C300  dw JCB97
  C302  dw JCB95
  C304  dw JCB93
  C306  dw JCB91
  C308  dw JCB8F
  C30A  dw JCB8D
  C30C  dw JCB8B
  C30E  dw JCB89
  C310  dw JCB87
  C312  dw JCB85
  C314  dw JCB83
  C316  dw JCB81
  C318  dw JCB7F
  C31A  dw JCB7D
  C31C  dw JCB7B
  C31E  dw JCB79
  C320  dw JCB77
  C322  dw JCB75
  C324  dw JCB73
  C326  dw JCB71
  C328  dw JCB6F
  C32A  dw JCB6D
  C32C  dw JCB6B
  C32E  dw JCB69
  C330  dw JCB67
SC332:
  C332  e258       ld A,(DE)
  C334  1c         shlc A
  C335  12         inc DE
  C336  5e         ld L,A
  C337  3700       ld H,$00
  C339  eb39f6cc   add HL,$CCF6
  C33D  e658       ld A,(HL+)
  C33F  e35a       ld C,(HL)
  C341  3100       ld W,$00
  C343  e8398303   add WA,$0383
  C347  e817       ld HL,WA
  C349  52         ld A,C
  C34A  1c         shlc A
  C34B  e1fe       jp (PC+A)
  C34D  dw JCBEC
  C34F  dw JCBEA
  C351  dw JCBE8
  C353  dw JCBE6
  C355  dw JCBE4
  C357  dw JCBE2
  C359  dw JCBE0
  C35B  dw JCBDE
  C35D  dw JCBDC
  C35F  dw JCBDA
  C361  dw JCBD8
  C363  dw JCBD6
  C365  dw JCBD4
  C367  dw JCBD2
  C369  dw JCBD0
  C36B  dw JCBCE
  C36D  dw JCBCC
  C36F  dw JCBCA
  C371  dw JCBC8
  C373  dw JCBC6
  C375  dw JCBC4
  C377  dw JCBC2
  C379  dw JCBC0
  C37B  dw JCBBE
  C37D  dw JCBBC
  C37F  dw JCBBA
  C381  dw JCBB8
  C383  dw JCBB6
  C385  dw JCBB4
  C387  dw JCBB2
  C389  dw JCBB0
  C38B  dw JCBAE
  C38D  dw JCBAC
  C38F  dw JCBAA
SC391:
  C391  e258       ld A,(DE)
  C393  1c         shlc A
  C394  12         inc DE
  C395  5e         ld L,A
  C396  3700       ld H,$00
  C398  eb39f6cc   add HL,$CCF6
  C39C  e658       ld A,(HL+)
  C39E  e35a       ld C,(HL)
  C3A0  3100       ld W,$00
  C3A2  e8398303   add WA,$0383
  C3A6  e817       ld HL,WA
  C3A8  52         ld A,C
  C3A9  1c         shlc A
  C3AA  e1fe       jp (PC+A)
  C3AC  dw JCC2F
  C3AE  dw JCC2D
  C3B0  dw JCC2B
  C3B2  dw JCC29
  C3B4  dw JCC27
  C3B6  dw JCC25
  C3B8  dw JCC23
  C3BA  dw JCC21
  C3BC  dw JCC1F
  C3BE  dw JCC1D
  C3C0  dw JCC1B
  C3C2  dw JCC19
  C3C4  dw JCC17
  C3C6  dw JCC15
  C3C8  dw JCC13
  C3CA  dw JCC11
  C3CC  dw JCC0F
  C3CE  dw JCC0D
  C3D0  dw JCC0B
  C3D2  dw JCC09
  C3D4  dw JCC07
  C3D6  dw JCC05
  C3D8  dw JCC03
  C3DA  dw JCC01
  C3DC  dw JCBFF
  C3DE  dw JCBFD
  C3E0  dw JCBFB
  C3E2  dw JCBF9
  C3E4  dw JCBF7
  C3E6  dw JCBF5
  C3E8  dw JCBF3
  C3EA  dw JCBF1
  C3EC  dw JCBEF
  C3EE  dw JCBED
SC3F0:
  C3F0  e258       ld A,(DE)
  C3F2  1c         shlc A
  C3F3  12         inc DE
  C3F4  5e         ld L,A
  C3F5  3700       ld H,$00
  C3F7  eb39f6cc   add HL,$CCF6
  C3FB  e658       ld A,(HL+)
  C3FD  e35a       ld C,(HL)
  C3FF  3100       ld W,$00
  C401  e8398303   add WA,$0383
  C405  e817       ld HL,WA
  C407  52         ld A,C
  C408  1c         shlc A
  C409  e1fe       jp (PC+A)
  C40B  dw JCC72
  C40D  dw JCC70
  C40F  dw JCC6E
  C411  dw JCC6C
  C413  dw JCC6A
  C415  dw JCC68
  C417  dw JCC66
  C419  dw JCC64
  C41B  dw JCC62
  C41D  dw JCC60
  C41F  dw JCC5E
  C421  dw JCC5C
  C423  dw JCC5A
  C425  dw JCC58
  C427  dw JCC56
  C429  dw JCC54
  C42B  dw JCC52
  C42D  dw JCC50
  C42F  dw JCC4E
  C431  dw JCC4C
  C433  dw JCC4A
  C435  dw JCC48
  C437  dw JCC46
  C439  dw JCC44
  C43B  dw JCC42
  C43D  dw JCC40
  C43F  dw JCC3E
  C441  dw JCC3C
  C443  dw JCC3A
  C445  dw JCC38
  C447  dw JCC36
  C449  dw JCC34
  C44B  dw JCC32
  C44D  dw JCC30
SC44F:
  C44F  e258       ld A,(DE)
  C451  1c         shlc A
  C452  12         inc DE
  C453  5e         ld L,A
  C454  3700       ld H,$00
  C456  eb39f6cc   add HL,$CCF6
  C45A  e658       ld A,(HL+)
  C45C  e35a       ld C,(HL)
  C45E  3100       ld W,$00
  C460  e8398303   add WA,$0383
  C464  e817       ld HL,WA
  C466  52         ld A,C
  C467  1c         shlc A
  C468  e1fe       jp (PC+A)
  C46A  dw JCCB5
  C46C  dw JCCB3
  C46E  dw JCCB1
  C470  dw JCCAF
  C472  dw JCCAD
  C474  dw JCCAB
  C476  dw JCCA9
  C478  dw JCCA7
  C47A  dw JCCA5
  C47C  dw JCCA3
  C47E  dw JCCA1
  C480  dw JCC9F
  C482  dw JCC9D
  C484  dw JCC9B
  C486  dw JCC99
  C488  dw JCC97
  C48A  dw JCC95
  C48C  dw JCC93
  C48E  dw JCC91
  C490  dw JCC8F
  C492  dw JCC8D
  C494  dw JCC8B
  C496  dw JCC89
  C498  dw JCC87
  C49A  dw JCC85
  C49C  dw JCC83
  C49E  dw JCC81
  C4A0  dw JCC7F
  C4A2  dw JCC7D
  C4A4  dw JCC7B
  C4A6  dw JCC79
  C4A8  dw JCC77
  C4AA  dw JCC75
  C4AC  dw JCC73
SC4AE:
  C4AE  e258       ld A,(DE)
  C4B0  1c         shlc A
  C4B1  12         inc DE
  C4B2  5e         ld L,A
  C4B3  3700       ld H,$00
  C4B5  eb39f6cc   add HL,$CCF6
  C4B9  e658       ld A,(HL+)
  C4BB  e35a       ld C,(HL)
  C4BD  3100       ld W,$00
  C4BF  e839a603   add WA,$03A6
  C4C3  e817       ld HL,WA
  C4C5  52         ld A,C
  C4C6  1c         shlc A
  C4C7  e1fe       jp (PC+A)
  C4C9  dw JCAE0
  C4CB  dw JCADE
  C4CD  dw JCADC
  C4CF  dw JCADA
  C4D1  dw JCAD8
  C4D3  dw JCAD6
  C4D5  dw JCAD4
  C4D7  dw JCAD2
  C4D9  dw JCAD0
  C4DB  dw JCACE
  C4DD  dw JCACC
  C4DF  dw JCACA
  C4E1  dw JCAC8
  C4E3  dw JCAC6
  C4E5  dw JCAC4
  C4E7  dw JCAC2
  C4E9  dw JCAC0
  C4EB  dw JCABE
  C4ED  dw JCABC
  C4EF  dw JCABA
  C4F1  dw JCAB8
  C4F3  dw JCAB6
  C4F5  dw JCAB4
  C4F7  dw JCAB2
  C4F9  dw JCAB0
  C4FB  dw JCAAE
  C4FD  dw JCAAC
  C4FF  dw JCAAA
  C501  dw JCAA8
  C503  dw JCAA6
  C505  dw JCAA4
  C507  dw JCAA2
  C509  dw JCAA0
  C50B  dw JCA9E
SC50D:
  C50D  e258       ld A,(DE)
  C50F  1c         shlc A
  C510  12         inc DE
  C511  5e         ld L,A
  C512  3700       ld H,$00
  C514  eb39f6cc   add HL,$CCF6
  C518  e658       ld A,(HL+)
  C51A  e35a       ld C,(HL)
  C51C  3100       ld W,$00
  C51E  e839a603   add WA,$03A6
  C522  e817       ld HL,WA
  C524  52         ld A,C
  C525  1c         shlc A
  C526  e1fe       jp (PC+A)
  C528  dw JCB23
  C52A  dw JCB21
  C52C  dw JCB1F
  C52E  dw JCB1D
  C530  dw JCB1B
  C532  dw JCB19
  C534  dw JCB17
  C536  dw JCB15
  C538  dw JCB13
  C53A  dw JCB11
  C53C  dw JCB0F
  C53E  dw JCB0D
  C540  dw JCB0B
  C542  dw JCB09
  C544  dw JCB07
  C546  dw JCB05
  C548  dw JCB03
  C54A  dw JCB01
  C54C  dw JCAFF
  C54E  dw JCAFD
  C550  dw JCAFB
  C552  dw JCAF9
  C554  dw JCAF7
  C556  dw JCAF5
  C558  dw JCAF3
  C55A  dw JCAF1
  C55C  dw JCAEF
  C55E  dw JCAED
  C560  dw JCAEB
  C562  dw JCAE9
  C564  dw JCAE7
  C566  dw JCAE5
  C568  dw JCAE3
  C56A  dw JCAE1
SC56C:
  C56C  e258       ld A,(DE)
  C56E  1c         shlc A
  C56F  12         inc DE
  C570  5e         ld L,A
  C571  3700       ld H,$00
  C573  eb39f6cc   add HL,$CCF6
  C577  e658       ld A,(HL+)
  C579  e35a       ld C,(HL)
  C57B  3100       ld W,$00
  C57D  e839a603   add WA,$03A6
  C581  e817       ld HL,WA
  C583  52         ld A,C
  C584  1c         shlc A
  C585  e1fe       jp (PC+A)
  C587  dw JCB66
  C589  dw JCB64
  C58B  dw JCB62
  C58D  dw JCB60
  C58F  dw JCB5E
  C591  dw JCB5C
  C593  dw JCB5A
  C595  dw JCB58
  C597  dw JCB56
  C599  dw JCB54
  C59B  dw JCB52
  C59D  dw JCB50
  C59F  dw JCB4E
  C5A1  dw JCB4C
  C5A3  dw JCB4A
  C5A5  dw JCB48
  C5A7  dw JCB46
  C5A9  dw JCB44
  C5AB  dw JCB42
  C5AD  dw JCB40
  C5AF  dw JCB3E
  C5B1  dw JCB3C
  C5B3  dw JCB3A
  C5B5  dw JCB38
  C5B7  dw JCB36
  C5B9  dw JCB34
  C5BB  dw JCB32
  C5BD  dw JCB30
  C5BF  dw JCB2E
  C5C1  dw JCB2C
  C5C3  dw JCB2A
  C5C5  dw JCB28
  C5C7  dw JCB26
  C5C9  dw JCB24
SC5CB:
  C5CB  e258       ld A,(DE)
  C5CD  1c         shlc A
  C5CE  12         inc DE
  C5CF  5e         ld L,A
  C5D0  3700       ld H,$00
  C5D2  eb39f6cc   add HL,$CCF6
  C5D6  e658       ld A,(HL+)
  C5D8  e35a       ld C,(HL)
  C5DA  3100       ld W,$00
  C5DC  e839a603   add WA,$03A6
  C5E0  e817       ld HL,WA
  C5E2  52         ld A,C
  C5E3  1c         shlc A
  C5E4  e1fe       jp (PC+A)
  C5E6  dw JCBA9
  C5E8  dw JCBA7
  C5EA  dw JCBA5
  C5EC  dw JCBA3
  C5EE  dw JCBA1
  C5F0  dw JCB9F
  C5F2  dw JCB9D
  C5F4  dw JCB9B
  C5F6  dw JCB99
  C5F8  dw JCB97
  C5FA  dw JCB95
  C5FC  dw JCB93
  C5FE  dw JCB91
  C600  dw JCB8F
  C602  dw JCB8D
  C604  dw JCB8B
  C606  dw JCB89
  C608  dw JCB87
  C60A  dw JCB85
  C60C  dw JCB83
  C60E  dw JCB81
  C610  dw JCB7F
  C612  dw JCB7D
  C614  dw JCB7B
  C616  dw JCB79
  C618  dw JCB77
  C61A  dw JCB75
  C61C  dw JCB73
  C61E  dw JCB71
  C620  dw JCB6F
  C622  dw JCB6D
  C624  dw JCB6B
  C626  dw JCB69
  C628  dw JCB67
SC62A:
  C62A  e258       ld A,(DE)
  C62C  1c         shlc A
  C62D  12         inc DE
  C62E  5e         ld L,A
  C62F  3700       ld H,$00
  C631  eb39f6cc   add HL,$CCF6
  C635  e658       ld A,(HL+)
  C637  e35a       ld C,(HL)
  C639  3100       ld W,$00
  C63B  e839a603   add WA,$03A6
  C63F  e817       ld HL,WA
  C641  52         ld A,C
  C642  1c         shlc A
  C643  e1fe       jp (PC+A)
  C645  dw JCBEC
  C647  dw JCBEA
  C649  dw JCBE8
  C64B  dw JCBE6
  C64D  dw JCBE4
  C64F  dw JCBE2
  C651  dw JCBE0
  C653  dw JCBDE
  C655  dw JCBDC
  C657  dw JCBDA
  C659  dw JCBD8
  C65B  dw JCBD6
  C65D  dw JCBD4
  C65F  dw JCBD2
  C661  dw JCBD0
  C663  dw JCBCE
  C665  dw JCBCC
  C667  dw JCBCA
  C669  dw JCBC8
  C66B  dw JCBC6
  C66D  dw JCBC4
  C66F  dw JCBC2
  C671  dw JCBC0
  C673  dw JCBBE
  C675  dw JCBBC
  C677  dw JCBBA
  C679  dw JCBB8
  C67B  dw JCBB6
  C67D  dw JCBB4
  C67F  dw JCBB2
  C681  dw JCBB0
  C683  dw JCBAE
  C685  dw JCBAC
  C687  dw JCBAA
SC689:
  C689  e258       ld A,(DE)
  C68B  1c         shlc A
  C68C  12         inc DE
  C68D  5e         ld L,A
  C68E  3700       ld H,$00
  C690  eb39f6cc   add HL,$CCF6
  C694  e658       ld A,(HL+)
  C696  e35a       ld C,(HL)
  C698  3100       ld W,$00
  C69A  e839a603   add WA,$03A6
  C69E  e817       ld HL,WA
  C6A0  52         ld A,C
  C6A1  1c         shlc A
  C6A2  e1fe       jp (PC+A)
  C6A4  dw JCC2F
  C6A6  dw JCC2D
  C6A8  dw JCC2B
  C6AA  dw JCC29
  C6AC  dw JCC27
  C6AE  dw JCC25
  C6B0  dw JCC23
  C6B2  dw JCC21
  C6B4  dw JCC1F
  C6B6  dw JCC1D
  C6B8  dw JCC1B
  C6BA  dw JCC19
  C6BC  dw JCC17
  C6BE  dw JCC15
  C6C0  dw JCC13
  C6C2  dw JCC11
  C6C4  dw JCC0F
  C6C6  dw JCC0D
  C6C8  dw JCC0B
  C6CA  dw JCC09
  C6CC  dw JCC07
  C6CE  dw JCC05
  C6D0  dw JCC03
  C6D2  dw JCC01
  C6D4  dw JCBFF
  C6D6  dw JCBFD
  C6D8  dw JCBFB
  C6DA  dw JCBF9
  C6DC  dw JCBF7
  C6DE  dw JCBF5
  C6E0  dw JCBF3
  C6E2  dw JCBF1
  C6E4  dw JCBEF
  C6E6  dw JCBED
SC6E8:
  C6E8  e258       ld A,(DE)
  C6EA  1c         shlc A
  C6EB  12         inc DE
  C6EC  5e         ld L,A
  C6ED  3700       ld H,$00
  C6EF  eb39f6cc   add HL,$CCF6
  C6F3  e658       ld A,(HL+)
  C6F5  e35a       ld C,(HL)
  C6F7  3100       ld W,$00
  C6F9  e839a603   add WA,$03A6
  C6FD  e817       ld HL,WA
  C6FF  52         ld A,C
  C700  1c         shlc A
  C701  e1fe       jp (PC+A)
  C703  dw JCC72
  C705  dw JCC70
  C707  dw JCC6E
  C709  dw JCC6C
  C70B  dw JCC6A
  C70D  dw JCC68
  C70F  dw JCC66
  C711  dw JCC64
  C713  dw JCC62
  C715  dw JCC60
  C717  dw JCC5E
  C719  dw JCC5C
  C71B  dw JCC5A
  C71D  dw JCC58
  C71F  dw JCC56
  C721  dw JCC54
  C723  dw JCC52
  C725  dw JCC50
  C727  dw JCC4E
  C729  dw JCC4C
  C72B  dw JCC4A
  C72D  dw JCC48
  C72F  dw JCC46
  C731  dw JCC44
  C733  dw JCC42
  C735  dw JCC40
  C737  dw JCC3E
  C739  dw JCC3C
  C73B  dw JCC3A
  C73D  dw JCC38
  C73F  dw JCC36
  C741  dw JCC34
  C743  dw JCC32
  C745  dw JCC30
SC747:
  C747  e258       ld A,(DE)
  C749  1c         shlc A
  C74A  12         inc DE
  C74B  5e         ld L,A
  C74C  3700       ld H,$00
  C74E  eb39f6cc   add HL,$CCF6
  C752  e658       ld A,(HL+)
  C754  e35a       ld C,(HL)
  C756  3100       ld W,$00
  C758  e839a603   add WA,$03A6
  C75C  e817       ld HL,WA
  C75E  52         ld A,C
  C75F  1c         shlc A
  C760  e1fe       jp (PC+A)
  C762  dw JCCB5
  C764  dw JCCB3
  C766  dw JCCB1
  C768  dw JCCAF
  C76A  dw JCCAD
  C76C  dw JCCAB
  C76E  dw JCCA9
  C770  dw JCCA7
  C772  dw JCCA5
  C774  dw JCCA3
  C776  dw JCCA1
  C778  dw JCC9F
  C77A  dw JCC9D
  C77C  dw JCC9B
  C77E  dw JCC99
  C780  dw JCC97
  C782  dw JCC95
  C784  dw JCC93
  C786  dw JCC91
  C788  dw JCC8F
  C78A  dw JCC8D
  C78C  dw JCC8B
  C78E  dw JCC89
  C790  dw JCC87
  C792  dw JCC85
  C794  dw JCC83
  C796  dw JCC81
  C798  dw JCC7F
  C79A  dw JCC7D
  C79C  dw JCC7B
  C79E  dw JCC79
  C7A0  dw JCC77
  C7A2  dw JCC75
  C7A4  dw JCC73
SC7A6:
  C7A6  e258       ld A,(DE)
  C7A8  1c         shlc A
  C7A9  12         inc DE
  C7AA  5e         ld L,A
  C7AB  3700       ld H,$00
  C7AD  eb39f6cc   add HL,$CCF6
  C7B1  e658       ld A,(HL+)
  C7B3  e35a       ld C,(HL)
  C7B5  3100       ld W,$00
  C7B7  e839c903   add WA,$03C9
  C7BB  e817       ld HL,WA
  C7BD  52         ld A,C
  C7BE  1c         shlc A
  C7BF  e1fe       jp (PC+A)
  C7C1  dw JCAE0
  C7C3  dw JCADE
  C7C5  dw JCADC
  C7C7  dw JCADA
  C7C9  dw JCAD8
  C7CB  dw JCAD6
  C7CD  dw JCAD4
  C7CF  dw JCAD2
  C7D1  dw JCAD0
  C7D3  dw JCACE
  C7D5  dw JCACC
  C7D7  dw JCACA
  C7D9  dw JCAC8
  C7DB  dw JCAC6
  C7DD  dw JCAC4
  C7DF  dw JCAC2
  C7E1  dw JCAC0
  C7E3  dw JCABE
  C7E5  dw JCABC
  C7E7  dw JCABA
  C7E9  dw JCAB8
  C7EB  dw JCAB6
  C7ED  dw JCAB4
  C7EF  dw JCAB2
  C7F1  dw JCAB0
  C7F3  dw JCAAE
  C7F5  dw JCAAC
  C7F7  dw JCAAA
  C7F9  dw JCAA8
  C7FB  dw JCAA6
  C7FD  dw JCAA4
  C7FF  dw JCAA2
  C801  dw JCAA0
  C803  dw JCA9E
SC805:
  C805  e258       ld A,(DE)
  C807  1c         shlc A
  C808  12         inc DE
  C809  5e         ld L,A
  C80A  3700       ld H,$00
  C80C  eb39f6cc   add HL,$CCF6
  C810  e658       ld A,(HL+)
  C812  e35a       ld C,(HL)
  C814  3100       ld W,$00
  C816  e839c903   add WA,$03C9
  C81A  e817       ld HL,WA
  C81C  52         ld A,C
  C81D  1c         shlc A
  C81E  e1fe       jp (PC+A)
  C820  dw JCB23
  C822  dw JCB21
  C824  dw JCB1F
  C826  dw JCB1D
  C828  dw JCB1B
  C82A  dw JCB19
  C82C  dw JCB17
  C82E  dw JCB15
  C830  dw JCB13
  C832  dw JCB11
  C834  dw JCB0F
  C836  dw JCB0D
  C838  dw JCB0B
  C83A  dw JCB09
  C83C  dw JCB07
  C83E  dw JCB05
  C840  dw JCB03
  C842  dw JCB01
  C844  dw JCAFF
  C846  dw JCAFD
  C848  dw JCAFB
  C84A  dw JCAF9
  C84C  dw JCAF7
  C84E  dw JCAF5
  C850  dw JCAF3
  C852  dw JCAF1
  C854  dw JCAEF
  C856  dw JCAED
  C858  dw JCAEB
  C85A  dw JCAE9
  C85C  dw JCAE7
  C85E  dw JCAE5
  C860  dw JCAE3
  C862  dw JCAE1
SC864:
  C864  e258       ld A,(DE)
  C866  1c         shlc A
  C867  12         inc DE
  C868  5e         ld L,A
  C869  3700       ld H,$00
  C86B  eb39f6cc   add HL,$CCF6
  C86F  e658       ld A,(HL+)
  C871  e35a       ld C,(HL)
  C873  3100       ld W,$00
  C875  e839c903   add WA,$03C9
  C879  e817       ld HL,WA
  C87B  52         ld A,C
  C87C  1c         shlc A
  C87D  e1fe       jp (PC+A)
  C87F  dw JCB66
  C881  dw JCB64
  C883  dw JCB62
  C885  dw JCB60
  C887  dw JCB5E
  C889  dw JCB5C
  C88B  dw JCB5A
  C88D  dw JCB58
  C88F  dw JCB56
  C891  dw JCB54
  C893  dw JCB52
  C895  dw JCB50
  C897  dw JCB4E
  C899  dw JCB4C
  C89B  dw JCB4A
  C89D  dw JCB48
  C89F  dw JCB46
  C8A1  dw JCB44
  C8A3  dw JCB42
  C8A5  dw JCB40
  C8A7  dw JCB3E
  C8A9  dw JCB3C
  C8AB  dw JCB3A
  C8AD  dw JCB38
  C8AF  dw JCB36
  C8B1  dw JCB34
  C8B3  dw JCB32
  C8B5  dw JCB30
  C8B7  dw JCB2E
  C8B9  dw JCB2C
  C8BB  dw JCB2A
  C8BD  dw JCB28
  C8BF  dw JCB26
  C8C1  dw JCB24
SC8C3:
  C8C3  e258       ld A,(DE)
  C8C5  1c         shlc A
  C8C6  12         inc DE
  C8C7  5e         ld L,A
  C8C8  3700       ld H,$00
  C8CA  eb39f6cc   add HL,$CCF6
  C8CE  e658       ld A,(HL+)
  C8D0  e35a       ld C,(HL)
  C8D2  3100       ld W,$00
  C8D4  e839c903   add WA,$03C9
  C8D8  e817       ld HL,WA
  C8DA  52         ld A,C
  C8DB  1c         shlc A
  C8DC  e1fe       jp (PC+A)
  C8DE  dw JCBA9
  C8E0  dw JCBA7
  C8E2  dw JCBA5
  C8E4  dw JCBA3
  C8E6  dw JCBA1
  C8E8  dw JCB9F
  C8EA  dw JCB9D
  C8EC  dw JCB9B
  C8EE  dw JCB99
  C8F0  dw JCB97
  C8F2  dw JCB95
  C8F4  dw JCB93
  C8F6  dw JCB91
  C8F8  dw JCB8F
  C8FA  dw JCB8D
  C8FC  dw JCB8B
  C8FE  dw JCB89
  C900  dw JCB87
  C902  dw JCB85
  C904  dw JCB83
  C906  dw JCB81
  C908  dw JCB7F
  C90A  dw JCB7D
  C90C  dw JCB7B
  C90E  dw JCB79
  C910  dw JCB77
  C912  dw JCB75
  C914  dw JCB73
  C916  dw JCB71
  C918  dw JCB6F
  C91A  dw JCB6D
  C91C  dw JCB6B
  C91E  dw JCB69
  C920  dw JCB67
SC922:
  C922  e258       ld A,(DE)
  C924  1c         shlc A
  C925  12         inc DE
  C926  5e         ld L,A
  C927  3700       ld H,$00
  C929  eb39f6cc   add HL,$CCF6
  C92D  e658       ld A,(HL+)
  C92F  e35a       ld C,(HL)
  C931  3100       ld W,$00
  C933  e839c903   add WA,$03C9
  C937  e817       ld HL,WA
  C939  52         ld A,C
  C93A  1c         shlc A
  C93B  e1fe       jp (PC+A)
  C93D  dw JCBEC
  C93F  dw JCBEA
  C941  dw JCBE8
  C943  dw JCBE6
  C945  dw JCBE4
  C947  dw JCBE2
  C949  dw JCBE0
  C94B  dw JCBDE
  C94D  dw JCBDC
  C94F  dw JCBDA
  C951  dw JCBD8
  C953  dw JCBD6
  C955  dw JCBD4
  C957  dw JCBD2
  C959  dw JCBD0
  C95B  dw JCBCE
  C95D  dw JCBCC
  C95F  dw JCBCA
  C961  dw JCBC8
  C963  dw JCBC6
  C965  dw JCBC4
  C967  dw JCBC2
  C969  dw JCBC0
  C96B  dw JCBBE
  C96D  dw JCBBC
  C96F  dw JCBBA
  C971  dw JCBB8
  C973  dw JCBB6
  C975  dw JCBB4
  C977  dw JCBB2
  C979  dw JCBB0
  C97B  dw JCBAE
  C97D  dw JCBAC
  C97F  dw JCBAA
SC981:
  C981  e258       ld A,(DE)
  C983  1c         shlc A
  C984  12         inc DE
  C985  5e         ld L,A
  C986  3700       ld H,$00
  C988  eb39f6cc   add HL,$CCF6
  C98C  e658       ld A,(HL+)
  C98E  e35a       ld C,(HL)
  C990  3100       ld W,$00
  C992  e839c903   add WA,$03C9
  C996  e817       ld HL,WA
  C998  52         ld A,C
  C999  1c         shlc A
  C99A  e1fe       jp (PC+A)
  C99C  dw JCC2F
  C99E  dw JCC2D
  C9A0  dw JCC2B
  C9A2  dw JCC29
  C9A4  dw JCC27
  C9A6  dw JCC25
  C9A8  dw JCC23
  C9AA  dw JCC21
  C9AC  dw JCC1F
  C9AE  dw JCC1D
  C9B0  dw JCC1B
  C9B2  dw JCC19
  C9B4  dw JCC17
  C9B6  dw JCC15
  C9B8  dw JCC13
  C9BA  dw JCC11
  C9BC  dw JCC0F
  C9BE  dw JCC0D
  C9C0  dw JCC0B
  C9C2  dw JCC09
  C9C4  dw JCC07
  C9C6  dw JCC05
  C9C8  dw JCC03
  C9CA  dw JCC01
  C9CC  dw JCBFF
  C9CE  dw JCBFD
  C9D0  dw JCBFB
  C9D2  dw JCBF9
  C9D4  dw JCBF7
  C9D6  dw JCBF5
  C9D8  dw JCBF3
  C9DA  dw JCBF1
  C9DC  dw JCBEF
  C9DE  dw JCBED
SC9E0:
  C9E0  e258       ld A,(DE)
  C9E2  1c         shlc A
  C9E3  12         inc DE
  C9E4  5e         ld L,A
  C9E5  3700       ld H,$00
  C9E7  eb39f6cc   add HL,$CCF6
  C9EB  e658       ld A,(HL+)
  C9ED  e35a       ld C,(HL)
  C9EF  3100       ld W,$00
  C9F1  e839c903   add WA,$03C9
  C9F5  e817       ld HL,WA
  C9F7  52         ld A,C
  C9F8  1c         shlc A
  C9F9  e1fe       jp (PC+A)
  C9FB  dw JCC72
  C9FD  dw JCC70
  C9FF  dw JCC6E
  CA01  dw JCC6C
  CA03  dw JCC6A
  CA05  dw JCC68
  CA07  dw JCC66
  CA09  dw JCC64
  CA0B  dw JCC62
  CA0D  dw JCC60
  CA0F  dw JCC5E
  CA11  dw JCC5C
  CA13  dw JCC5A
  CA15  dw JCC58
  CA17  dw JCC56
  CA19  dw JCC54
  CA1B  dw JCC52
  CA1D  dw JCC50
  CA1F  dw JCC4E
  CA21  dw JCC4C
  CA23  dw JCC4A
  CA25  dw JCC48
  CA27  dw JCC46
  CA29  dw JCC44
  CA2B  dw JCC42
  CA2D  dw JCC40
  CA2F  dw JCC3E
  CA31  dw JCC3C
  CA33  dw JCC3A
  CA35  dw JCC38
  CA37  dw JCC36
  CA39  dw JCC34
  CA3B  dw JCC32
  CA3D  dw JCC30
SCA3F:
  CA3F  e258       ld A,(DE)
  CA41  1c         shlc A
  CA42  12         inc DE
  CA43  5e         ld L,A
  CA44  3700       ld H,$00
  CA46  eb39f6cc   add HL,$CCF6
  CA4A  e658       ld A,(HL+)
  CA4C  e35a       ld C,(HL)
  CA4E  3100       ld W,$00
  CA50  e839c903   add WA,$03C9
  CA54  e817       ld HL,WA
  CA56  52         ld A,C
  CA57  1c         shlc A
  CA58  e1fe       jp (PC+A)
  CA5A  dw JCCB5
  CA5C  dw JCCB3
  CA5E  dw JCCB1
  CA60  dw JCCAF
  CA62  dw JCCAD
  CA64  dw JCCAB
  CA66  dw JCCA9
  CA68  dw JCCA7
  CA6A  dw JCCA5
  CA6C  dw JCCA3
  CA6E  dw JCCA1
  CA70  dw JCC9F
  CA72  dw JCC9D
  CA74  dw JCC9B
  CA76  dw JCC99
  CA78  dw JCC97
  CA7A  dw JCC95
  CA7C  dw JCC93
  CA7E  dw JCC91
  CA80  dw JCC8F
  CA82  dw JCC8D
  CA84  dw JCC8B
  CA86  dw JCC89
  CA88  dw JCC87
  CA8A  dw JCC85
  CA8C  dw JCC83
  CA8E  dw JCC81
  CA90  dw JCC7F
  CA92  dw JCC7D
  CA94  dw JCC7B
  CA96  dw JCC79
  CA98  dw JCC77
  CA9A  dw JCC75
  CA9C  dw JCC73
JCA9E:
  CA9E  e640       set (HL+).0
JCAA0:
  CAA0  e640       set (HL+).0
JCAA2:
  CAA2  e640       set (HL+).0
JCAA4:
  CAA4  e640       set (HL+).0
JCAA6:
  CAA6  e640       set (HL+).0
JCAA8:
  CAA8  e640       set (HL+).0
JCAAA:
  CAAA  e640       set (HL+).0
JCAAC:
  CAAC  e640       set (HL+).0
JCAAE:
  CAAE  e640       set (HL+).0
JCAB0:
  CAB0  e640       set (HL+).0
JCAB2:
  CAB2  e640       set (HL+).0
JCAB4:
  CAB4  e640       set (HL+).0
JCAB6:
  CAB6  e640       set (HL+).0
JCAB8:
  CAB8  e640       set (HL+).0
JCABA:
  CABA  e640       set (HL+).0
JCABC:
  CABC  e640       set (HL+).0
JCABE:
  CABE  e640       set (HL+).0
JCAC0:
  CAC0  e640       set (HL+).0
JCAC2:
  CAC2  e640       set (HL+).0
JCAC4:
  CAC4  e640       set (HL+).0
JCAC6:
  CAC6  e640       set (HL+).0
JCAC8:
  CAC8  e640       set (HL+).0
JCACA:
  CACA  e640       set (HL+).0
JCACC:
  CACC  e640       set (HL+).0
JCACE:
  CACE  e640       set (HL+).0
JCAD0:
  CAD0  e640       set (HL+).0
JCAD2:
  CAD2  e640       set (HL+).0
JCAD4:
  CAD4  e640       set (HL+).0
JCAD6:
  CAD6  e640       set (HL+).0
JCAD8:
  CAD8  e640       set (HL+).0
JCADA:
  CADA  e640       set (HL+).0
JCADC:
  CADC  e640       set (HL+).0
JCADE:
  CADE  e640       set (HL+).0
JCAE0:
  CAE0  05         ret
JCAE1:
  CAE1  e641       set (HL+).1
JCAE3:
  CAE3  e641       set (HL+).1
JCAE5:
  CAE5  e641       set (HL+).1
JCAE7:
  CAE7  e641       set (HL+).1
JCAE9:
  CAE9  e641       set (HL+).1
JCAEB:
  CAEB  e641       set (HL+).1
JCAED:
  CAED  e641       set (HL+).1
JCAEF:
  CAEF  e641       set (HL+).1
JCAF1:
  CAF1  e641       set (HL+).1
JCAF3:
  CAF3  e641       set (HL+).1
JCAF5:
  CAF5  e641       set (HL+).1
JCAF7:
  CAF7  e641       set (HL+).1
JCAF9:
  CAF9  e641       set (HL+).1
JCAFB:
  CAFB  e641       set (HL+).1
JCAFD:
  CAFD  e641       set (HL+).1
JCAFF:
  CAFF  e641       set (HL+).1
JCB01:
  CB01  e641       set (HL+).1
JCB03:
  CB03  e641       set (HL+).1
JCB05:
  CB05  e641       set (HL+).1
JCB07:
  CB07  e641       set (HL+).1
JCB09:
  CB09  e641       set (HL+).1
JCB0B:
  CB0B  e641       set (HL+).1
JCB0D:
  CB0D  e641       set (HL+).1
JCB0F:
  CB0F  e641       set (HL+).1
JCB11:
  CB11  e641       set (HL+).1
JCB13:
  CB13  e641       set (HL+).1
JCB15:
  CB15  e641       set (HL+).1
JCB17:
  CB17  e641       set (HL+).1
JCB19:
  CB19  e641       set (HL+).1
JCB1B:
  CB1B  e641       set (HL+).1
JCB1D:
  CB1D  e641       set (HL+).1
JCB1F:
  CB1F  e641       set (HL+).1
JCB21:
  CB21  e641       set (HL+).1
JCB23:
  CB23  05         ret
JCB24:
  CB24  e642       set (HL+).2
JCB26:
  CB26  e642       set (HL+).2
JCB28:
  CB28  e642       set (HL+).2
JCB2A:
  CB2A  e642       set (HL+).2
JCB2C:
  CB2C  e642       set (HL+).2
JCB2E:
  CB2E  e642       set (HL+).2
JCB30:
  CB30  e642       set (HL+).2
JCB32:
  CB32  e642       set (HL+).2
JCB34:
  CB34  e642       set (HL+).2
JCB36:
  CB36  e642       set (HL+).2
JCB38:
  CB38  e642       set (HL+).2
JCB3A:
  CB3A  e642       set (HL+).2
JCB3C:
  CB3C  e642       set (HL+).2
JCB3E:
  CB3E  e642       set (HL+).2
JCB40:
  CB40  e642       set (HL+).2
JCB42:
  CB42  e642       set (HL+).2
JCB44:
  CB44  e642       set (HL+).2
JCB46:
  CB46  e642       set (HL+).2
JCB48:
  CB48  e642       set (HL+).2
JCB4A:
  CB4A  e642       set (HL+).2
JCB4C:
  CB4C  e642       set (HL+).2
JCB4E:
  CB4E  e642       set (HL+).2
JCB50:
  CB50  e642       set (HL+).2
JCB52:
  CB52  e642       set (HL+).2
JCB54:
  CB54  e642       set (HL+).2
JCB56:
  CB56  e642       set (HL+).2
JCB58:
  CB58  e642       set (HL+).2
JCB5A:
  CB5A  e642       set (HL+).2
JCB5C:
  CB5C  e642       set (HL+).2
JCB5E:
  CB5E  e642       set (HL+).2
JCB60:
  CB60  e642       set (HL+).2
JCB62:
  CB62  e642       set (HL+).2
JCB64:
  CB64  e642       set (HL+).2
JCB66:
  CB66  05         ret
JCB67:
  CB67  e643       set (HL+).3
JCB69:
  CB69  e643       set (HL+).3
JCB6B:
  CB6B  e643       set (HL+).3
JCB6D:
  CB6D  e643       set (HL+).3
JCB6F:
  CB6F  e643       set (HL+).3
JCB71:
  CB71  e643       set (HL+).3
JCB73:
  CB73  e643       set (HL+).3
JCB75:
  CB75  e643       set (HL+).3
JCB77:
  CB77  e643       set (HL+).3
JCB79:
  CB79  e643       set (HL+).3
JCB7B:
  CB7B  e643       set (HL+).3
JCB7D:
  CB7D  e643       set (HL+).3
JCB7F:
  CB7F  e643       set (HL+).3
JCB81:
  CB81  e643       set (HL+).3
JCB83:
  CB83  e643       set (HL+).3
JCB85:
  CB85  e643       set (HL+).3
JCB87:
  CB87  e643       set (HL+).3
JCB89:
  CB89  e643       set (HL+).3
JCB8B:
  CB8B  e643       set (HL+).3
JCB8D:
  CB8D  e643       set (HL+).3
JCB8F:
  CB8F  e643       set (HL+).3
JCB91:
  CB91  e643       set (HL+).3
JCB93:
  CB93  e643       set (HL+).3
JCB95:
  CB95  e643       set (HL+).3
JCB97:
  CB97  e643       set (HL+).3
JCB99:
  CB99  e643       set (HL+).3
JCB9B:
  CB9B  e643       set (HL+).3
JCB9D:
  CB9D  e643       set (HL+).3
JCB9F:
  CB9F  e643       set (HL+).3
JCBA1:
  CBA1  e643       set (HL+).3
JCBA3:
  CBA3  e643       set (HL+).3
JCBA5:
  CBA5  e643       set (HL+).3
JCBA7:
  CBA7  e643       set (HL+).3
JCBA9:
  CBA9  05         ret
JCBAA:
  CBAA  e644       set (HL+).4
JCBAC:
  CBAC  e644       set (HL+).4
JCBAE:
  CBAE  e644       set (HL+).4
JCBB0:
  CBB0  e644       set (HL+).4
JCBB2:
  CBB2  e644       set (HL+).4
JCBB4:
  CBB4  e644       set (HL+).4
JCBB6:
  CBB6  e644       set (HL+).4
JCBB8:
  CBB8  e644       set (HL+).4
JCBBA:
  CBBA  e644       set (HL+).4
JCBBC:
  CBBC  e644       set (HL+).4
JCBBE:
  CBBE  e644       set (HL+).4
JCBC0:
  CBC0  e644       set (HL+).4
JCBC2:
  CBC2  e644       set (HL+).4
JCBC4:
  CBC4  e644       set (HL+).4
JCBC6:
  CBC6  e644       set (HL+).4
JCBC8:
  CBC8  e644       set (HL+).4
JCBCA:
  CBCA  e644       set (HL+).4
JCBCC:
  CBCC  e644       set (HL+).4
JCBCE:
  CBCE  e644       set (HL+).4
JCBD0:
  CBD0  e644       set (HL+).4
JCBD2:
  CBD2  e644       set (HL+).4
JCBD4:
  CBD4  e644       set (HL+).4
JCBD6:
  CBD6  e644       set (HL+).4
JCBD8:
  CBD8  e644       set (HL+).4
JCBDA:
  CBDA  e644       set (HL+).4
JCBDC:
  CBDC  e644       set (HL+).4
JCBDE:
  CBDE  e644       set (HL+).4
JCBE0:
  CBE0  e644       set (HL+).4
JCBE2:
  CBE2  e644       set (HL+).4
JCBE4:
  CBE4  e644       set (HL+).4
JCBE6:
  CBE6  e644       set (HL+).4
JCBE8:
  CBE8  e644       set (HL+).4
JCBEA:
  CBEA  e644       set (HL+).4
JCBEC:
  CBEC  05         ret
JCBED:
  CBED  e645       set (HL+).5
JCBEF:
  CBEF  e645       set (HL+).5
JCBF1:
  CBF1  e645       set (HL+).5
JCBF3:
  CBF3  e645       set (HL+).5
JCBF5:
  CBF5  e645       set (HL+).5
JCBF7:
  CBF7  e645       set (HL+).5
JCBF9:
  CBF9  e645       set (HL+).5
JCBFB:
  CBFB  e645       set (HL+).5
JCBFD:
  CBFD  e645       set (HL+).5
JCBFF:
  CBFF  e645       set (HL+).5
JCC01:
  CC01  e645       set (HL+).5
JCC03:
  CC03  e645       set (HL+).5
JCC05:
  CC05  e645       set (HL+).5
JCC07:
  CC07  e645       set (HL+).5
JCC09:
  CC09  e645       set (HL+).5
JCC0B:
  CC0B  e645       set (HL+).5
JCC0D:
  CC0D  e645       set (HL+).5
JCC0F:
  CC0F  e645       set (HL+).5
JCC11:
  CC11  e645       set (HL+).5
JCC13:
  CC13  e645       set (HL+).5
JCC15:
  CC15  e645       set (HL+).5
JCC17:
  CC17  e645       set (HL+).5
JCC19:
  CC19  e645       set (HL+).5
JCC1B:
  CC1B  e645       set (HL+).5
JCC1D:
  CC1D  e645       set (HL+).5
JCC1F:
  CC1F  e645       set (HL+).5
JCC21:
  CC21  e645       set (HL+).5
JCC23:
  CC23  e645       set (HL+).5
JCC25:
  CC25  e645       set (HL+).5
JCC27:
  CC27  e645       set (HL+).5
JCC29:
  CC29  e645       set (HL+).5
JCC2B:
  CC2B  e645       set (HL+).5
JCC2D:
  CC2D  e645       set (HL+).5
JCC2F:
  CC2F  05         ret
JCC30:
  CC30  e646       set (HL+).6
JCC32:
  CC32  e646       set (HL+).6
JCC34:
  CC34  e646       set (HL+).6
JCC36:
  CC36  e646       set (HL+).6
JCC38:
  CC38  e646       set (HL+).6
JCC3A:
  CC3A  e646       set (HL+).6
JCC3C:
  CC3C  e646       set (HL+).6
JCC3E:
  CC3E  e646       set (HL+).6
JCC40:
  CC40  e646       set (HL+).6
JCC42:
  CC42  e646       set (HL+).6
JCC44:
  CC44  e646       set (HL+).6
JCC46:
  CC46  e646       set (HL+).6
JCC48:
  CC48  e646       set (HL+).6
JCC4A:
  CC4A  e646       set (HL+).6
JCC4C:
  CC4C  e646       set (HL+).6
JCC4E:
  CC4E  e646       set (HL+).6
JCC50:
  CC50  e646       set (HL+).6
JCC52:
  CC52  e646       set (HL+).6
JCC54:
  CC54  e646       set (HL+).6
JCC56:
  CC56  e646       set (HL+).6
JCC58:
  CC58  e646       set (HL+).6
JCC5A:
  CC5A  e646       set (HL+).6
JCC5C:
  CC5C  e646       set (HL+).6
JCC5E:
  CC5E  e646       set (HL+).6
JCC60:
  CC60  e646       set (HL+).6
JCC62:
  CC62  e646       set (HL+).6
JCC64:
  CC64  e646       set (HL+).6
JCC66:
  CC66  e646       set (HL+).6
JCC68:
  CC68  e646       set (HL+).6
JCC6A:
  CC6A  e646       set (HL+).6
JCC6C:
  CC6C  e646       set (HL+).6
JCC6E:
  CC6E  e646       set (HL+).6
JCC70:
  CC70  e646       set (HL+).6
JCC72:
  CC72  05         ret
JCC73:
  CC73  e647       set (HL+).7
JCC75:
  CC75  e647       set (HL+).7
JCC77:
  CC77  e647       set (HL+).7
JCC79:
  CC79  e647       set (HL+).7
JCC7B:
  CC7B  e647       set (HL+).7
JCC7D:
  CC7D  e647       set (HL+).7
JCC7F:
  CC7F  e647       set (HL+).7
JCC81:
  CC81  e647       set (HL+).7
JCC83:
  CC83  e647       set (HL+).7
JCC85:
  CC85  e647       set (HL+).7
JCC87:
  CC87  e647       set (HL+).7
JCC89:
  CC89  e647       set (HL+).7
JCC8B:
  CC8B  e647       set (HL+).7
JCC8D:
  CC8D  e647       set (HL+).7
JCC8F:
  CC8F  e647       set (HL+).7
JCC91:
  CC91  e647       set (HL+).7
JCC93:
  CC93  e647       set (HL+).7
JCC95:
  CC95  e647       set (HL+).7
JCC97:
  CC97  e647       set (HL+).7
JCC99:
  CC99  e647       set (HL+).7
JCC9B:
  CC9B  e647       set (HL+).7
JCC9D:
  CC9D  e647       set (HL+).7
JCC9F:
  CC9F  e647       set (HL+).7
JCCA1:
  CCA1  e647       set (HL+).7
JCCA3:
  CCA3  e647       set (HL+).7
JCCA5:
  CCA5  e647       set (HL+).7
JCCA7:
  CCA7  e647       set (HL+).7
JCCA9:
  CCA9  e647       set (HL+).7
JCCAB:
  CCAB  e647       set (HL+).7
JCCAD:
  CCAD  e647       set (HL+).7
JCCAF:
  CCAF  e647       set (HL+).7
JCCB1:
  CCB1  e647       set (HL+).7
JCCB3:
  CCB3  e647       set (HL+).7
JCCB5:
  CCB5  05         ret
  CCB6  db 00 3B 52 6B 00 00 00 00 00 00 00 00 00 00 00 00
  CCC6  db 00 29 45 65 00 00 00 00 00 00 00 00 00 00 00 00
  CCD6  db 00 25 36 60 00 00 00 00 00 00 00 00 00 00 00 00
  CCE6  db 00 21 2B 4A 00 00 00 00 00 00 00 00 00 00 00 00
  CCF6  db 00 00 00 00 00 00 00 00 10 01 10 01 10 01 0F 02
  CD06  db 0F 02 0F 02 0F 03 0F 03 0F 03 0E 04 0E 04 0E 04
  CD16  db 0E 05 0E 05 0E 05 0D 06 0D 06 0D 06 0D 07 0D 07
  CD26  db 0D 07 0C 08 0C 08 0C 08 0C 09 0C 09 0C 09 0B 0A
  CD36  db 0B 0A 0B 0A 0B 0B 0B 0B 0B 0B 0A 0C 0A 0C 0A 0C
  CD46  db 0A 0D 0A 0D 0A 0D 09 0E 09 0E 09 0E 09 0F 09 0F
  CD56  db 09 0F 08 10 08 10 08 10 08 11 08 11 08 11 07 12
  CD66  db 07 12 07 12 07 13 07 13 07 13 06 14 06 14 06 14
  CD76  db 06 15 06 15 06 15 05 16 05 16 05 16 05 17 05 17
  CD86  db 05 17 04 18 04 18 04 18 04 19 04 19 04 19 03 1A
  CD96  db 03 1A 03 1A 03 1B 03 1B 03 1B 02 1C 02 1C 02 1C
  CDA6  db 02 1D 02 1D 02 1D 01 1E 01 1E 01 1E 01 1F 01 1F
  CDB6  db 01 1F 00 20 00 20 00 20 00 21 00 21 00 21 00 21
  CDC6  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CDD6  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CDE6  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CDF6  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CE06  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CE16  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CE26  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CE36  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CE46  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CE56  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CE66  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CE76  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CE86  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CE96  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CEA6  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CEB6  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CEC6  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CED6  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CEE6  db 00 21 00 21 00 21 00 21 00 21 00 21 00 21 00 21
  CEF6  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  CF06  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  CF16  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  CF26  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  CF36  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  CF46  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  CF56  db 00 00 03 03 03 03 03 03 03 03 03 03 03 03 03 03
  CF66  db 03 03 03 03 04 07 07 07 07 07 07 07 07 07 07 07
  CF76  db 07 07 07 07 07 07 07 07 07 07 07 07 0C 0C 0C 0C
  CF86  db 0C 0C 0C 0C 0C 0C 0C 0C 0C 0F 0F 0F 0F 0F 0F 0F
  CF96  db 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F
  CFA6  db 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F
  CFB6  db 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F
  CFC6  db 0F 0F 0F 0F 0F 0F 0F 0F 00 00 00 00 00 00 00 00
  CFD6  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  CFE6  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  CFF6  db F0 F0 F0 F0 F0 F0 F0 F1 F1 F1 F1 F1 F1 F1 F2 F2
  D006  db F2 F2 F2 F2 F2 F3 F3 F3 F3 F3 F3 F3 F4 F4 F4 F4
  D016  db F4 F4 F4 F5 F5 F5 F5 F5 F5 F5 F6 F6 F6 F6 F6 F6
  D026  db F6 F7 F7 F7 F7 F7 F7 F7 F8 F8 F8 F8 F9 F9 F9 F9
  D036  db F9 F9 F9 F9 FA FA FA FA FA FA FA FA FB FB FB FB
  D046  db FB FB FB FB FC FC FC FC FC FC FC FC FD FD FD FD
  D056  db FD FD FD FD FE FE FE FE FE FE FE FE FF FF FF FF
  D066  db FF FF FF FF 00 00 00 00 00 00 00 00 01 01 01 01
  D076  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D086  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D096  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D0A6  db 00 00 00 00 00 FF FF FF FF FF FF FF FF FF FF FF
  D0B6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  D0C6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  D0D6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  D0E6  db FF FF FF FF FE FE FE FE FE FE FE FE FE FE FE FE
  D0F6  db FE FE FE FE FE FE FE FE FE FE FE FE FE FE FE FE
  D106  db FE FE FE FE FE FE FE FE FE FE FE FE FE FE FE FE
  D116  db FE FE FE FE FE FD FD FD FD FD FD FD FD FD FD FD
  D126  db FD FD FD FD FD FD FD FD FD FD FD FD FD FC FC FC
  D136  db FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC
  D146  db FC FC FC FC FC FC FC FC 00 00 00 00 00 00 00 00
  D156  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D166  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D176  db 00 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01
  D186  db 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01 02
  D196  db 02 02 02 02 02 02 02 02 02 02 02 02 02 02 02 02
  D1A6  db 02 02 02 03 03 03 03 03 03 03 03 03 03 03 03 03
  D1B6  db 03 03 03 03 03 03 03 04 04 04 04 04 04 04 04 04
  D1C6  db 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04
  D1D6  db 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04
  D1E6  db 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04
  D1F6  db 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04
  D206  db 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04
  D216  db 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04
  D226  db 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04
  D236  db 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04
  D246  db 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04
  D256  db 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04
  D266  db 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04
  D276  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D286  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D296  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D2A6  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D2B6  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D2C6  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D2D6  db 00 00 00 00 00 00 00 00 00 00 FA 00 FA 00 FA 00
  D2E6  db FA 00 FA 00 F0 00 F0 00 F0 00 F0 00 E6 00 E6 00
  D2F6  db E6 00 DC 00 DC 00 DC 00 DC 00 D2 00 D2 00 D2 00
  D306  db D2 00 C8 00 C8 00 C8 00 C8 00 BE 00 BE 00 BE 00
  D316  db BE 00 BE 00 B4 00 B4 00 B4 00 B4 00 B4 00 AA 00
  D326  db AA 00 AA 00 AA 00 AA 00 A0 00 A0 00 A0 00 A0 00
  D336  db A0 00 96 00 96 00 96 00 96 00 96 00 8C 00 8C 00
  D346  db 8C 00 8C 00 8C 00 8C 00 82 00 82 00 82 00 82 00
  D356  db 82 00 82 00 78 00 78 00 78 00 78 00 78 00 78 00
  D366  db 78 00 78 00 6E 00 6E 00 6E 00 6E 00 6E 00 6E 00
  D376  db 64 00 64 00 64 00 64 00 64 00 64 00 64 00 64 00
  D386  db 64 00 64 00 64 00 64 00 32 00 32 00 32 00 32 00
  D396  db 32 00 32 00 32 00 32 00 32 00 32 00 32 00 32 00
  D3A6  db 32 00 28 00 28 00 28 00 28 00 28 00 28 00 28 00
  D3B6  db 28 00 28 00 28 00 1E 00 1E 00 1E 00 1E 00 1E 00
  D3C6  db 1E 00 1E 00 1E 00 1E 00 1E 00 1E 00 14 00 14 00
  D3D6  db 14 00 14 00 14 00 14 00 14 00 14 00 14 00 14 00
  D3E6  db 14 00 14 00 0A 00 0A 00 0A 00 0A 00 0A 00 0A 00
  D3F6  db 0A 00 0A 00 0A 00 0A 00 0A 00 0A 00 0A 00 0A 00
  D406  db 0A 00 0A 00 0A 00 0A 00 0A 00 0A 00 0A 00 0A 00
  D416  db 0A 00 0A 00 0A 00 0A 00 0A 00 0A 00 0A 00 0A 00
  D426  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D436  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D446  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D456  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D466  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D476  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D486  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D496  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D4A6  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D4B6  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D4C6  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D4D6  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D4E6  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D4F6  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D506  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D516  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D526  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D536  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D546  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D556  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D566  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D576  db FE FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC
  D586  db FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC
  D596  db FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC
  D5A6  db FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC
  D5B6  db FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC
  D5C6  db FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC
  D5D6  db FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC
  D5E6  db FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC
  D5F6  db FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC
  D606  db FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC
  D616  db FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC
  D626  db FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC
  D636  db FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC
  D646  db FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC
  D656  db FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC
  D666  db FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC FC
  D676  db FC F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9
  D686  db F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9
  D696  db F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9
  D6A6  db F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9
  D6B6  db F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9
  D6C6  db F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9
  D6D6  db F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9
  D6E6  db F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9
  D6F6  db F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9
  D706  db F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9
  D716  db F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9
  D726  db F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9
  D736  db F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9
  D746  db F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9
  D756  db F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9
  D766  db F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9 F9
  D776  db F6 F6 F6 F6 F6 F6 F6 F6 F6 F6 F6 F6 F6 F6 F6 F6
  D786  db F3 F3 F3 F3 F3 F3 F3 F3 F3 F3 F3 F3 F3 F3 F3 F3
  D796  db F3 F3 F3 F3 F3 F3 F3 F3 F3 F3 F3 F3 F3 F3 F3 F3
  D7A6  db F3 F3 F3 F3 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1
  D7B6  db F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1
  D7C6  db F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1
  D7D6  db F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1
  D7E6  db F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1
  D7F6  db F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1
  D806  db F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1
  D816  db F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1
  D826  db F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1
  D836  db F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1
  D846  db F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1
  D856  db F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1
  D866  db F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1 F1
  D876  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D886  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D896  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D8A6  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D8B6  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D8C6  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  D8D6  db 00 00 00 00 00 00 00 00 00 00 08 00 08 00 08 00
  D8E6  db 08 00 08 00 0C 00 0C 00 0C 00 0C 00 0C 00 0C 00
  D8F6  db 0C 00 10 00 10 00 10 00 10 00 10 00 10 00 10 00
  D906  db 10 00 14 00 14 00 14 00 14 00 14 00 14 00 14 00
  D916  db 14 00 14 00 18 00 18 00 18 00 18 00 18 00 18 00
  D926  db 18 00 18 00 18 00 18 00 1C 00 1C 00 1C 00 1C 00
  D936  db 1C 00 1C 00 1C 00 1C 00 1C 00 1C 00 20 00 20 00
  D946  db 20 00 20 00 20 00 20 00 20 00 20 00 20 00 20 00
  D956  db 20 00 20 00 24 00 24 00 24 00 24 00 24 00 24 00
  D966  db 24 00 24 00 24 00 24 00 24 00 24 00 28 00 28 00
  D976  db 28 00 28 00 28 00 28 00 28 00 28 00 28 00 28 00
  D986  db 28 00 28 00 28 00 28 00 28 00 28 00 28 00 28 00
  D996  db 28 00 28 00 28 00 28 00 28 00 28 00 28 00 2C 00
  D9A6  db 2C 00 2C 00 2C 00 2C 00 2C 00 2C 00 2C 00 2C 00
  D9B6  db 2C 00 2C 00 2C 00 30 00 30 00 30 00 30 00 30 00
  D9C6  db 30 00 30 00 30 00 30 00 30 00 30 00 30 00 34 00
  D9D6  db 34 00 34 00 34 00 34 00 34 00 34 00 34 00 34 00
  D9E6  db 34 00 34 00 38 00 38 00 38 00 38 00 38 00 38 00
  D9F6  db 38 00 38 00 38 00 38 00 38 00 3C 00 3C 00 3C 00
  DA06  db 3C 00 3C 00 3C 00 3C 00 3C 00 3C 00 3C 00 40 00
  DA16  db 40 00 40 00 40 00 40 00 40 00 40 00 40 00 40 00
  DA26  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  DA36  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  DA46  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  DA56  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  DA66  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  DA76  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  DA86  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  DA96  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  DAA6  db 00 00 00 00 00 E6 E6 E6 E6 E6 E6 E6 E6 E6 E6 E6
  DAB6  db E6 E6 E6 E6 E6 E6 E6 E6 E6 D9 D9 D9 D9 D9 D9 D9
  DAC6  db D9 D9 D9 D9 D9 D9 D9 D9 D9 D9 D9 D9 CC CC CC CC
  DAD6  db CC CC CC CC CC CC CC CC CC CC CC CC CC CC CC CC
  DAE6  db CC CC C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0
  DAF6  db C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0
  DB06  db C0 C0 C0 C0 C0 C0 C0 C0 C0 B3 B3 B3 B3 B3 B3 B3
  DB16  db B3 B3 B3 B3 B3 A6 A6 A6 A6 A6 A6 A6 A6 A6 A6 99
  DB26  db 99 99 99 99 99 99 99 99 99 99 8C 8C 8C 8C 8C 8C
  DB36  db 8C 8C 8C 8C 8C 80 80 80 80 80 80 80 80 80 80 80
  DB46  db 80 80 80 80 80 80 80 80 00 00 00 00 00 00 00 00
  DB56  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  DB66  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  DB76  db 88 DB A1 DB BA DB D3 DB EC DB 05 DC 1E DC 37 DC
  DB86  db 50 DC 64 64 64 64 64 64 64 64 64 64 64 64 66 64
  DB96  db 62 61 60 5F 5E 5E 5D 5D 64 64 64 64 64 64 64 64
  DBA6  db 64 64 64 64 64 64 64 62 60 5F 5E 5D 5D 5C 5B 5B
  DBB6  db 5B 64 64 64 64 64 64 64 64 64 64 64 64 64 64 64
  DBC6  db 61 5E 5E 5C 5B 5B 5A 5A 59 59 64 64 64 64 64 64
  DBD6  db 64 64 64 64 64 64 64 64 64 5F 5D 5D 5C 5B 5A 59
  DBE6  db 59 59 59 64 64 64 64 64 64 64 64 64 64 64 64 64
  DBF6  db 64 64 5E 5C 5B 5A 5A 59 59 58 58 58 64 64 64 64
  DC06  db 64 64 64 64 64 64 64 64 64 64 64 5D 5B 5A 59 59
  DC16  db 59 58 58 57 57 64 64 64 64 64 64 64 64 64 64 64
  DC26  db 64 64 64 64 5C 5A 59 59 58 57 56 56 56 56 64 64
  DC36  db 64 64 64 64 64 64 64 64 64 64 64 64 64 5C 5A 59
  DC46  db 59 58 57 57 57 56 56 64 64 64 64 64 64 64 64 64
  DC56  db 64 64 64 64 64 64 5C 5A 59 59 58 57 57 57 56 56
  DC66  db 64 64 64 7B DC 94 DC AD DC C6 DC DF DC F8 DC 11
  DC76  db DD 2A DD 43 DD 64 64 64 64 64 64 64 64 64 64 64
  DC86  db 64 67 66 64 62 62 61 60 5F 5F 5F 64 64 64 64 64
  DC96  db 64 64 64 64 64 64 64 64 64 64 64 60 5E 5E 5D 5C
  DCA6  db 5B 5A 5A 5A 64 64 64 64 64 64 64 64 64 64 64 64
  DCB6  db 64 64 64 5E 5C 5B 5A 59 59 58 58 58 58 64 64 64
  DCC6  db 64 64 64 64 64 64 64 64 64 64 64 64 5C 5A 59 58
  DCD6  db 58 58 57 56 56 56 64 64 64 64 64 64 64 64 64 64
  DCE6  db 64 64 64 64 64 5B 59 58 57 56 56 55 55 55 54 64
  DCF6  db 64 64 64 64 64 64 64 64 64 64 64 64 64 64 5A 58
  DD06  db 57 56 56 55 55 54 53 53 64 64 64 64 64 64 64 64
  DD16  db 64 64 64 64 64 64 64 59 57 57 55 55 54 54 54 53
  DD26  db 53 64 64 64 64 64 64 64 64 64 64 64 64 64 64 64
  DD36  db 59 55 55 54 53 53 53 53 52 52 64 64 64 64 64 64
  DD46  db 64 64 64 64 64 64 64 64 64 59 55 55 54 53 53 52
  DD56  db 52 51 51 64 64 64 00 01 03 04 06 07 08 08 09 09
  DD66  db 0A 0A 0A 0A 0A 0B 0B 0B 0B 0B 0C 0C 0C 0C 0C 0D
  DD76  db 0D 0D 0D 0D 0E 0E 0E 0E 0E 0F 0F 0F 0F 0F 0F
SDD85:
  DD85  150000     ld BC,$0000
  DD88  3500       ld D,$00
LDD8A:
  DD8A  55         ld A,D
  DD8B  fca4a4     call SA4A4
  DD8E  65         inc D
  DD8F  11         inc BC
  DD90  e93f8016   cmp BC,$1680
  DD94  d2f4       jr CS,LDD8A
  DD96  150000     ld BC,$0000
  DD99  3500       ld D,$00
LDD9B:
  DD9B  fc8fa4     call SA48F
  DD9E  ed67       cmp A,D
  DDA0  a8         jrs F,LDDAA
  DDA1  65         inc D
  DDA2  11         inc BC
  DDA3  e93f8016   cmp BC,$1680
  DDA7  d2f2       jr CS,LDD9B
  DDA9  05         ret
LDDAA:
  DDAA  417c       set ($7C).1
  DDAC  05         ret
SDDAD:
  DDAD  17eedd     ld HL,$DDEE
  DDB0  150000     ld BC,$0000
  DDB3  3100       ld W,$00
LDDB5:
  DDB5  3513       ld D,$13
LDDB7:
  DDB7  eb07       push HL
  DDB9  340f       ld E,$0F
LDDBB:
  DDBB  e658       ld A,(HL+)
  DDBD  fca4a4     call SA4A4
  DDC0  11         inc BC
  DDC1  6c         dec E
  DDC2  b7         jrs F,LDDBB
  DDC3  eb06       pop HL
  DDC5  eb07       push HL
  DDC7  eb394001   add HL,$0140
  DDCB  340f       ld E,$0F
LDDCD:
  DDCD  e658       ld A,(HL+)
  DDCF  fca4a4     call SA4A4
  DDD2  11         inc BC
  DDD3  6c         dec E
  DDD4  b7         jrs F,LDDCD
  DDD5  eb06       pop HL
  DDD7  eb391000   add HL,$0010
  DDDB  6d         dec D
  DDDC  d7d9       jr F,LDDB7
  DDDE  eb394001   add HL,$0140
  DDE2  69         dec W
  DDE3  d7d0       jr F,LDDB5
  DDE5  24830000   ldw ($83),$0000
  DDE9  24858002   ldw ($85),$0280
  DDED  05         ret
  DDEE  db C3 D8 C3 D8 C3 D8 C3 D8 C3 D8 C3 D8 C3 D8 C3 D8
  DDFE  db 18 00 3C 00 3C 00 18 00 01 00 01 00 00 18 00 3C
  DE0E  db C0 C0 06 00 06 00 C0 00 E0 00 E0 00 C0 00 00 06
  DE1E  db 00 00 00 00 00 00 00 00 40 00 01 01 03 02 07 04
  DE2E  db 0E 0F 1F 31 3E 60 7D C0 F9 84 F3 0F EF 1F F8 34
  DE3E  db 00 00 00 80 80 80 80 80 F0 F0 F8 F8 F8 F8 80 80
  DE4E  db 00 05 00 10 00 00 00 10 00 00 00 10 00 00 00 10
  DE5E  db 00 55 00 00 FF FF FE 9C BE DC FE 9C BE DC FE 80
  DE6E  db 00 55 00 00 C0 C0 C0 C0 CF CF DF D8 DF D3 D7 DB
  DE7E  db 00 55 00 00 07 07 07 04 E7 E6 F7 76 B3 32 B3 32
  DE8E  db 00 55 00 00 E7 E7 67 64 67 66 67 66 63 62 63 62
  DE9E  db 00 55 00 00 E0 E0 60 60 63 63 67 66 67 64 65 66
  DEAE  db 00 55 00 00 01 01 01 01 F9 F9 FD 1D ED CD ED CD
  DEBE  db 00 55 00 00 F0 F0 B0 30 B0 30 B0 30 B0 30 B0 30
  DECE  db 00 00 01 41 02 02 02 42 02 02 02 42 02 02 02 42
  DEDE  db FE FE 83 FF FE 82 82 FE FE FE 82 FE FE FE 82 FE
  DEEE  db 00 00 00 00 80 80 80 80 E2 80 E0 80 E0 80 E0 80
  DEFE  db 03 00 00 60 00 60 00 03 00 07 00 07 00 03 60 60
  DF0E  db 00 18 00 3C 00 3C 00 18 00 80 00 80 18 18 3C 3C
  DF1E  db C3 1B C3 1B C3 1B C3 1B C3 1B C3 1B C3 1B C3 1B
  DF2E  db C3 D8 C3 D8 C3 D8 C3 D8 C3 D8 C3 D8 C3 D8 C3 D8
  DF3E  db 00 3C 00 18 00 01 00 01 18 18 3C 3C 3C 3C 18 18
  DF4E  db 00 06 00 C0 00 E0 00 E0 00 C0 06 06 06 06 C0 C0
  DF5E  db 07 04 05 07 07 07 43 03 01 03 01 01 03 03 00 00
  DF6E  db FD E1 FD F1 CF F0 FD CE FF AF BF C3 7F E0 1F 3F
  DF7E  db E0 E0 70 98 F8 08 F0 18 E0 F0 80 C5 80 80 00 00
  DF8E  db 00 00 00 10 00 00 00 50 00 00 00 50 00 00 00 15
  DF9E  db BE DC FE 9C BE DC FE 9C FF FF FF FF 00 00 00 55
  DFAE  db DF D0 D7 DB DF D3 DF D8 DF DF CF CF 00 00 00 55
  DFBE  db B3 32 F3 F2 33 32 73 72 F3 F3 E3 E3 00 00 00 55
  DFCE  db 63 62 63 62 63 62 63 62 E3 E3 E3 E3 00 00 00 55
  DFDE  db 67 64 65 66 67 64 67 66 E7 E7 E3 E3 00 00 00 55
  DFEE  db ED CD ED CD ED CD FD 1D FD FD F9 F9 00 00 00 55
  DFFE  db B0 30 B0 30 F0 F0 B0 30 F0 F0 F0 F0 00 00 00 55
  E00E  db 02 02 02 42 02 02 02 42 02 02 02 42 03 03 00 40
  E01E  db FE FE 00 00 00 00 06 C0 06 C0 00 00 FF FF FF 00
  E02E  db E0 80 E0 80 E0 80 E2 80 E0 80 E0 80 E0 80 E0 00
  E03E  db 60 60 03 03 07 07 07 07 03 03 60 00 60 00 03 00
  E04E  db 3C 3C 18 18 80 80 80 80 18 00 3C 00 3C 00 18 00
  E05E  db C3 1B C3 1B C3 1B C3 1B C3 1B C3 1B C3 1B C3 1B
V_FFEC/V_FFF0/V_FFF2/V_FFF4/V_FFF8:
  E06E  04         reti
V_FFFA/V_FFFC:
  E06F  e804       retn
  E071  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E081  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E091  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E0A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E0B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E0C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E0D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E0E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E0F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E101  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E111  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E121  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E131  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E141  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E151  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E161  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E171  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E181  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E191  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E1A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E1B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E1C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E1D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E1E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E1F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E201  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E211  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E221  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E231  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E241  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E251  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E261  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E271  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E281  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E291  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E2A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E2B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E2C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E2D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E2E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E2F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E301  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E311  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E321  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E331  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E341  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E351  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E361  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E371  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E381  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E391  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E3A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E3B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E3C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E3D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E3E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E3F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E401  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E411  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E421  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E431  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E441  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E451  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E461  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E471  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E481  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E491  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E4A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E4B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E4C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E4D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E4E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E4F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E501  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E511  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E521  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E531  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E541  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E551  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E561  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E571  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E581  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E591  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E5A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E5B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E5C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E5D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E5E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E5F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E601  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E611  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E621  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E631  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E641  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E651  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E661  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E671  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E681  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E691  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E6A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E6B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E6C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E6D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E6E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E6F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E701  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E711  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E721  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E731  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E741  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E751  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E761  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E771  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E781  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E791  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E7A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E7B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E7C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E7D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E7E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E7F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E801  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E811  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E821  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E831  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E841  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E851  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E861  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E871  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E881  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E891  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E8A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E8B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E8C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E8D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E8E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E8F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E901  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E911  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E921  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E931  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E941  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E951  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E961  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E971  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E981  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E991  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E9A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E9B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E9C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E9D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E9E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  E9F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EA01  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EA11  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EA21  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EA31  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EA41  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EA51  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EA61  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EA71  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EA81  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EA91  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EAA1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EAB1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EAC1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EAD1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EAE1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EAF1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EB01  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EB11  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EB21  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EB31  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EB41  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EB51  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EB61  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EB71  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EB81  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EB91  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EBA1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EBB1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EBC1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EBD1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EBE1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EBF1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EC01  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EC11  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EC21  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EC31  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EC41  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EC51  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EC61  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EC71  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EC81  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EC91  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  ECA1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  ECB1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  ECC1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  ECD1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  ECE1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  ECF1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  ED01  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  ED11  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  ED21  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  ED31  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  ED41  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  ED51  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  ED61  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  ED71  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  ED81  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  ED91  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EDA1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EDB1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EDC1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EDD1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EDE1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EDF1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EE01  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EE11  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EE21  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EE31  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EE41  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EE51  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EE61  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EE71  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EE81  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EE91  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EEA1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EEB1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EEC1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EED1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EEE1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EEF1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EF01  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EF11  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EF21  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EF31  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EF41  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EF51  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EF61  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EF71  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EF81  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EF91  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EFA1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EFB1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EFC1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EFD1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EFE1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  EFF1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F001  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F011  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F021  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F031  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F041  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F051  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F061  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F071  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F081  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F091  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F0A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F0B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F0C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F0D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F0E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F0F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F101  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F111  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F121  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F131  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F141  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F151  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F161  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F171  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F181  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F191  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F1A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F1B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F1C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F1D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F1E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F1F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F201  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F211  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F221  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F231  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F241  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F251  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F261  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F271  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F281  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F291  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F2A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F2B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F2C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F2D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F2E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F2F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F301  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F311  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F321  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F331  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F341  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F351  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F361  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F371  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F381  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F391  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F3A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F3B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F3C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F3D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F3E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F3F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F401  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F411  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F421  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F431  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F441  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F451  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F461  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F471  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F481  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F491  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F4A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F4B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F4C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F4D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F4E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F4F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F501  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F511  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F521  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F531  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F541  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F551  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F561  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F571  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F581  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F591  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F5A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F5B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F5C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F5D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F5E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F5F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F601  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F611  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F621  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F631  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F641  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F651  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F661  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F671  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F681  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F691  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F6A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F6B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F6C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F6D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F6E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F6F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F701  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F711  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F721  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F731  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F741  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F751  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F761  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F771  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F781  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F791  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F7A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F7B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F7C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F7D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F7E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F7F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F801  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F811  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F821  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F831  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F841  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F851  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F861  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F871  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F881  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F891  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F8A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F8B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F8C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F8D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F8E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F8F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F901  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F911  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F921  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F931  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F941  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F951  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F961  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F971  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F981  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F991  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F9A1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F9B1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F9C1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F9D1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F9E1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  F9F1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FA01  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FA11  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FA21  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FA31  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FA41  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FA51  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FA61  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FA71  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FA81  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FA91  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FAA1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FAB1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FAC1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FAD1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FAE1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FAF1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FB01  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FB11  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FB21  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FB31  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FB41  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FB51  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FB61  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FB71  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FB81  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FB91  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FBA1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FBB1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FBC1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FBD1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FBE1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FBF1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FC01  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FC11  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FC21  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FC31  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FC41  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FC51  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FC61  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FC71  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FC81  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FC91  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FCA1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FCB1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FCC1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FCD1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FCE1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FCF1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FD01  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FD11  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FD21  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FD31  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FD41  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FD51  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FD61  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FD71  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FD81  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FD91  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FDA1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FDB1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FDC1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FDD1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FDE1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FDF1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FE01  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FE11  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FE21  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FE31  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FE41  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FE51  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FE61  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FE71  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FE81  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FE91  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FEA1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FEB1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FEC1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FED1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FEE1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FEF1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FF01  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FF11  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FF21  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FF31  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FF41  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FF51  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FF61  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FF71  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FF81  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FF91  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FFA1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FFB1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FFC1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
  FFD1  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF E6
  FFE1  db AA 70 B3 73 B3 E7 AA ED AA 9E B9 6E E0 C0 AA 6E
  FFF1  db E0 6E E0 6E E0 7E AA 6E E0 6F E0 6F E0 00 80
