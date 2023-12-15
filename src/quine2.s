.title quine2

;This file is part of Xperiment68k
;Copyright (C) 2023 TcbnErik
;
;This program is free software: you can redistribute it and/or modify
;it under the terms of the GNU General Public License as published by
;the Free Software Foundation, either version 3 of the License, or
;(at your option) any later version.
;
;This program is distributed in the hope that it will be useful,
;but WITHOUT ANY WARRANTY; without even the implied warranty of
;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;GNU General Public License for more details.
;
;You should have received a copy of the GNU General Public License
;along with this program.  If not, see <https://www.gnu.org/licenses/>.

.include doscall.mac

LF: .equ 0x0a
Q:  .equ 0x27

PRINT: .macro str
  bsr @skip
    .dc.b str,0
    .even
  @skip:
  DOS _PRINT
  addq.l #4,sp
.endm

.text
  lea (S,pc),a3
  lea (PrintLine,pc),a2
  bsr Output
  lea (DumpLine,pc),a2
  bsr Output
  PRINT <'.dc.b 0',LF,LF,'.end',LF>
  DOS _EXIT


Output:
  lea (a3),a0
  bra lineNext
  lineLoop:
    jsr (a2)
  lineNext:
  move.b (a0),d0
  bne lineLoop
  rts

PrintLine:
  lea (a0),a1
  @@:
    cmpi.b #LF,(a0)+
  bne @b
WriteToStdout:
  move.l a0,d0
  sub.l a1,d0
  beq @f
    move.l d0,-(sp)
    pea (a1)
    move #1,-(sp)
    DOS _WRITE
    lea (10,sp),sp
  @@:
  rts

DumpLine:
  cmpi.b #LF,(a0)
  bne @f
    PRINT <'.dc.b LF',LF>
    bra 9f
  @@:
  PRINT <'.dc.b ',Q>
  lea (a0),a1
  bra 1f
  charLoop:
    cmpi.b #Q,(a0)
    addq.l #1,a0
    bne @f
      bsr WriteToStdout
      lea (a0),a1
      PRINT <',Q,',Q>
    @@:
  1:
  cmpi.b #LF,(a0)
  bne charLoop

  bsr WriteToStdout
  PRINT <Q,',LF',LF>
9:
  addq.l #1,a0
  rts

.data
S:
.dc.b '.title quine2',LF
.dc.b LF
.dc.b ';This file is part of Xperiment68k',LF
.dc.b ';Copyright (C) 2023 TcbnErik',LF
.dc.b ';',LF
.dc.b ';This program is free software: you can redistribute it and/or modify',LF
.dc.b ';it under the terms of the GNU General Public License as published by',LF
.dc.b ';the Free Software Foundation, either version 3 of the License, or',LF
.dc.b ';(at your option) any later version.',LF
.dc.b ';',LF
.dc.b ';This program is distributed in the hope that it will be useful,',LF
.dc.b ';but WITHOUT ANY WARRANTY; without even the implied warranty of',LF
.dc.b ';MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the',LF
.dc.b ';GNU General Public License for more details.',LF
.dc.b ';',LF
.dc.b ';You should have received a copy of the GNU General Public License',LF
.dc.b ';along with this program.  If not, see <https://www.gnu.org/licenses/>.',LF
.dc.b LF
.dc.b '.include doscall.mac',LF
.dc.b LF
.dc.b 'LF: .equ 0x0a',LF
.dc.b 'Q:  .equ 0x27',LF
.dc.b LF
.dc.b 'PRINT: .macro str',LF
.dc.b '  bsr @skip',LF
.dc.b '    .dc.b str,0',LF
.dc.b '    .even',LF
.dc.b '  @skip:',LF
.dc.b '  DOS _PRINT',LF
.dc.b '  addq.l #4,sp',LF
.dc.b '.endm',LF
.dc.b LF
.dc.b '.text',LF
.dc.b '  lea (S,pc),a3',LF
.dc.b '  lea (PrintLine,pc),a2',LF
.dc.b '  bsr Output',LF
.dc.b '  lea (DumpLine,pc),a2',LF
.dc.b '  bsr Output',LF
.dc.b '  PRINT <',Q,'.dc.b 0',Q,',LF,LF,',Q,'.end',Q,',LF>',LF
.dc.b '  DOS _EXIT',LF
.dc.b LF
.dc.b LF
.dc.b 'Output:',LF
.dc.b '  lea (a3),a0',LF
.dc.b '  bra lineNext',LF
.dc.b '  lineLoop:',LF
.dc.b '    jsr (a2)',LF
.dc.b '  lineNext:',LF
.dc.b '  move.b (a0),d0',LF
.dc.b '  bne lineLoop',LF
.dc.b '  rts',LF
.dc.b LF
.dc.b 'PrintLine:',LF
.dc.b '  lea (a0),a1',LF
.dc.b '  @@:',LF
.dc.b '    cmpi.b #LF,(a0)+',LF
.dc.b '  bne @b',LF
.dc.b 'WriteToStdout:',LF
.dc.b '  move.l a0,d0',LF
.dc.b '  sub.l a1,d0',LF
.dc.b '  beq @f',LF
.dc.b '    move.l d0,-(sp)',LF
.dc.b '    pea (a1)',LF
.dc.b '    move #1,-(sp)',LF
.dc.b '    DOS _WRITE',LF
.dc.b '    lea (10,sp),sp',LF
.dc.b '  @@:',LF
.dc.b '  rts',LF
.dc.b LF
.dc.b 'DumpLine:',LF
.dc.b '  cmpi.b #LF,(a0)',LF
.dc.b '  bne @f',LF
.dc.b '    PRINT <',Q,'.dc.b LF',Q,',LF>',LF
.dc.b '    bra 9f',LF
.dc.b '  @@:',LF
.dc.b '  PRINT <',Q,'.dc.b ',Q,',Q>',LF
.dc.b '  lea (a0),a1',LF
.dc.b '  bra 1f',LF
.dc.b '  charLoop:',LF
.dc.b '    cmpi.b #Q,(a0)',LF
.dc.b '    addq.l #1,a0',LF
.dc.b '    bne @f',LF
.dc.b '      bsr WriteToStdout',LF
.dc.b '      lea (a0),a1',LF
.dc.b '      PRINT <',Q,',Q,',Q,',Q>',LF
.dc.b '    @@:',LF
.dc.b '  1:',LF
.dc.b '  cmpi.b #LF,(a0)',LF
.dc.b '  bne charLoop',LF
.dc.b LF
.dc.b '  bsr WriteToStdout',LF
.dc.b '  PRINT <Q,',Q,',LF',Q,',LF>',LF
.dc.b '9:',LF
.dc.b '  addq.l #1,a0',LF
.dc.b '  rts',LF
.dc.b LF
.dc.b '.data',LF
.dc.b 'S:',LF
.dc.b 0

.end
