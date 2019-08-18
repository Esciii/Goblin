 processor 6502
 include "vcs.h"
 include "macro.h"
 include "2600basic_variable_redefs.h"

; score ram

sram0 = $93 ; score 3
sram1 = $94 ; score 2
sram2 = $95 ; score 1
sram3 = $F2 ; pfscore1
sram4 = $F3 ; pfscore2

; video ram

vram0 = $D4 ; for bank switching, dont use when using more than 4k or superchip
vram1 = $9C ; reset on drawscreen
vram2 = $9D ; reset on drawscreen
vram3 = $9E ; reset on drawscreen
vram4 = $9F ; reset on drawscreen
vram5 = $A0 ; reset on drawscreen
vram6 = $A1 ; reset on drawscreen
vram7 = $D5 ; moves screen

; ram the user can usually use

ram0 = $D6 ; A 
ram1 = $D7 ; B
ram2 = $D8 ; C
ram3 = $D9 ; D
ram4 = $DA ; E
ram5 = $DB ; F
ram6 = $DC ; G
ram7 = $DD ; H
ram8 = $DE ; I
ram9 = $DF ; J
ram10 = $E0 ; K
ram11 = $E1 ; L
ram12 = $E2 ; M
ram13 = $E3 ; N
ram14 = $E4 ; O
ram15 = $E5 ; P
ram16 = $E6 ; Q
ram17 = $E7 ; R
ram18 = $E8 ; S
ram19 = $E9 ; T
ram20 = $EA ; U
ram21 = $EB ; V
ram22 = $EC ; W
ram23 = $ED ; X
ram24 = $EE ; Y
ram25 = $EF ; Z
ram26 = $F0 ; aux1
ram27 = $F1 ; aux2
ram28 = $F4 ; pfscore colour
ram29 = $F5 ; aux6
ram30 = $F8 ; stack
ram31 = $F9 ; stack
ram32 = $FA ; stack
ram33 = $FB ; stack
ram34 = $82 ; missile0x
ram35 = $91 ; missile0y
ram36 = $88 ; missile1x
ram37 = $83 ; missile1y

; playfield ram

pram0 = $A4 ; free screen data 11-
pram1 = $A5 ; free screen data 11-
pram2 = $A6 ; free screen data 11-
pram3 = $A7 ; free screen data 11-
pram4 = $A8 ; free screen data 10-
pram5 = $A9 ; free screen data 10-
pram6 = $AA ; free screen data 10-
pram7 = $AB ; free screen data 10-
pram8 = $AC ; free screen data 9-
pram9 = $AD ; free screen data 9-
pram10 = $AE ; free screen data 9-
pram11 = $AF ; free screen data 9-
pram12 = $B0 ; free screen data 8-
pram13 = $B1 ; free screen data 8-
pram14 = $B2 ; free screen data 8-
pram15 = $B3 ; free screen data 8-
pram16 = $B4 ; free screen data 7-
pram17 = $B5 ; free screen data 7-
pram18 = $B6 ; free screen data 7-
pram19 = $B7 ; free screen data 7-
pram20 = $B8 ; free screen data 6-
pram21 = $B9 ; free screen data 6-
pram22 = $BA ; free screen data 6-
pram23 = $BB ; free screen data 6-
pram24 = $BC ; free screen data 5-
pram25 = $BD ; free screen data 5-
pram26 = $BE ; free screen data 5-
pram27 = $BF ; free screen data 5-
pram28 = $C0 ; free screen data 4-
pram29 = $C1 ; free screen data 4-
pram30 = $C2 ; free screen data 4-
pram31 = $C3 ; free screen data 4-
pram32 = $C4 ; free screen data 3
pram33 = $C5 ; free screen data 3
pram34 = $C6 ; free screen data 3
pram35 = $C7 ; free screen data 3
pram36 = $C8 ; line 2
pram37 = $C9 ; line 2
pram38 = $CA ; line 2
pram39 = $CB ; line 2
pram40 = $CC ; last line
pram41 = $CD ; last line
pram42 = $CE ; last line
pram43 = $CF ; last line
pram44 = $D0 ; free data under screen
pram45 = $D1 ; free data under screen
pram46 = $D2 ; free data under screen
pram47 = $D3 ; free data under screen

player0x = $80
player1x = $81
missile0x = $82
missile1x = $83
ballx = $84

