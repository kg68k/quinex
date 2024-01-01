.title quine1
.xref __main,_printf
_main::
  link a6,#0
  moveq #10,d0
  move.l d0,-(sp)
  move.l d0,-(sp)
  pea (39).w
  pea (S,pc)
  pea (39).w
  moveq #18-1,d1
  @@: move.l d0,-(sp)
  dbra d1,@b
  pea (S,pc)
  jbsr (_printf)
  unlk a6
  moveq #0,d0
  rts
S: .dc.b '.title quine1%c.xref __main,_printf%c_main::%c  link a6,#0%c  moveq #10,d0%c  move.l d0,-(sp)%c  move.l d0,-(sp)%c  pea (39).w%c  pea (S,pc)%c  pea (39).w%c  moveq #18-1,d1%c  @@: move.l d0,-(sp)%c  dbra d1,@b%c  pea (S,pc)%c  jbsr (_printf)%c  unlk a6%c  moveq #0,d0%c  rts%cS: .dc.b %c%s%c,0%c.end%c',0
.end
