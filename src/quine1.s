.title quine1

.include doscall.mac

.text
  pea (S,pc)
  DOS _PRINT
  DOS _EXIT

S:
  .insert quine1.s
  .dc.b 0

.end
