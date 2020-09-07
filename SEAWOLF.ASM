;_______________________
;      1st Macro
;_______________________
PRINT_LINE MACRO A,B,C,D		;draw a line by taking column, row and color as argument
LOCAL 	L1
MOV 	AH,0CH
MOV 	BH,0
MOV 	AL,D
MOV 	CX,A
MOV 	VAR1,CX
ADD 	VAR1,C
MOV 	DX,B
L1: 	INT 10H
INC 	CX
CMP 	CX,VAR1
JL	L1
ENDM
;-----------------------

;_______________________
;      2nd Macro
;_______________________
PRINT_SHIP MACRO A,B,C,D		;draw a ship by taking in column, row and colour as parameters

PRINT_LINE A,B,C,D
PUSH 	A
SUB	A,2
PRINT_LINE A,B-1,C+4,D
SUB 	A,2
PRINT_LINE A,B-2,C+8,D
SUB 	A,2
PRINT_LINE A,B-3,C+12,D
SUB 	A,2
PRINT_LINE A,B-4,C+16,D
SUB 	A,2
PRINT_LINE A,B-5,C+20,D
SUB 	A,2
PRINT_LINE A,B-6,C+24,D
POP 	A
PUSH	A
ADD 	A,40
PRINT_LINE A,B-7,20,D
PRINT_LINE A,B-8,20,D
PRINT_LINE A,B-9,20,D
PRINT_LINE A,B-10,20,D
PRINT_LINE A,B-11,20,D
ADD 	A,10
PRINT_LINE A,B-12,0,D
PRINT_LINE A,B-13,0,D
PRINT_LINE A,B-14,0,D
PRINT_LINE A,B-15,0,D
PRINT_LINE A,B-16,0,D
PRINT_LINE A,B-17,0,D
PRINT_LINE A,B-18,0,D
POP A
ENDM
;----------------------

;_______________________
;      3rd Macro
;_______________________
PRINT_GUN MACRO A,B		;Draw a gun by getting the column and row values as parameters
LOCAL L1,EXIT,EXIT2,L2
PUSH 	VAR3
MOV 	CX,0
L1:
PUSH 	CX
PRINT_LINE A,VAR3,40,B
DEC	 VAR3
POP 	CX
INC 	CX
CMP 	CX,20
JE 	EXIT
JMP 	L1
EXIT:
MOV 	CX,0
PUSH 	A
ADD 	A,10
L2:
PUSH 	CX
PRINT_LINE A,VAR3,20,B
DEC 	VAR3
POP 	CX
INC 	CX
CMP 	CX,30
JE 	EXIT2
JMP 	L2
EXIT2:
POP 	A
POP 	VAR3
ENDM
;------------------------

;_______________________
;      4th Macro
;_______________________
PRINT_BALL MACRO A,B,C		;draw a ball that the gun will shoot
MOV 	AH,0CH	
MOV 	BH,0			;A argument is column value
MOV 	AL,C			;B argument is row value
MOV	CX,A			;C arguemtn is the color value
MOV 	DX,B
INT 	10H
PUSH A
ADD A,1
MOV 	CX,A
INT 	10H
ADD A,1
MOV 	CX,A
INT	10H
ADD A,1
MOV 	CX,A
INT	10H
POP A
PUSH A
PUSH B
SUB B,1
MOV 	CX,A
MOV 	DX,B
INT 	10H
ADD A,1
MOV 	CX,A
INT 	10H
ADD A,1
MOV 	CX,A
INT	10H
ADD A,1
MOV 	CX,A
INT	10H
POP B
POP A
PUSH A
PUSH B
SUB B,2
MOV 	CX,A
MOV 	DX,B
INT 	10H
ADD A,1
MOV 	CX,A
INT 	10H
ADD A,1
MOV 	CX,A
INT	10H
ADD A,1
MOV 	CX,A
INT	10H
POP B
POP A
PUSH A
PUSH B
SUB B,3
MOV 	CX,A
MOV 	DX,B
INT 	10H
ADD A,1
MOV 	CX,A
INT 	10H
ADD A,1
MOV 	CX,A
INT	10H
ADD A,1
MOV 	CX,A
INT	10H
POP B
POP A
ENDM
;------------------------

