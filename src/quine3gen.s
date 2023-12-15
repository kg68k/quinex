.title quine3 generator

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

WORDS_PER_LINE:  .equ 8
DIGITS_PER_WORD: .equ 4


.text
ProgramStart:
  clr.l -(sp)  ;16進数4桁の終端のNUL文字
  pea (HeaderFirst,pc)
  bra first

  wordLoop:
    bsr.s @f  ;pea (Next,pc)
      Next:        .dc.b ',$',0
      Header:      .dc.b LF
      HeaderFirst: .dc.b '.dc $',0
      .even
    @@:
    dbra d7,@f
      addq.l #Header-Next,(sp)  ;既定のワード数を出力していたら改行
      first:
      moveq #WORDS_PER_LINE-1,d7
    @@:
    DOS _PRINT
    ;(sp)を16進数文字列化のバッファとして使う

    lea (sp),a2
    move (a4)+,d0
    moveq #DIGITS_PER_WORD-1,d2
    hexLoop:
      rol #4,d0
      moveq #$f,d1
      and.b d0,d1
      cmpi.b #10,d1
      bcs @f
        addi.b #-10+'a'-'0',d1
      @@:
      addi.b #'0',d1
      move.b d1,(a2)+
    dbra d2,hexLoop

    pea (sp)
    DOS _PRINT
    addq.l #4+4,sp  ;最初のDOS _PRINTの分も忘れずに戻す
  cmpa.l a4,a1
  bhi wordLoop

  bsr.s @f  ;pea (NewLine,pc)
    NewLine: .dc.b LF,0
  @@:
  DOS _PRINT
  DOS _EXIT

.end
