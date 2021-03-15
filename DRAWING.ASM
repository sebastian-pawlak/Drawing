; "Drawing", Atari XL/XE Intro 64B
; (63 bytes of code + 6 bytes of header)
; code by tr1x / Agenda
; requirements: original Atari XL/XE 64KB PAL
; version: 1.0
; release date: 2021-03-13

size	equ 191
cntr1	equ 0
cntr2	equ size
zero	equ 0

rowcrs	equ $0054
colcrs	equ $0055
color2	equ $02c6
atachr	equ $02fb
random	equ $d20a
osgraph	equ $ef9c
osdraw	equ $f9c2


	org $0080

start	lda #$08
	jsr osgraph
	sty atachr
	sta color2
loop1	ldy #7
loop2	tya
	and #$03
	tax
	lda xx,x
	sta colcrs
	inx
	lda xx,x
	sta rowcrs
	tya
	pha
	jsr osdraw
	pla
	tay
loop3	inc xx+1
	dec xx+3
	bne skip1
	lda #size
	sta xx+3
	lda #zero
	sta xx+1
	lda random
	sta xx+0
	bcs start		; jmp start
skip1	dey
	bpl loop2
	bcs loop1		; jmp loop1, infinity loop


xx	.byte zero, cntr1, size, cntr2	;, zero