;_______________________
;      5th Macro
;_______________________
POWER_BAR MACRO	A,B,C		;macro that will print the power bar
MOV 	AH,6		
MOV 	CH,A
MOV 	CL,03
MOV 	DH,B
MOV 	DL,06
MOV 	BH,C
MOV 	AL,0
INT 	10H
ENDM
;------------------------
;_______________________
;      6th Macro
;_______________________

PRINT MACRO STRING 
MOV AH,09H
MOV DX,OFFSET STRING
INT 21H
ENDM
;------------------------
;_______________________
;      7th Macro
;_______________________

MOVCURSOR MACRO A,B
MOV AH,02
MOV BH,0H
MOV DH,A
MOV DL,B
INT 10H
ENDM
;------------------------

.MODEL SMALL
.STACK 100H
;______________________________________________________________
;                       DATA
.DATA
T1  DB '-----------------------------------------------$'
T2  DB '||                                           ||$'
T3  DB '||        WELCOME TO THE SEAWORLD            ||$'
T4  DB '-----------------------------------------------$'
T5  DB '||                                           ||$'
T6  DB 'PRESS LEFT AND RIGHT ARROW KEYS TO MOVE THE GUN$'
T7  DB '||                                           ||$'
T8  DB '||          PRESS SPACE TO SHOOT             ||$'
T9  DB '||                                           ||$'
T10 DB '||     PRESS ENTRE TO PLAY THE GAME          ||$'
T11 DB '===============================================$'
VAR1 	DW ?
VAR2 	DW 10
VAR3 	DW 475
VAR4 	DW 280
VAR5 	DW 298
VAR6 	DW 425
VAR7	DB 11
VAR8	DB 11
TRIGGER DB 0
KEY 	DB ?
KEY2	DB ?
FLAG 	DB ?
NEW 	DW ?,?
OLD 	DW ?,?

;______________________________________________________________
;                       CODE
.CODE
MAIN PROC
MOV 	AX,@DATA
MOV 	DS,AX

MOV AH,0
MOV AL,3
INT 10H

MOV AH,6
MOV CX,0000H
MOV DX,184FH
MOV BH,43H
MOV AL,0
INT 10H

MOV AH,6
MOV CX,050EH
MOV DX,123EH
MOV BH,2FH
MOV AL,0
INT 10H

MOVCURSOR 06H,0FH
PRINT T1
MOVCURSOR 07H,0FH
PRINT T2
MOVCURSOR 08H,0FH
PRINT T3
MOVCURSOR 09H,0FH
PRINT T4
MOVCURSOR 0AH,0FH
PRINT T5
MOVCURSOR 0BH,0FH
PRINT T6
MOVCURSOR 0CH,0FH
PRINT T7
MOVCURSOR 0DH,0FH
PRINT T2
MOVCURSOR 0EH,0FH
PRINT T2
MOVCURSOR 0FH,0FH
PRINT T8
MOVCURSOR 10H,0FH
PRINT T9
MOVCURSOR 11H,0FH
PRINT T10
MOVCURSOR 12H,0FH
PRINT T11

MOV AH,1
INT 21H

CMP AL,0DH
JE TXT
JMP EXIT2

TXT:

MOV 	AH,0		;set to graphics mode no. 12H
MOV 	AL,12H
INT 	10H
MOV 	AH,0BH		;set the background colour to cyan
MOV 	BL,3
INT 10H

MOV 	NEW,OFFSET CHECK_KEY_PRESSED
MOV 	NEW+2,CS
MOV 	AL,9
LEA 	DI,OLD
LEA 	SI,NEW
CALL 	SETUP_INT

MOV 	AH,6		;make a box of gray color that will act as the sky
MOV 	CX,0000H
MOV 	DX,044FH
MOV 	BH,03h
MOV 	AL,0
INT 	10H

