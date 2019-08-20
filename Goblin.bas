 set optimization size
 set tv pal
 set smartbranching on
 set kernel_options pfcolors no_blank_lines
 const shakescreen = 1
 const pfscore = 1

0start
 COLUBK = $2C : scorecolor = $58 : vram7 = 4 : sram0 = $AB : sram1 = $20 : sram2 = $19 : pfcolors:
 $58
 $58
 $58
 $58
 $58
 $58
 $58
 $58
 $58
 $58
 $58
 $58
end
 playfield:
 ................................
 ................................
 ...XXX..XX..XX..X...XXX.X...X...
 ..X....X..X.X.X.X....X..XX..X...
 ..X.XX.X..X.XX..X....X..X.X.X...
 ..X..X.X..X.X.X.X....X..X..XX...
 ...XXX..XX..XX..XXX.XXX.X...X...
 ................................
 ................................
 ................................
 ................................
 ................................
end

 gosub __fixrand
 ram0 = ram0 + 1
 if ram0 = 150 then 0flip
 if ram1 = 1 then sram1 = $CD : sram2 = $EF
 goto 0draw

0flip
 ram0 = 0
 if ram1 = 0 then 0flip1
 if ram1 = 1 then 0flip2
0flip1
 ram1 = 1 : goto 0draw
0flip2
 ram1 = 0

0draw
 drawscreen
 if switchreset then reboot
 if joy0fire then goto 0init : ram0 = 0 : ram1 = 0
 goto 0start

0init
 gosub __ballrand

 player0x = $5E : player0y = $2D : player1x = $5E : player1y = $2D : ballheight = 2
 ram5 = 0 : ram18 = 50
 pfscore2 = $FF : score = 0
 ram10 = %01111111 : ram11 = $FF : ram12 = %00011111 : ram13 = %00001111 : ram14 = %00111111 : ram15 = %11111111


1start
 COLUBK = $2C : scorecolor = $A0 : COLUP0 = $58 : COLUP1 = $46 : pfscorecolor = $A0 : pfcolors:
 $22
 $22
 $22
 $22
 $22
 $22
 $22
 $22
 $22
 $22
 $22
 $22
end
 CTRLPF = $15 : vram7 = 4 : ram29 = 0

 if pfscore2 = 0 then 3init

 gosub __fixrand

 player0:
 %000000
 %111000
 %111000
 %111000
 %000000
 %000000
end
 player1:
 %000000
 %000100
 %000010
 %000010
 %000001
 %000001
end

 if ram17 = 0 && ram7 = 0 then 1move
 if ram17 > 0 then ram17 = ram17 - 1
1p01
 if ram18 > 100 then ram17 = 6 : ram18 = 0
 if ram18 > 49 || ram17 > 0 then missile1x = ballx : missile1y = bally
 if switchleftb && collision(player0,missile1) then pfscore2 = pfscore2 / 2 : goto 1p71
 if !switchleftb && collision(player0,missile1) then pfscore2 = pfscore2 / 4 : goto 1p71
1p70
 AUDV1 = 0 : AUDC1 = 3
 if ram20 > 1 then AUDV1 = 10 : ram20 = ram20 - 1 : COLUP0 = $62
 goto 1p1
1p71
 missile1y = 250 : ram20 = 10 : if sram2 > 0 then score = score - 5
 goto 1p70

1move
 vram1 = player0x + 4
 vram2 = player0y - 2
 if vram1 > missile1x then missile1x = missile1x + 1
 if vram1 < missile1x then missile1x = missile1x - 1
 if vram2 > missile1y then missile1y = missile1y + 1
 if vram2 < missile1y then missile1y = missile1y - 1
 ram18 = ram18 + 1
 goto 1p01

1p1
 if collision(player0,playfield) then 1p11
 if ram2 = 2 then 1p10
 ram2 = ram2 + 1 : goto 1p12
1p10
 ram2 = 0 : ram3 = player0x : ram4 = player0y : goto 1p12

1p11
 player0x = ram3 : player0y = ram4
 if collision(player0,playfield) then player0x = ram3 - 1 : ram29 = 1 : goto coll
coll0
 if collision(player0,playfield) then player0x = ram3 + 1 : ram29 = 2 : goto coll
coll1
 if collision(player0,playfield) then player0y = ram4 - 1 : ram29 = 3 : goto coll
coll2
 if collision(player0,playfield) then player0y = ram4 + 1 : ram29 = 4 : goto coll
coll3
 if collision(player0,playfield) then player0y = ram4 - 2 : player0x = ram3 - 2 : ram29 = 5 : goto coll
coll4
 if collision(player0,playfield) then player0y = ram4 + 2 : player0x = ram3 - 2 : ram29 = 6 : goto coll
coll5
 drawscreen
 if collision(player0,playfield) then 1p14
 goto 1p10
1p14
 player0x = $61 : player0y = $2D : score = score + 1000 : goto 1p10

1p12
 if ram5 = 0 then goto area0
 if ram5 = 1 then goto area1
 if ram5 = 2 then goto area2
 if ram5 = 3 then goto area3
 if ram5 = 4 then goto area4
 if ram5 = 5 then goto area5