objecty = $85
player0y = $85
player1y = $86
missile1height = $87
missile1y = $88
bally = $89

player1color = $87 ; replaces missile 1

player0pointer = $8A ;uses $8A-$8B
player0pointerlo = $8A
player0pointerhi = $8B
player1pointer = $8C ; $8C-$8D
player1pointerlo = $8C
player1pointerhi = $8D

player0height = $8E
player1height = $8F
missile0height = $90
missile0y = $91
ballheight = $92

currentpaddle = $90 ; replaces missile 0 (and can't be used with playercolor)
paddle = $91 ; replaces missile 0
player0colorstore = $82 ; replaces missile 0
player0color = $90 ; replaces missile 0

score = $93 ; $93-$95
scorepointers = $96 ; $96-$9B = 6 bytes
temp1 = $9C ;used by kernel.  can be used in program too, but
temp2 = $9D ;are obliterated when drawscreen is called.
temp3 = $9E
temp4 = $9F
temp5 = $A0
temp6 = $A1

rand = $A2
scorecolor = $A3

var0 = $A4
var1 = $A5
var2 = $A6
var3 = $A7
var4 = $A8
var5 = $A9
var6 = $AA
var7 = $AB
var8 = $AC
var9 = $AD
var10 = $AE
var11 = $AF
var12 = $B0
var13 = $B1
var14 = $B2
var15 = $B3
var16 = $B4
var17 = $B5
var18 = $B6
var19 = $B7
var20 = $B8
var21 = $B9
var22 = $BA
var23 = $BB
var24 = $BC
var25 = $BD
var26 = $BE
var27 = $BF
var28 = $C0
var29 = $C1
var30 = $C2
var31 = $C3
var32 = $C4
var33 = $C5
var34 = $C6
var35 = $C7
var36 = $C8
var37 = $C9
var38 = $CA
var39 = $CB
var40 = $CC
var41 = $CD
var42 = $CE
var43 = $CF
var44 = $D0
var45 = $D1
var46 = $D2
var47 = $D3

temp7 = $D4 ; This is used to aid in bankswitching

playfieldpos = $D5

A = $d6
a = $d6
B = $d7
b = $d7
C = $d8
c = $d8
D = $d9
d = $d9
E = $da
e = $da
F = $db
f = $db
G = $dc
g = $dc
H = $dd
h = $dd
I = $de
i = $de
J = $df
j = $df
K = $e0
k = $e0
L = $e1
l = $e1
M = $e2
m = $e2
N = $e3
n = $e3
O = $e4
o = $e4
P = $e5
p = $e5
Q = $e6
q = $e6
R = $e7
r = $e7
S = $e8
s = $e8
T = $e9
t = $e9
U = $ea
u = $ea
V = $eb
v = $eb
W = $ec
w = $ec
X = $ed
x = $ed
Y = $ee
y = $ee
Z = $ef
z = $ef

; available for other uses, or if unused, provide more stack space

aux1 = $f0
aux2 = $f1
aux3 = $f2
aux4 = $f3
aux5 = $f4
aux6 = $f5

; playfield color/height pointers
pfcolortable = $f0 ; and $d5
pfheighttable = $f0 ; and $d5
; the above pointers are the same because if color and height are both used together,
; they must used absolute indexed and cannot use pointers

lifepointer = $f2 ; pointer to "lives" shape
; upper 3 bits of $f2 contain the number of lives
lifecolor = $f4
lives = $f3 ; # lives >> 5
statusbarlength = $f5 ; only uses upper 5 bits; other bits free

pfscore1 = $f2 ; optional playfield bytes in score
pfscore2 = $f3
pfscorecolor = $f4

stack1 = $f6
stack2 = $f7
stack3 = $f8
stack4 = $f9
; the stack bytes above may be used in the kernel
; stack = F6-F7, F8-F9, FA-FB, FC-FD, FE-FF

 MAC RETURN	; auto-return from either a regular or bankswitched module
   ifnconst bankswitch
     rts
   else
     jmp BS_return
   endif
 ENDM

 ifconst superchip
playfieldbase = $10D0
 else
playfieldbase = $A4
 endif

; define playfield start based on height
 ifnconst pfres
playfield = playfieldbase
 else
playfield = playfieldbase-(pfres-12)*4
 endif