POWER_BAR VAR7,23,4	;create a power bar
LABEL1:

CMP KEY2,0
JNE A2
PUSH 	AX		;change the value of column of the ball with respect to
MOV 	AX,VAR4		;change in the column value of gun
ADD 	AX,18
MOV 	VAR5,AX
POP 	AX
A2:

CMP KEY,57
JNE A3
MOV KEY2,57
A3:

CMP 	VAR6,70		;make the projectile disappear when it goes beyond the water
JNLE 	A1
MOV 	KEY2,0
MOV 	KEY,0
MOV 	VAR6,425	;reset the row value of the projectile when the ball goes beyond water
PUSH 	AX
MOV 	AX,VAR4		;move the value of the gun column value into the projectile column value
ADD 	AX,18
MOV 	VAR5,AX
POP	AX

A1:
PRINT_GUN VAR4,8

PUSH VAR2
PRINT_SHIP VAR2,80,100,4
CMP KEY2,57		;compare key2 value with space ASCII to move the ball
JE H			
JMP Q
H:
PRINT_BALL VAR5,VAR6,10
Q:
CALL TIME_DELAY		;cause time delay
CALL TIME_DELAY
CALL TIME_DELAY
CALL TIME_DELAY
CALL TIME_DELAY
CALL TIME_DELAY
CMP KEY2,57
JE W
JMP Z
W:

CMP 	VAR6,80		;comparison to see if the ball has hit the ship or not
JG 	Q4
MOV 	AX,VAR2
SUB 	AX,20
CMP 	VAR5,AX
JNGE 	A4
ADD 	AX,120
CMP 	VAR5,AX
JNLE 	A4
POP 	VAR2
JMP 	A10		;jump to label a10 to cause beep and reposition the ship
A4:
CMP 	TRIGGER,0	;trigger will be zero if the ball does not hit the ship
JNE 	Q4
MOV 	AH,VAR7
ADD 	VAR8,3
MOV 	AL,VAR8
MOV 	VAR7,AL
CMP 	VAR8,23
JNE 	Q5
POWER_BAR AH,VAR8,0	;when the power bar drops to row 23 it will disappear and game will exit
JMP EXIT
Q5:
POWER_BAR AH,VAR8,0

Q4:
MOV 	TRIGGER,0	;set the trigger back to 0 if the ball misses the ship
CMP 	VAR6,80		;if the ball goes beyond water change the ball color to the color of sky
JNL 	A7
JMP 	A8
A7:
PRINT_BALL VAR5,VAR6,0
JMP A9
A8:
PRINT_BALL VAR5,VAR6,3
A9:

SUB 	VAR6,10
Z:
POP 	VAR2
PUSH 	VAR2
PRINT_SHIP VAR2,80,100,3
POP 	VAR2
CMP 	VAR2,630
JNE 	A5
MOV 	VAR2,10
JMP 	A6
A5:
ADD 	VAR2,10

A6:
CMP 	FLAG,1		;check to see if the flag variable is set
JNE 	EQL
CMP 	KEY,1
JNE 	EQL
JMP 	EXIT
EQL:
CMP 	KEY,77		;if the flag is set than increment in the column of the gun 
JE 	E 
JMP 	F
E:
PRINT_GUN VAR4,0
CMP 	VAR4,580
JG	Z1
ADD 	VAR4,10
Z1:
MOV 	KEY,0
MOV 	FLAG,0
JMP 	LABEL1
F:
CMP 	KEY,75		;a check to see if a left arrow key is pressed
JE 	G		;if the left arrow ke is pressed than descrement the column value of the gun
JMP 	LABEL1
G:
PRINT_GUN VAR4,0
CMP	VAR4,70
JL	Z2
SUB 	VAR4,10
Z2:
MOV 	KEY,0
MOV 	FLAG,0
JMP 	LABEL1