1p13
 if ram6 = 4 && ram5 = 0 then 1p20
 if ram6 = 3 && ram5 = 1 then 1p21
 if ram6 = 2 && ram5 = 1 then 1p22
 if ram6 = 1 && ram5 = 2 then 1p20
 if ram6 = 4 && ram5 = 1 then 1p23
 if ram6 = 3 && ram5 = 3 then 1p20
 if ram6 = 2 && ram5 = 3 then 1p24
 if ram6 = 1 && ram5 = 4 then 1p23
 if ram6 = 2 && ram5 = 4 then 1p25
 if ram6 = 1 && ram5 = 5 then 1p24

1p27
 if ram10 = 0 && ram11 = 0 && ram12 = 0 && ram13 = 0 && ram14 = 0 && ram15 = 0 then goto 2start

 if ram5 = 0 then ram8 = ram10
 if ram5 = 1 then ram8 = ram11
 if ram5 = 2 then ram8 = ram12
 if ram5 = 3 then ram8 = ram13
 if ram5 = 4 then ram8 = ram14
 if ram5 = 5 then ram8 = ram15

 pfscore1 = ram8
 if ram9 = 1 then 1p31
 goto 1p30

1p31
 ram8 = ram8 / 2
 if ram5 = 0 then ram10 = ram8
 if ram5 = 1 then ram11 = ram8
 if ram5 = 2 then ram12 = ram8
 if ram5 = 3 then ram13 = ram8
 if ram5 = 4 then ram14 = ram8
 if ram5 = 5 then ram15 = ram8
 ram9 = 0 : goto 1p30

1p20
 ram5 = 1 : goto 1p26
1p21
 ram5 = 0 : goto 1p26
1p22
 ram5 = 2 : goto 1p26
1p23
 ram5 = 3 : goto 1p26
1p24
 ram5 = 4 : goto 1p26
1p25
 ram5 = 5

1p26
 gosub __ballrand
 missile1y = $F0

 if ram6 = 4 then player0x = 40
 if ram6 = 3 then player0x = 130
 if ram6 = 2 then player0y = 12
 if ram6 = 1 then player0y = 80
 player1x = player0x : player1y = player0y : ram6 = 0 : goto 1p27

area0
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X.................XX...........X
 X........X.......XXX...........X
 XX.......XX...............X....X
 XXX.......X....................X
 XX..............................
 XXXX............................
 XXX...............XXX.X........X
 X.......XXX........XXXX........X
 X........XXX.........X.........X
 X..........................X...X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 ram32 = 0 : goto 1p13
area1
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X...............................
 X...............................
 X..............................X
 X..............................X
 ...............................X
 ...............................X
 X..............................X
 X..............................X
 X...............................
 X...............................
 XXXXXXXXXXXXXXX...XXXXXXXXXXXXXX
end
 ram32 = 0 : goto 1p13
area2
 playfield:
 XXXXXXXXXXXXXXX...XXXXXXXXXXXXXX
 X..............................X
 X..............................X
 X............XXXXXX............X
 X..........XXXXXXXXXX..........X
 X..........XXXXXX...X..........X
 X..........XXXXX...XX..........X
 X..........XXXXXXX.XX..........X
 X............XXXX..............X
 X..............................X
 X..............................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 ram32 = 0 : goto 1p13
area3
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 ...............................X
 ..............................XX
 X.........XX...............XX..X
 X....XXX...XX............XXXXXXX
 XXXXXXXXX...XX........XX.X...XXX
 XXXXXXXXX...XXXX...XXXXX...X.XXX
 XXXXXXXX...XXXXXXXXXXXXXXXXX.XXX
 X..............................X
 ...............................X
 ...............................X
 XXXXXXXXXXXXXXXXXXXXXXXX...XXXXX
end
 ram32 = 0 : goto 1p13
area4
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXX...XXXXX
 X..............................X
 X..............................X
 X..............................X
 XXXXXXXXXXXXXXX...XXXXXXXXXXXXXX
 XXXXXXXXXXXXXXX...XXXXXXXXXXXXXX
 XXXXXXXXXXXXXX....XXXXXXXXXXXXXX
 XXXXXXXXXXXXXX....XXXXXXXXXXXXXX
 X..............................X
 X..............................X
 X..............................X
 XXXXXXXXXX...XXXXXXXXXXXXXXXXXXX
end
 pfcolors:
 $22
 $22
 $22
 $22
 $22
 $B6
 $B6
 $B6
 $B6
 $0B
 $0B
 $0B
end
 COLUBK = $0F : ram32 = 1 : goto 1p13
area5 playfield:
 XXXXXXXXXX...XXXXXXXXXXXXXXXXXXX
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 pfcolors:
 $0B
 $0B
 $0B
 $0B
 $0B
 $0B
 $0B
 $0B
 $0B
 $0B
 $0B
 $0B
end
 COLUBK = $0E : ram32 = 2 : goto 1p13

coll
 if ram32 = 0 then area41
 if ram32 = 1 then area51
 if ram32 = 2 then area01

