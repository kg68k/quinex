# Makefile for QuineX

ifeq ($(notdir $(CURDIR)),src)
$(error do not execute make in src directory)
endif

AS	= has060
ASFLAGS	= -w
LD	= hlk
LDFLAGS	=

SRCS	= quine1.s quine2gen.s quine2.s quine3gen.s quine3.s
OBJS	= $(SRCS:.s=.o)
TARGETS	= $(SRCS:.s=.r)

.PHONY: all clean
.PRECIOUS: %.o

all: $(TARGETS)

quine2.s: quine2gen.r
	rm -f $@
	./$^ > $@

quine3.s: quine3gen.r
	rm -f $@
	./$^ > $@

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $^

%.r: %.o
	$(LD) $(LDFLAGS) -r -o $@ $^

clean:
	rm -f $(TARGETS) $(OBJS)

# EOF