A10:			;if the ball hits the ship it the program flow will move here
MOV 	TRIGGER,1
MOV 	AL,VAR7
CMP 	VAR7,11
JLE 	Q6
SUB 	AL,3
POWER_BAR AL,VAR8,4	;replenish the power bar to the previous point
JMP Q7
Q6:	
POWER_BAR AL,VAR8,4	
Q7:	
SUB VAR8,3	
CALL BEEP		   ;if the ball hits the ship sound a beep 
PRINT_SHIP VAR2,80,100,3
CALL TIME_DELAY
CALL TIME_DELAY
CALL TIME_DELAY
CALL TIME_DELAY				
PRINT_SHIP VAR2,80,100,4	;flicker the the ship three times 
CALL TIME_DELAY
CALL TIME_DELAY
CALL TIME_DELAY
CALL TIME_DELAY
PRINT_SHIP VAR2,80,100,3
CALL TIME_DELAY
CALL TIME_DELAY
CALL TIME_DELAY
CALL TIME_DELAY
PRINT_SHIP VAR2,80,100,4
CALL TIME_DELAY
CALL TIME_DELAY
CALL TIME_DELAY
CALL TIME_DELAY
PRINT_SHIP VAR2,80,100,3
MOV VAR2,10					;bring the ship back to its original 
JMP LABEL1

EXIT:
LEA 	DI,NEW
LEA 	SI,OLD
MOV 	AL,9
CALL SETUP_INT
CALL SOUND			;cause three time delayed beeps
EXIT2:
MOV 	AH,0		;return to text mode
MOV 	AL,3
INT 	10H
MOV 	AH,4CH
INT 21H
MAIN ENDP

;-----------------------

;_______________________
;      1st Procedure
;_______________________
TIME_DELAY PROC
MOV 	CX,10000
L1:
LOOP L1
MOV 	CX,10000
L2:
LOOP L2
MOV 	CX,10000
L3:
LOOP L3
MOV 	CX,10000
L4:
LOOP L4
MOV 	CX,10000
L5:
LOOP L5
RET
TIME_DELAY ENDP
;-----------------------

;_______________________
;      2nd Procedure
;_______________________

CHECK_KEY_PRESSED PROC
PUSH 	DS
PUSH 	AX
MOV 	AX,SEG KEY
MOV 	DS,AX
IN 	AL,60H
PUSH 	AX
IN 	AL,61H
MOV 		AH,AL
OR AL,80H
OUT 	61H,AL
XCHG 	AH,AL
OUT 	61H,AL
POP 	AX
MOV 	AH,AL
TEST 	AL,80H
JNE 	KEY_0
MOV 	FLAG,1
MOV 	KEY,AL
KEY_0:
MOV 	AL,20H
OUT 	20H,AL
POP 	AX
POP 	DS
IRET
CHECK_KEY_PRESSED ENDP
;-----------------------

;_______________________
;      3rd Procedure
;_______________________

SETUP_INT PROC
MOV 	AH,35H
INT 21H
MOV 	[DI],BX
MOV 	[DI+2],ES
MOV 	DX,[SI]
PUSH 	DS
MOV 	DS,[SI+2]
MOV 	AH,25H
INT 21H
POP 	DS
RET
SETUP_INT ENDP
;-----------------------

;_______________________
;      4th Procedure
;_______________________

BEEP PROC
MOV 	AL,0B6H
OUT 	43H,AL
MOV 	AX,1193
OUT 	42H,AL
MOV 	AL,AH
OUT 	42H,AL
IN 	AL,61H
MOV 	AH,AL
OR 	AL,11B
OUT 	61H,AL
MOV		CX,5
P:	PUSH CX
CALL TIME_DELAY
CALL TIME_DELAY
CALL TIME_DELAY
POP 	CX
LOOP P
IN 	AL, 61H
AND 	AL, 11111100B
OUT 	61H, AL
RET 
BEEP ENDP
;-----------------------

;_______________________
;      5th Procedure
;_______________________

SOUND PROC
CALL BEEP
CALL TIME_DELAY
CALL TIME_DELAY
CALL BEEP
CALL TIME_DELAY
CALL TIME_DELAY
CALL BEEP
RET
SOUND ENDP
;-----------------------

END MAIN                       