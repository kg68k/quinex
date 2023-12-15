.title quine2 generator

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
#{
  bsr GetStrippedSource
  lea (a0),a3
#}
  lea (PrintLine,pc),a2
  bsr Output
  lea (DumpLine,pc),a2
  bsr Output
  PRINT <'.dc.b 0',LF,LF,'.end',LF>
  DOS _EXIT

#{
GetStrippedSource:
  lea (a3),a0
  lea (a3),a1
  move.l a0,d0
  @@:
    cmpi.b #LF,(a0)+
  bne @b
  subq.l #1,a0
  lea (a0),a1
  @@:
    cmpi.b #' ',-(a1)
  bne @b
  @@:
    move.b -(a1),-(a0)
  cmpa.l d0,a1
  bne @b
  rts
#}

Output:
  lea (a3),a0
#{
  moveq #0,d2
#}
  bra lineNext
  lineLoop:
#{
    cmpi.b #'#',d0
    bne notCommand
      cmpi.b #'{',(1,a0)
      seq d2
      skipLine:
      @@:
        cmpi.b #LF,(a0)+
      bne @b
      bra lineNext
    notCommand:
    tst.b d2
    bne skipLine
#}
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
#{
.insert quine2gen.s
.dc.b 0

.end
#}