1p1draw
 drawscreen
 if ram29 = 1 then coll0
 if ram29 = 2 then coll1
 if ram29 = 3 then coll2
 if ram29 = 4 then coll3
 if ram29 = 5 then coll4
 if ram29 = 6 then coll5

area41
 COLUBK = $2C : pfcolors:
 $22
 $22
 $22
 $22
 $22
 $22
 $22
 $22
 $22
 $22
 $22
 $22
end
 goto 1p1draw
area51
 COLUBK = $0F : pfcolors:
 $22
 $22
 $22
 $22
 $22
 $B6
 $B6
 $B6
 $B6
 $0B
 $0B
 $0B
end
 goto 1p1draw
area01
 COLUBK = $0E : pfcolors:
 $0B
 $0B
 $0B
 $0B
 $0B
 $0B
 $0B
 $0B
 $0B
 $0B
 $0B
 $0B
end
 goto 1p1draw

1p30
 if ram0 > 1 && !joy0fire then 1p40
 goto 1p41 
1p40
 AUDV0 = 10 : AUDC0 = 4 : AUDF0 = 30

 if ram0 > 1 && ram0 < 5 then player1:
 %000000
 %000100
 %000010
 %000010
 %000010
 %000010
end
 if ram0 > 4 then player1:
 %000000
 %000100
 %000100
 %000100
 %000100
 %000100
end
 if ram0 = 1 then 1p41
 ram0 = ram0 - 1
 goto 1p42
1p41
 AUDV0 = 0

1p42
 if collision(ball,player1) && ram0 > 1 && !joy0fire then 1p43
 if ram1 > 0 then 1p45
 if ram8 = 0 then bally = $F0 : missile1y = $F0
 goto 1draw
1p43
 gosub __ballrand
 pfscore2 = %11111111
 score = score + 15 : ram9 = 1
 AUDV1 = 10 : AUDC1 = 1 : AUDF1 = 1 : ram1 = 10

1p45
 ram1 = ram1 - 1
 if ram1 = 0 then AUDV1 = 0

1draw
 drawscreen
 if joy0up then player0y = player0y - 1 : if player0y < 3 then ram6 = 1
 if joy0down then player0y = player0y + 1 : if player0y > 89 then ram6 = 2
 if joy0left then player0x = player0x - 1 : if player0x < 13 then ram6 = 3
 if joy0right then player0x = player0x + 1 : if player0x > 138 then ram6 = 4
 if joy0fire then ram0 = 6
 if switchreset then reboot
 player1y = player0y : player1x = player0x

 if ram7 = 0 then 1p46
 ram7 = ram7 - 1
 goto 1start

1p46
 if player1x > ballx then ballx = ballx - 1 : if ballx < 28 then ballx = 28
 if player1x < ballx then ballx = ballx + 1 : if ballx > 133 then ballx = 133
 if player1y > bally then bally = bally - 1 : if bally < 10 then bally = 10
 if player1y < bally then bally = bally + 1 : if bally > 81 then bally = 81
 ram7 = 2

 goto 1start

2start
 player1y = 250 : player0y = 250 : bally = 250 : COLUBK = $00 : sram0 = $FF : sram1 = $FF : sram2 = $FF : vram7 = 8 : pfscore1 = 0 : pfscore2 = 0 : AUDV0 = 0 : AUDV1 = 0
 playfield:
 .XXX.X.X..X..X.X.X.X..XX....X.X.
 ..X..X.X.X.X.XXX.X.X.X......X.X.
 ..X..XXX.XXX.XXX.XX...X.....XXX.
 ..X..X.X.X.X.XXX.X.X...X......X.
 ..X..X.X.X.X.X.X.X.X.XX.......X.
 ................................
 .XX..X....X..X.X.XXX.X.X..XX..X.
 .X.X.X...X.X.X.X..X..XXX.X....X.
 .XX..X...XXX..X...X..XXX.X.X..X.
 .X...X...X.X..X...X..XXX.X.X....
 .X...XXX.X.X..X..XXX.X.X..XX..X.
end
 pfcolors:
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
end
 drawscreen
 if switchreset then reboot
 goto 2start

3init
 ram0 = 0 :player1y = 250 : player0y = 250 : bally = 250
 AUDV0 = 0 : AUDV1 = 0
3start
 AUDC0 = 4 : AUDF0 = 10 : COLUBK = $62 : pfscorecolor = $00 : scorecolor = $00
 playfield:
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
end
 ram0 = ram0 + 1
 if ram0 < 10 then AUDV0 = 10
 if ram0 > 9 && ram0 < 20 then AUDV0 = 7
 if ram0 > 19 && ram0 < 30 then AUDV0 = 2
 if ram0 > 29 && ram0 < 40 then AUDV0 = 1
 if ram0 > 39 then reboot
 drawscreen
 if switchreset then reboot
 goto 3start

__ballrand
 ballx = rand
 if ballx > 148 then __ballrand
 if ballx < 5 then __ballrand
s0 bally = rand
 if bally > 84 then s0
 if bally < 4 then s0
 return

 rem if you use Emu2600 XL then you can remove this
__fixrand
 ram19 = rand
 if !ram19{7} then __fixrand
 ram19 = rand
 return
