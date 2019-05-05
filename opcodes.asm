;	PAGE 66
;	TITLE 'Z80 Opcodes in Alphabetical Order'
;Z80 Opcode Listing
;Z-80 CPU Instruction Set

;new 14/feb 2000
;Revised 05-May-2019 by Geoff Joy
;Assembling with zz80asm.

;This page *was* located "http://www.geocities.com/SiliconValley/Peaks/3938/".
;It can now be found at "http://zed80.com/Z80-RETRO/Resources/Z80_Programming/Z80-Instructions.txt"

;	----   ---    ----------- ---
;	opcode         t-states   explanation

	org	0000h
DD	EQU	08H
n	EQU	02H
nn	EQU	0DEADH

;	ADC   A,r       ;4 Add with carry register r to accumulator.
	ADC   A,B
	ADC   A,C
	ADC   A,D
	ADC   A,E
	ADC   A,H
	ADC   A,L
	ADC   A,(HL)    ;7 Add with carry location (HL) to acccumulator.
	ADC   A,A

	ADC   A,n       ;7 Add with carry value n to accumulator.
	ADC   A,(IX+DD) ;19 Add with carry location (IX+DD) to accumulator.
	ADC   A,(IY+DD) ;19 Add with carry location (IY + DD) to accumulator.

	ADC   HL,BC     ;15 Add with carry register pair BC to HL.
	ADC   HL,DE     ;15 Add with carry register pair DE to HL.
	ADC   HL,HL     ;15 Add with carry register pair HL to HL.
	ADC   HL,SP     ;15 Add with carry register pair SP to HL.

;	ADD   A,r       ;4 Add register r to accumulator.
	ADD   A,B
	ADD   A,C
	ADD   A,D
	ADD   A,E
	ADD   A,H
	ADD   A,L
	ADD   A,(HL)    ;7 Add location (HL) to acccumulator.
	ADD   A,A

	ADD   A,n       ;7 Add value n to accumulator.
	ADD   A,(IX+DD) ;19 Add location (IX+DD) to accumulator.
	ADD   A,(IY+DD) ;19 Add location (IY + DD) to accumulator.

	ADD   HL,BC     ;11 Add register pair BC to HL.
	ADD   HL,DE     ;11 Add register pair DE to HL.
	ADD   HL,HL     ;11 Add register pair HL to HL.
	ADD   HL,SP     ;11 Add register pair SP to HL.

	ADD   IX,BC     ;15 Add register pair BC to IX.
	ADD   IX,DE     ;15 Add register pair DE to IX.
	ADD   IX,IX     ;15 Add register pair IX to IX.
	ADD   IX,SP     ;15 Add register pair SP to IX.

	ADD   IY,BC     ;15 Add register pair BC to IY.
	ADD   IY,DE     ;15 Add register pair DE to IY.
	ADD   IY,IY     ;15 Add register pair IY to IY.
	ADD   IY,SP     ;15 Add register pair SP to IY.

;	AND   r         ; 4 Logical AND of register r to accumulator.
	AND   B
	AND   C
	AND   D
	AND   E
	AND   H
	AND   L
	AND   (HL)      ; 7 Logical AND of value at location (HL) to accumulator.
	AND   A

	AND   n         ; 7 Logical AND of value n to accumulator.
	AND   (IX+DD)   ;19 Logical AND of value at location (IX+DD) to accumulator.
	AND   (IY+DD)   ;19 Logical AND of value at location (IY + DD) to accumulator.

;	BIT   b,(IX+DD) ;20 Test bit b of location (IX+DD).
	BIT   0,(IX+DD)
	BIT   1,(IX+DD)
	BIT   2,(IX+DD)
	BIT   3,(IX+DD)
	BIT   4,(IX+DD)
	BIT   5,(IX+DD)
	BIT   6,(IX+DD)
	BIT   7,(IX+DD)

;	BIT   b,(IY+DD) ;20 Test bit b of location (IY+DD).
	BIT   0,(IY+DD)
	BIT   1,(IY+DD)
	BIT   2,(IY+DD)
	BIT   3,(IY+DD)
	BIT   4,(IY+DD)
	BIT   5,(IY+DD)
	BIT   6,(IY+DD)
	BIT   7,(IY+DD)

;	BIT   b,r       ; 8 Test bit b of register r.
	BIT   0,B
	BIT   1,B
	BIT   2,B
	BIT   3,B
	BIT   4,B
	BIT   5,B
	BIT   6,B
	BIT   7,B

	BIT   0,C
	BIT   1,C
	BIT   2,C
	BIT   3,C
	BIT   4,C
	BIT   5,C
	BIT   6,C
	BIT   7,C

	BIT   0,D
	BIT   1,D
	BIT   2,D
	BIT   3,D
	BIT   4,D
	BIT   5,D
	BIT   6,D
	BIT   7,D

	BIT   0,E
	BIT   1,E
	BIT   2,E
	BIT   3,E
	BIT   4,E
	BIT   5,E
	BIT   6,E
	BIT   7,E

;	BIT   b,(HL)    ;12 Test bit b of location (HL).
	BIT   0,(HL)
	BIT   1,(HL)
	BIT   2,(HL)
	BIT   3,(HL)
	BIT   4,(HL)
	BIT   5,(HL)
	BIT   6,(HL)
	BIT   7,(HL)

	BIT   0,A
	BIT   1,A
	BIT   2,A
	BIT   3,A
	BIT   4,A
	BIT   5,A
	BIT   6,A
	BIT   7,A

	CALL  nn        ;17 Call subroutine at location.
;	CALL  cc,nn     ;17, 10 Call subroutine at location nn if condition CC is true.
	CALL  C,nn
	CALL  NC,nn
	CALL  M,nn
	CALL  P,nn
	CALL  PE,nn
	CALL  PO,nn
	CALL  Z,nn
	CALL  NZ,nn
	CCF             ; 4 Complement carry flag.

;	CP    r         ; 4 Compare register r with accumulator.
	CP    B
	CP    C
	CP    D
	CP    E
	CP    H
	CP    L
	CP    (HL)      ; 7 Compare value at location (HL) with accumulator.
	CP    A

;	CP    n         ; 7 Compare value n with accumulator.
	CP    0
	CP    0FFH
	CP    (IX+DD)   ;19 Compare value at location (IX+DD) with accumulator.
	CP    (IY+DD)   ;19 Compare value at location (IY+DD) with accumulator.

	CPD             ;16 Comapre location (HL) and acc., decrement HL and BC,
	CPDR            ;21,16 Perform a CPD and repeat until BC=0.
	CPI             ;16 Compare location (HL) and acc., incr HL, decr BC.
	CPIR            ;21,16 Perform a CPI and repeat until BC=0.
	CPL             ; 4 Complement accumulator (1's complement).
	DAA             ; 4 Decimal adjust accumulator.

;	DEC   r         ; 4 Decrement register r.
	DEC   B
	DEC   C
	DEC   D
	DEC   E
	DEC   H
	DEC   L
	DEC   (HL)      ;11 Decrement value at location (HL).
	DEC   A

	DEC   (IX+DD)   ;23 Decrement value at location (IX+DD).
	DEC   (IY+DD)   ;23 Decrement value at location (IY+DD).

	DEC   IX        ;10 Decrement IX.
	DEC   IY        ;10 Decrement IY.
	DEC   BC        ; 6 Decrement register pair BC.
	DEC   DE        ; 6 Decrement register pair DE.
	DEC   HL        ; 6 Decrement register pair HL.
	DEC   SP        ; 6 Decrement register pair SP.

	DI              ; 4 Disable interrupts. (except NMI at 0066h)

TAG0:
;	DJNZ  n         ;13,8 Decrement B and jump relative if B<>0.
	DJNZ   TAG0

	EI              ; 4 Enable interrupts.
	EX    (SP),HL   ;19 Exchange the location (SP) and HL.
	EX    (SP),IX   ;23 Exchange the location (SP) and IX.
	EX    (SP),IY   ;23 Exchange the location (SP) and IY.
	EX    AF,AF'    ; 4 Exchange the contents of AF and AF'.
	EX    DE,HL     ; 4 Exchange the contents of DE and HL.
	EXX             ; 4 Exchange the contents of BC,DE,HL with BC',DE',HL'.
	HALT            ; 4 Halt computer and wait for interrupt.
	IM    0         ; 8 Set interrupt mode 0. (instruction on data bus by int device)
	IM    1         ; 8 Set interrupt mode 1. (rst 38)
	IM    2         ; 8 Set interrupt mode 2. (vector jump)

	IN    A,(n)     ;11 Load the accumulator with input from device n.
;	IN    r,(c)     ;12 Load the register r with input from device (C).
	IN    B,(C)
	IN    C,(C)
	IN    D,(C)
	IN    E,(C)
	IN    H,(C)
	IN    L,(C)
	IN    A,(C)

;	INC   r         ; 4 Increment register r.
	INC   B
	INC   C
	INC   D
	INC   E
	INC   H
	INC   L
	INC   (HL)      ;11 Increment location (HL).
	INC   A

	INC   (IX+DD)   ;23 Increment location (IX+DD).
	INC   (IY+DD)   ;23 Increment location (IY+DD).

	INC   IX        ;10 Increment IX.
	INC   IY        ;10 Increment IY.
	INC   BC        ; 6 Increment register pair BC.
	INC   DE        ; 6 Increment register pair DE.
	INC   HL        ; 6 Increment register pair HL.
	INC   SP        ; 6 Increment register pair SP.

	IND             ;16 (HL)=Input from port (C). Decrement HL and B.
	INDR            ;21,16 Perform an IND and repeat until B=0.
	INI             ;16 (HL)=Input from port (C). HL=HL+1. B=B-1.
	INIR            ;21,16 Perform an INI and repeat until B=0.

	JP    nn        ;10 Unconditional jump to location nn
;	JP    cc,nn     ;10 Jump to location nn if condition cc is true.
	JP    C,nn
	JP    NC,nn
	JP    M,nn
	JP    P,nn
	JP    PE,nn
	JP    PO,nn
	JP    Z,nn
	JP    NZ,nn

	JP    (HL)      ; 4 Unconditional jump to location (HL).
	JP    (IX)      ; 8 Unconditional jump to location (IX).
	JP    (IY)      ; 8 Unconditional jump to location (IY).

TAG1:
;	JR    C,n       ;12,7 Jump relative to PC+n if carry=1.
	JR    C,TAG1

;	JR    n         ;12 Unconditional jump relative to PC+n.
	JR    TAG1
;	JR    NC,n      ;12,7 Jump relative to PC+n if carry=0.
	JR    NC, TAG1

;	JR    NZ,n      ;12,7 Jump relative to PC+n if non zero (Z=0).
	JR    NZ, TAG1
;	JR    Z,n       ;12,7 Jump relative to PC+n if zero (Z=1).
	JR    Z, TAG1

	LD    A,(BC)    ; 7 Load accumulator with value at location (BC).
	LD    A,(DE)    ; 7 Load accumulator with value at location (DE).
	LD    A,I       ; 9 Load accumulator with I.(interrupt vector register)
	LD    A,(nn)    ;13 Load accumulator with value at location nn.
	LD    A,R       ; 9 Load accumulator with R.(memory refresh register)
	LD    (BC),A    ; 7 Load location (BC) with accumulator.
	LD    (DE),A    ; 7 Load location (DE) with accumulator.
	LD    (HL),n    ;10 Load location (HL) with value n.
	LD    (IX+DD),n ;19 Load location (IX+DD) with value n.
	LD    (IY+DD),n ;19 Load location (IY+DD) with value n.
	LD    (nn),A    ;13 Load location (nn) with accumulator.

	LD    (nn),BC   ;20 Load location (nn) with register pair BC.
	LD    (nn),DE   ;20 Load location (nn) with register pair DE.
	LD    (nn),HL   ;16 Load location (nn) with HL.
	LD    (nn),SP   ;20 Load location (nn) with register pair SP.

	LD    (nn),IX   ;20 Load location (nn) with IX.
	LD    (nn),IY   ;20 Load location (nn) with IY.

	LD    BC,nn     ;10 Load register pair BC with nn.
	LD    DE,nn     ;10 Load register pair DE with nn.
	LD    HL,nn     ;10 Load register pair HL with nn.
	LD    SP,nn     ;10 Load register pair SP with nn.

	LD    BC,(nn)   ;20 Load register pair BC with value at location (nn).
	LD    DE,(nn)   ;20 Load register pair DE with value at location (nn).
	LD    HL,(nn)   ;16 Load HL with value at location (nn). (L-first)
	LD    SP,(nn)   ;20 Load register pair SP with value at location (nn).

;	LD    (HL),r    ; 7 Load location (HL) with register r.
	LD    (HL),B
	LD    (HL),C
	LD    (HL),D
	LD    (HL),E
	LD    (HL),H
	LD    (HL),L
	LD    (HL),A

;	LD    (IX+DD),r ;19 Load location (IX+DD) with register r.
	LD    (IX+DD),B
	LD    (IX+DD),C
	LD    (IX+DD),D
	LD    (IX+DD),E
	LD    (IX+DD),H
	LD    (IX+DD),L
	LD    (IX+DD),A

;	LD    (IY+DD),r ;19 Load location (IY+DD) with register r.
	LD    (IY+DD),B
	LD    (IY+DD),C
	LD    (IY+DD),D
	LD    (IY+DD),E
	LD    (IY+DD),H
	LD    (IY+DD),L
	LD    (IY+DD),A

	LD    I,A       ; 9 Load I with accumulator.
	LD    IX,nn     ;14 Load IX with value nn.
	LD    IX,(nn)   ;20 Load IX with value at location (nn).
	LD    IY,nn     ;14 Load IY with value nn.
	LD    IY,(nn)   ;20 Load IY with value at location (nn).
	LD    R,A       ; 9 Load R with accumulator.

;	LD    r,(HL)    ; 7 Load register r with value at location (HL).
	LD    B,(HL)
	LD    C,(HL)
	LD    D,(HL)
	LD    E,(HL)
	LD    H,(HL)
	LD    L,(HL)
	LD    A,(HL)

;	LD    r,(IX+DD) ;19 Load register r with value at location (IX+DD).
	LD    B,(IX+DD)
	LD    C,(IX+DD)
	LD    D,(IX+DD)
	LD    E,(IX+DD)
	LD    H,(IX+DD)
	LD    L,(IX+DD)
	LD    A,(IX+DD)

;	LD    r,(IY+DD) ;19 Load register r with value at location (IY+DD).
	LD    B,(IY+DD)
	LD    C,(IY+DD)
	LD    D,(IY+DD)
	LD    E,(IY+DD)
	LD    H,(IY+DD)
	LD    L,(IY+DD)
	LD    A,(IY+DD)

;	LD    r,n       ; 7 Load register r with value n.
	LD    B,0
	LD    B,1
	LD    B,2
	LD    B,3
	LD    B,4
	LD    B,5
	LD    B,6

	LD    C,0
	LD    C,1
	LD    C,2
	LD    C,3
	LD    C,4
	LD    C,5
	LD    C,6

	LD    D,0
	LD    D,1
	LD    D,2
	LD    D,3
	LD    D,4
	LD    D,5
	LD    D,6

	LD    E,0
	LD    E,1
	LD    E,2
	LD    E,3
	LD    E,4
	LD    E,5
	LD    E,6

	LD    H,0
	LD    H,1
	LD    H,2
	LD    H,3
	LD    H,4
	LD    H,5
	LD    H,6

	LD    L,0
	LD    L,1
	LD    L,2
	LD    L,3
	LD    L,4
	LD    L,5
	LD    L,6

	LD    A,0
	LD    A,1
	LD    A,2
	LD    A,3
	LD    A,4
	LD    A,5
	LD    A,6

;	LD    r,r'      ; 4 Load register r with register r'.
	LD    A,B
	LD    A,C
	LD    A,D
	LD    A,E
	LD    A,H
	LD    A,L
	LD    A,A

	LD    B,B
	LD    B,C
	LD    B,D
	LD    B,E
	LD    B,H
	LD    B,L
	LD    B,A

	LD    C,B
	LD    C,C
	LD    C,D
	LD    C,E
	LD    C,H
	LD    C,L
	LD    C,A

	LD    D,B
	LD    D,C
	LD    D,D
	LD    D,E
	LD    D,H
	LD    D,L
	LD    D,A

	LD    E,B
	LD    E,C
	LD    E,D
	LD    E,E
	LD    E,H
	LD    E,L
	LD    E,A

	LD    H,B
	LD    H,C
	LD    H,D
	LD    H,E
	LD    H,H
	LD    H,L
	LD    H,A

	LD    L,B
	LD    L,C
	LD    L,D
	LD    L,E
	LD    L,H
	LD    L,L
	LD    L,A

	LD    SP,HL     ; 6 Load SP with HL.
	LD    SP,IX     ;10 Load SP with IX.
	LD    SP,IY     ;10 Load SP with IY.
	LDD             ;16 Load location (DE) with location (HL), decrement DE,HL,BC.
	LDDR            ;21,16 Perform an LDD and repeat until BC=0.
	LDI             ;16 Load location (DE) with location (HL), incr DE,HL; decr BC.
	LDIR            ;21,17 Perform an LDI and repeat until BC=0.
	NEG             ; 8 Negate accumulator (2's complement).
	NOP             ; 4 No operation.

;	OR    r         ; 4 Logical OR of register r and accumulator.
	OR    B
	OR    C
	OR    D
	OR    E
	OR    H
	OR    L
	OR    (HL)      ; 7 Logical OR of value at location (HL) and accumulator.
	OR    A

	OR    (IX+DD)   ;19 Logical OR of value at location (IX+DD) and accumulator.
	OR    (IY+DD)   ;19 Logical OR of value at location (IY+DD) and accumulator.

;	OR    n         ; 7 Logical OR of value n and accumulator.
	OR    1
	OR    0
	OR    0FFH

	OTDR            ;21,16 Perform an OUTD and repeat until B=0.
	OTIR            ;21,16 Perform an OTI and repeat until B=0.
;	OUT   (C),r     ;12 Load output port (C) with register r.
	OUT   (C),B     ;12 Load output port (C) with register r.
	OUT   (C),C     ;12 Load output port (C) with register r.
	OUT   (C),D     ;12 Load output port (C) with register r.
	OUT   (C),E     ;12 Load output port (C) with register r.
	OUT   (C),H     ;12 Load output port (C) with register r.
	OUT   (C),L     ;12 Load output port (C) with register r.
	OUT   (C),A     ;12 Load output port (C) with register r.
	OUT   (n),A     ;11 Load output port (n) with accumulator.
	OUTD            ;16 Load output port (C) with (HL), decrement HL and B.
	OUTI            ;16 Load output port (C) with (HL), incr HL, decr B.
	POP   IX        ;14 Load IX with top of stack.
	POP   IY        ;14 Load IY with top of stack.
	POP   BC        ;10 Load register pair BC with top of stack.
	POP   DE        ;10 Load register pair DE with top of stack.
	POP   HL        ;10 Load register pair HL with top of stack.
	POP   AF        ;10 Load register pair AF with top of stack.

	PUSH  IX        ;15 Load IX onto stack.
	PUSH  IY        ;15 Load IY onto stack.
	PUSH  BC        ;11 Load register pair BC onto stack.
	PUSH  DE        ;11 Load register pair DE onto stack.
	PUSH  HL        ;11 Load register pair HL onto stack.
	PUSH  AF        ;11 Load register pair AF onto stack.

;	RES   b,r       ; 8 Reset bit b of register r.
	RES   0,B
	RES   1,B
	RES   2,B
	RES   3,B
	RES   4,B
	RES   5,B
	RES   6,B
	RES   7,B

	RES   0,C
	RES   1,C
	RES   2,C
	RES   3,C
	RES   4,C
	RES   5,C
	RES   6,C
	RES   7,C

	RES   0,D
	RES   1,D
	RES   2,D
	RES   3,D
	RES   4,D
	RES   5,D
	RES   6,D
	RES   7,D

	RES   0,E
	RES   1,E
	RES   2,E
	RES   3,E
	RES   4,E
	RES   5,E
	RES   6,E
	RES   7,E

	RES   0,H
	RES   1,H
	RES   2,H
	RES   3,H
	RES   4,H
	RES   5,H
	RES   6,H
	RES   7,H

	RES   0,L
	RES   1,L
	RES   2,L
	RES   3,L
	RES   4,L
	RES   5,L
	RES   6,L
	RES   7,L

	RES   0,A
	RES   1,A
	RES   2,A
	RES   3,A
	RES   4,A
	RES   5,A
	RES   6,A
	RES   7,A

;	RES   b,(HL)    ;15 Reset bit b in value at location (HL).
	RES   0,(HL)
	RES   1,(HL)
	RES   2,(HL)
	RES   3,(HL)
	RES   4,(HL)
	RES   5,(HL)
	RES   6,(HL)
	RES   7,(HL)

;	RES   b,(IX+DD) ;23 Reset bit b in value at location (IX+DD).
	RES   0,(IX+DD)
	RES   1,(IX+DD)
	RES   2,(IX+DD)
	RES   3,(IX+DD)
	RES   4,(IX+DD)
	RES   5,(IX+DD)
	RES   6,(IX+DD)
	RES   7,(IX+DD)

;	RES   b,(IY+DD) ;23 Reset bit b in value at location (IY+DD).
	RES   0,(IY+DD)
	RES   1,(IY+DD)
	RES   2,(IY+DD)
	RES   3,(IY+DD)
	RES   4,(IY+DD)
	RES   5,(IY+DD)
	RES   6,(IY+DD)
	RES   7,(IY+DD)

	RET             ;10 Return from subroutine.
;	RET   cc        ;11,5 Return from subroutine if condition cc is true.
	RETI            ;14 Return from interrupt.	JP    C,nn
	RET    NC
	RET    M
	RET    P
	RET    PE
	RET    PO
	RET    Z
	RET    NZ

	RETN            ;14 Return from non-maskable interrupt.

;	RL    r         ; 8 Rotate left through register r.
	RL    B
	RL    C
	RL    D
	RL    E
	RL    H
	RL    L
	RL    (HL)      ;15 Rotate left through value at location (HL).
	RL    A

	RL    (IX+DD)   ;23 Rotate left through value at location (IX+DD).
	RL    (IY+DD)   ;23 Rotate left through value at location (IY+DD).
	RLA             ; 4 Rotate left accumulator through carry.

;	RLC   r         ; 8 Rotate register r left circular.
	RLC   B
	RLC   C
	RLC   D
	RLC   E
	RLC   H
	RLC   L
	RLC   (HL)      ;15 Rotate location (HL) left circular.
	RLC   A

	RLC   (IX+DD)   ;23 Rotate location (IX+DD) left circular.
	RLC   (IY+DD)   ;23 Rotate location (IY+DD) left circular.

	RLCA            ; 4 Rotate left circular accumulator.
	RLD             ;18 Rotate digit left and right between accumulator and (HL).

;	RR    r         ; 8 Rotate right through carry register r.
	RR    B
	RR    C
	RR    D
	RR    E
	RR    H
	RR    L
	RR    (HL)      ;15 Rotate right through carry location (HL).
	RR    A

	RR    (IX+DD)   ;23 Rotate right through carry location (IX+DD).
	RR    (IY+DD)   ;23 Rotate right through carry location (IY+DD).

	RRA             ; 4 Rotate right accumulator through carry.

;	RRC   r         ; 8 Rotate register r right circular.
	RRC   B
	RRC   C
	RRC   D
	RRC   E
	RRC   H
	RRC   L
	RRC   (HL)      ;15 Rotate value at location (HL) right circular.
	RRC   A

	RRC   (IX+DD)   ;23 Rotate value at location (IX+DD) right circular.
	RRC   (IY+DD)   ;23 Rotate value at location (HL + DD) right circular.

	RRCA            ; 4 Rotate right circular accumulator.
	RRD             ;18 Rotate digit right and left between accumulator and (HL).

	RST   00h       ;11 Restart to location 0000h.
	RST   08h       ;11 Restart to location 0008h.
	RST   10h       ;11 Restart to location 0010h.
	RST   18h       ;11 Restart to location 0018h.
	RST   20h       ;11 Restart to location 0020h.
	RST   28h       ;11 Restart to location 0028h.
	RST   30h       ;11 Restart to location 0030h.
	RST   38h       ;11 Restart to location 0038h.

;	SBC   A,r       ; 4 Subtract register r from accumulator with carry.
	SBC   A,B
	SBC   A,C
	SBC   A,D
	SBC   A,E
	SBC   A,H
	SBC   A,L
	SBC   A,A

	SBC   A,(HL)    ; 7 Subtract value at location (HL) from accu. with carry.
	SBC   A,(IX+DD) ;19 Subtract value at location (IX+DD) from accu. with carry.
	SBC   A,(IY+DD) ;19 Subtract value at location (IY+DD) from accu. with carry.

	SBC   A,n       ; 7 Subtract value n from accumulator with carry.

	SBC   HL,BC     ;15 Subtract register pair BC from HL with carry.
	SBC   HL,DE     ;15 Subtract register pair DE from HL with carry.
	SBC   HL,HL     ;15 Subtract register pair HL from HL with carry.
	SBC   HL,SP     ;15 Subtract register pair SP from HL with carry.

	SCF             ; 4 Set carry flag (C=1).

;	SET   b,r       ; 8 Set bit b of register r.
	SET   1,B
	SET   2,C
	SET   3,D
	SET   4,E
	SET   5,H
	SET   6,L
	SET   7,A
	SET   0,A

;	SET   b,(HL)    ;15 Set bit b of location (HL).
	SET   0,(HL)
	SET   1,(HL)
	SET   2,(HL)
	SET   3,(HL)
	SET   4,(HL)
	SET   5,(HL)
	SET   6,(HL)
	SET   7,(HL)

;	SET   b,(IX+DD) ;23 Set bit b of location (IX+DD).
	SET   0,(IX+DD)
	SET   1,(IX+DD)
	SET   2,(IX+DD)
	SET   3,(IX+DD)
	SET   4,(IX+DD)
	SET   5,(IX+DD)
	SET   6,(IX+DD)
	SET   7,(IX+DD)

;	SET   b,(IY+DD) ;23 Set bit b of location (IY+DD).
	SET   0,(IY+DD)
	SET   1,(IY+DD)
	SET   2,(IY+DD)
	SET   3,(IY+DD)
	SET   4,(IY+DD)
	SET   5,(IY+DD)
	SET   6,(IY+DD)
	SET   7,(IY+DD)

;	SLA   r         ; 8 Shift register r left arithmetic.
	SLA   B
	SLA   C
	SLA   D
	SLA   E
	SLA   H
	SLA   L
	SLA   (HL)     ;15 Shift value at location (HL) left arithmetic.
	SLA   A

	SLA   (IX+DD)  ;23 Shift value at location (IX+DD) left arithmetic.
	SLA   (IY+DD)  ;23 Shift value at location (IY+DD) left arithmetic.

;	SRA   r        ; 8 Shift register r right arithmetic.
	SRA   B
	SRA   C
	SRA   D
	SRA   E
	SRA   H
	SRA   L
	SRA   (HL)     ;15 Shift value at location (HL) right arithmetic.
	SRA   A

	SRA   (IX+DD)  ;23 Shift value at location (IX+DD) right arithmetic.
	SRA   (IY+DD)  ;23 Shift value at location (IY+DD) right arithmetic.

;	SRL   r        ; 8 Shift register r right logical.
	SRL   B
	SRL   C
	SRL   D
	SRL   E
	SRL   H
	SRL   L
	SRL   (HL)     ;15 Shift value at location (HL) right logical.
	SRL   A

	SRL   (IX+DD)  ;23 Shift value at location (IX+DD) right logical.
	SRL   (IY+DD)  ;23 Shift value at location (IY+DD) right logical.

;	SUB   r        ; 4 Subtract register r from accumulator.
	SUB   B
	SUB   C
	SUB   D
	SUB   E
	SUB   H
	SUB   L
	SUB   (HL)     ; 7 Subtract location (HL) from accumulator.
	SUB   A

	SUB   (IX+DD)  ;19 Subtract location (IX+DD) from accumulator.
	SUB   (IY+DD)  ;19 Subtract location (IY+DD) from accumulator.

	SUB   n        ; 7 Subtract value n from accumulator.

;	XOR   r        ; 4 Exclusive OR register r and accumulator.
	XOR   B
	XOR   C
	XOR   D
	XOR   E
	XOR   H
	XOR   L
	XOR   (HL)     ; 7 Exclusive OR value at location (HL) and accumulator.
	XOR   A

	XOR   (IX+DD)  ;19 Exclusive OR value at location (IX+DD) and accumulator.
	XOR   (IY+DD)  ;19 Exclusive OR value at location (IY+DD) and accumulator.

	XOR   n        ; 7 Exclusive OR value n and accumulator.

;Undocumented opcodes

;	SLL	r	       ; 8 Shift logical left register r (sets bit 0)
	SLL	B	       ;Equivalent: LD B, (2*B)+1 aka B = 2 * B + 1;
	SLL	C
	SLL	D
	SLL E
	SLL H
	SLL L
	SLL (HL)
	SLL A

;	SLL   (IX+DD),r	;23 Shift left logical at loctation (IX+DD) and store in register r
	SLL   (IX+DD),B	;Equivalent: LD r, (2*(IX+DD))+1
	SLL   (IX+DD),C
	SLL   (IX+DD),D
	SLL   (IX+DD),E
	SLL   (IX+DD),H
	SLL   (IX+DD),L
	SLL   (IX+DD)		;Shift value at location (IX+DD) left logical.
	SLL   (IX+DD),A

	SLL   (IY+DD),B
	SLL   (IY+DD),C
	SLL   (IY+DD),D
	SLL   (IY+DD),E
	SLL   (IY+DD),H
	SLL   (IY+DD),L
	SLL   (IY+DD)		;Shift value at location (IY+DD) left logical.
	SLL   (IY+DD),A
END:
