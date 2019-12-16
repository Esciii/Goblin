 set romsize 8k
 set tv pal
 set smartbranching on
 set kernel_options pfcolors no_blank_lines
 const shakescreen = 1
 const pfscore = 1

0start
 COLUBK = $2C : scorecolor = $C2 : sram0 = $AB : sram1 = $20 : sram2 = $19 : ram3 = $5E : ram4 = $2D : pfcolors:
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
end

 gosub __fixrand bank2
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
 gosub __ballrand bank2

 player0x = $5E : player0y = $2D : player1x = $5E : player1y = $2D
 ram5 = 0 : ram18 = 50
 pfscore2 = $FF : score = 0
 ram10 = %01111111
 ram11 = %11111111
 ram12 = %00011111
 ram13 = %00001111
 ram14 = %00111111
 ram15 = %11111111
 ram21 = %11111111
 ram22 = %11111111
 ram23 = %11111111
 ram25 = %11111111

1start
 COLUBK = $2C : COLUP0 = $58 : COLUP1 = $46 : pfscorecolor = $A0 : pfcolors:
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
 CTRLPF = $15 : vram7 = 4 : ram29 = 0 : ballheight = 2

 if pfscore2 = 0 then 3init
 rem if ram5 = 11 then 1bs
 if pfscore1 = 0 then bally = $F0 : missile1y = $F0

 rem 1bs
 gosub __fixrand bank2

 player0:
 %00000000
 %11100000
 %11100000
 %11100000
 %00000000
 %00000000
end
 player1:
 %00000000
 %00010000
 %00001000
 %00001000
 %00000100
 %00000100
end
 if !switchleftb then player1:
 %00001110
 %00010001
 %00010001
 %00010001
 %00001110
 %00000000
end

 if ram17 = 0 && ram7 = 0 then 1move
 if ram17 > 0 then ram17 = ram17 - 1
1p01
 if ram18 > 100 then ram17 = 6 : ram18 = 0
 if ram18 > 49 || ram17 > 0 then missile1x = ballx : missile1y = bally
 if collision(player0,missile1) then pfscore2 = pfscore2 / 2 : goto 1p71
1p70
 AUDV1 = 0 : AUDC1 = 3
 if ram20 > 1 then AUDV1 = 10 : ram20 = ram20 - 1 : COLUP0 = $62

 if collision(player0,playfield) then 1p11
1p10
 goto 1p12 bank2

1p11
 rem if joy1fire then 1p10
 rem uncomment that to walk through walls
 if ram2{4} then player0x = player0x - 1
 if ram2{5} then player0x = player0x + 1
 if ram2{7} then player0y = player0y + 1
 if ram2{6} then player0y = player0y - 1
 goto 1p10

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

1p30
 if ram0 > 1 && !joy0fire then 1p40
 if ram0 = 1 then AUDV0 = 0
 goto 1p41 
1p40
 AUDV0 = 10 : AUDC0 = 4 : AUDF0 = 30

 if !switchleftb then 1wep2

 if ram0 > 1 && ram0 < 5 then player1:
 %00000000
 %00010000
 %00010000
 %00010000
 %00010000
 %00010000
end
 if ram0 > 4 then player1:
 %00000000
 %00010000
 %00001000
 %00001000
 %00001000
 %00001000
end

1wep1
 if ram0 = 1 then 1p41
 ram0 = ram0 - 1
 goto 1p42

1wep2
 if ram0 > 1 && ram0 < 5 then player1:
 %00000000
 %00000000
 %00011100
 %00000000
 %00000000
 %00000000
end
 if ram0 > 4 then player1:
 %00000000
 %00001110
 %00011010
 %00001110
 %00000000
 %00000000
end
 goto 1wep1

1p41
 AUDV0 = 0

1p42
 if collision(ball,player1) && ram0 > 1 && !joy0fire then 1p43
 if ram1 > 0 then 1p45
 goto 1draw
1p43
 gosub __ballrand bank2
 pfscore2 = $FF
 score = score + 15 : ram9 = 1
 AUDV1 = 10 : AUDC1 = 1 : AUDF1 = 1 : ram1 = 10

1p45
 ram1 = ram1 - 1
 if ram1 = 0 then AUDV1 = 0

1draw
 drawscreen
 if joy0up then player0y = player0y - 1
 if joy0down then player0y = player0y + 1
 if joy0left then player0x = player0x - 1
 if joy0right then player0x = player0x + 1
 if joy0fire then ram0 = 6
 if switchreset then reboot
 player1y = player0y : player1x = player0x
 if player0y < 3 then ram6 = 1
 if player0y > 89 then ram6 = 2
 if player0x < 14 then ram6 = 3
 if player0x > 140 then ram6 = 4

 if ram7 = 0 then 1p46
 ram7 = ram7 - 1
 goto 1start

1p46
 if player1x > ballx then ballx = ballx - 1 : if ballx < 28 then ballx = 28
 if player1x < ballx then ballx = ballx + 1 : if ballx > 133 then ballx = 133
 if player1y > bally then bally = bally - 1 : if bally < 10 then bally = 10
 if player1y < bally then bally = bally + 1 : if bally > 81 then bally = 81
 ram7 = 3

 goto 1start

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
 if ram0 < 10 then AUDV0 = 7
 if ram0 > 9 && ram0 < 20 then AUDV0 = 2
 if ram0 > 39 then reboot
 drawscreen
 if switchreset then reboot
 goto 3start

eegg
 score = 0 : pfscore1 = 0 : pfscore2 = 0
 player0x = $61 : player0y = $2D : player1x = $61 : player1y = $2D : ballheight = 2 : missile1y = $F0
 gosub __ballrand bank2

loop0
 COLUBK = $00 : scorecolor = $0E : COLUP0 = $58 : CTRLPF = $15 : vram7 = 4 : COLUP1 = $46
 pfcolors:
 $9A
 $9A
 $9A
 $9A
 $9A
 $9A
 $9A
 $9A
 $9A
 $9A
 $9A
 $9A
end
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
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
 player0:
 %01010000
 %01010000
 %00100000
 %10101000
 %01110000
 %00100000
 %01110000
 %01110000
 %01110000
end
 player1:
 %00000000
 %00000000
 %00001000
 %00001000
 %00000100
 %00000100
 %00000010
 %00000010
 %00000000
end

 if ram0 > 1 then ram0 = ram0 - 1

 if player0y < 15 then player0y = 15
 if player0y > 83 then player0y = 83
 if player0x < 22 then player0x = 22
 if player0x > 130 then player0x = 130
 if bally < 16 then bally = 16
 if bally > 81 then bally = 81
 if ballx < 23 then ballx = 23
 if ballx > 129 then ballx = 129

 if ram0 = 1 then loop1b
 goto loop1a
loop1b
 AUDV0 = 0 : AUDC0 = 4 : AUDF0 = 30

loop1a
 player1x = player0x : player1y = player0y
 drawscreen
 if joy0up then player0y = player0y - 1
 if joy0down then player0y = player0y + 1
 if joy0left then player0x = player0x - 1
 if joy0right then player0x = player0x + 1
 if switchreset then reboot

 if ram3 > 0 then loop1c
 goto loop1d
loop1c
 ram3 = ram3 - 1
 goto loop0
loop1d
 ram3 = 2

 if player0x > ballx then ballx = ballx - 1
 if player0x < ballx then ballx = ballx + 1
 if player0y > bally then bally = bally - 1
 if player0y < bally then bally = bally + 1
 if collision(player0,ball) then loop1e

 goto loop0

loop1e
 gosub __ballrand bank2
 score = score + 10 : AUDV0 = 10 : AUDC0 = 4 : AUDF0 = 30 : ram0 = 10
 goto loop0

1p13
 rem 1u 2d 3l 4r

 if joy0up                 then ram2    = %10000000
 if joy0down               then ram2    = %01000000
 if joy0left               then ram2    = %00100000
 if joy0right              then ram2    = %00010000
 if joy0up    && joy0left  then ram2    = %10100000
 if joy0up    && joy0right then ram2    = %10010000
 if joy0down  && joy0left  then ram2    = %01100000
 if joy0down  && joy0right then ram2    = %01010000
 if joy1fire  && joy1right then ram2{0} = 1

 if ram6 = 4 && ram5 = 0  then ram5 = 1  : goto 1p26b
 if ram6 = 3 && ram5 = 1  then ram5 = 0  : goto 1p26b
 if ram6 = 2 && ram5 = 1  then ram5 = 2  : goto 1p26b
 if ram6 = 1 && ram5 = 2  then ram5 = 1  : goto 1p26b
 if ram6 = 4 && ram5 = 1  then ram5 = 3  : goto 1p26b
 if ram6 = 3 && ram5 = 3  then ram5 = 1  : goto 1p26b
 if ram6 = 2 && ram5 = 3  then ram5 = 4  : goto 1p26b
 if ram6 = 1 && ram5 = 4  then ram5 = 3  : goto 1p26b
 if ram6 = 2 && ram5 = 4  then ram5 = 5  : goto 1p26b
 if ram6 = 1 && ram5 = 5  then ram5 = 4  : goto 1p26b
 rem desert areas

 if ram6 = 2 && ram5 = 2  then ram5 = 6  : goto 1p26b
 if ram6 = 1 && ram5 = 6  then ram5 = 2  : goto 1p26b
 if ram6 = 2 && ram5 = 6  then ram5 = 7  : goto 1p26b
 if ram6 = 1 && ram5 = 7  then ram5 = 6  : goto 1p26b
 if ram6 = 3 && ram5 = 7  then ram5 = 10 : goto 1p26b
 if ram6 = 4 && ram5 = 10 then ram5 = 7  : goto 1p26b
 if ram6 = 1 && ram5 = 10 then ram5 = 9  : goto 1p26b
 if ram6 = 3 && ram5 = 6  then ram5 = 9  : goto 1p26b
 if ram6 = 4 && ram5 = 9  then ram5 = 6  : goto 1p26b
 if ram6 = 2 && ram5 = 9  then ram5 = 10 : goto 1p26b
 if ram6 = 3 && ram5 = 9  then ram5 = 11 : goto 1p26b
 if ram6 = 4 && ram5 = 11 then ram5 = 9  : goto 1p26b
 if ram6 = 2 && ram5 = 7  then ram5 = 8  : goto 1p26b
 if ram6 = 1 && ram5 = 8  then ram5 = 7  : goto 1p26b
 rem maze areas
 
 if ram6 = 2 && ram5 = 5  then ram5 = 12 : goto 1p26b
 if ram6 = 1 && ram5 = 12 then ram5 = 5  : goto 1p26b
 if ram6 = 4 && ram5 = 5  then ram5 = 13 : goto 1p26b
 if ram6 = 3 && ram5 = 13 then ram5 = 5  : goto 1p26b
 if ram6 = 4 && ram5 = 12 then ram5 = 14 : goto 1p26b
 if ram6 = 3 && ram5 = 14 then ram5 = 12 : goto 1p26b
 if ram6 = 2 && ram5 = 13 then ram5 = 14 : goto 1p26b
 if ram6 = 1 && ram5 = 14 then ram5 = 13 : goto 1p26b
 if ram6 = 4 && ram5 = 13 then ram5 = 17 : goto 1p26b
 if ram6 = 3 && ram5 = 17 then ram5 = 13 : goto 1p26b
 if ram6 = 2 && ram5 = 14 then ram5 = 15 : goto 1p26b
 if ram6 = 1 && ram5 = 15 then ram5 = 14 : goto 1p26b
 if ram6 = 2 && ram5 = 15 then ram5 = 16 : goto 1p26b
 if ram6 = 1 && ram5 = 16 then ram5 = 15 : goto 1p26b
 rem rockfield

 if ram2{0}  && ram5 = 0  then goto eegg
 if ram6 = 2 && ram5 = 8  then goto 0start

1p26b
 goto 1p26 bank2

 bank 2

1p12
 if ram5 = 0  then area0
 if ram5 = 1  then area1
 if ram5 = 2  then area2
 if ram5 = 3  then area3
 if ram5 = 4  then area4
 if ram5 = 5  then area5
 if ram5 = 6  then area6

 if ram5 = 7  then area7
 if ram5 = 8  then area8
 if ram5 = 9  then area9
 if ram5 = 10 then area10
 if ram5 = 11 then area11

 if ram5 = 12 then area12
 if ram5 = 13 then area13
 if ram5 = 14 then area14
 if ram5 = 15 then area15
 if ram5 = 16 then area16
 if ram5 = 17 then area17

1p26
 rem gosub __ballrand
 rem missile1y = $F0

 if ram6 = 4 then player0x = 14
 if ram6 = 3 then player0x = 139
 if ram6 = 2 then player0y = 4
 if ram6 = 1 then player0y = 88
 player1x = player0x : player1y = player0y : ram6 = 0

 if ram5 = 0 then ram8 = ram10
 if ram5 = 1 then ram8 = ram11
 if ram5 = 2 then ram8 = ram12
 if ram5 = 3 then ram8 = ram13
 if ram5 = 4 then ram8 = ram14
 if ram5 = 5 then ram8 = ram15

 if ram5 > 5 && ram5 < 11 then ram8 = 0

 if ram5 = 15 || ram5 = 16 then ram8 = ram21
 if ram5 = 14 then ram8 = ram22
 if ram5 = 13 || ram5 = 12 then ram8 = ram23
 if ram5 = 17 then ram8 = ram23

 pfscore1 = ram8
 if ram9 = 1 then 1p31
 goto 1p30 bank1

1p31
 ram8 = ram8 / 2
 if ram5 = 0 then ram10 = ram8
 if ram5 = 1 then ram11 = ram8
 if ram5 = 2 then ram12 = ram8
 if ram5 = 3 then ram13 = ram8
 if ram5 = 4 then ram14 = ram8
 if ram5 = 5 then ram15 = ram8
 if ram5 = 16 || ram5 = 15 then ram21 = ram8
 if ram5 = 14 then ram22 = ram8
 if ram5 = 13 || ram5 = 12 then ram23 = ram8
 if ram5 = 17 then ram23 = ram8
 ram9 = 0 : goto 1p30 bank1

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
 goto 1p13 bank1
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
 goto 1p13 bank1
area2
 playfield:
 XXXXXXXXXXXXXXX...XXXXXXXXXXXXXX
 X..............................X
 X..............................X
 X............XXXXXX............X
 X..........XXXXXXXXXX..........X
 X..........X..XXX...X..........X
 X..........X.XXX...XX..........X
 X..........XXX.XXX.XX..........X
 X............XXXX..............X
 X..............................X
 X..............................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXX..X
end
 goto 1p13 bank1
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
 goto 1p13 bank1
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
 COLUBK = $0F : goto 1p13 bank1
area5 playfield:
 XXXXXXXXXX...XXXXXXXXXXXXXXXXXXX
 X...............................
 X...............................
 X...............................
 X...............................
 X...............................
 X...............................
 X...............................
 X...............................
 X...............................
 X...............................
 X..............................X
end

 rem these corner bits can be removed without any gameplay issues
 rem i left them in because for some reason one of them stays in even if its removed
 rem you can see a similar issue on the title screen
 rem the 2 pixels next to the PRESS FIRE are not meant to be there and do not exist in the score table
 
 gosub __artic
 goto 1p13 bank1
area6 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXX..X
 ....X...........XXXXX....X.....X
 XX..X..XXXXXXX.,X...XXX..X..X..X
 .......X.....X..X..XX....X..XXXX
 XXXXXXXX..X..X..X..XXXX..X.....X
 X......X..XXXX..X..X..X..XXXX..X
 X..XX..X........X..X.....X.....X
 X...X..X..XXXX..X..X..X..X..X..X
 XX..X..X.....XXXX.....X..X..X..X
 X...X..XXX..XX..XXXXXXX..X..X..X
 X..XX........X..............X..X
 XXXXXXXX..XXXXXXXXX..XXXXXXXXXXX
end
 if ram25 = 0 then pram42 = %00000010
 goto 1p13 bank1
area7 playfield:
 XXXXXXXX..XXXXXXXXX..XXXXXXXXXXX
 ..........X.....X....X.....X..XX
 X.........X..XXXXXX..X..X..X..XX
 XXXXXXXXXXX.....X.......X.....XX
 ....X.....X..X..X..XXXXXXXXX..XX
 XX..XXXX.....X...........X.....X
 XX..X..X..X..X..XXXXXX..XX..XXXX
 XX..X..X..X..X...........X.....X
 XX........X..XXXXXXXXX..XXXXX..X
 XXXXXXXXXXXXXXXXXXXXXXXXX......X
 ........................XX..X..X
 XXXXXXXXXXXXXXXXX..XXXXXXXXXXXXX
end
 goto 1p13 bank1
area8 playfield:
 XXXXXXXXXXXXXXXXX..XXXXXXXXXXXXX
 X............XXXX..XXXX........X
 X...X..........XX..XX..........X
 X...X...........X..X...........X
 XXXXX.....XXXX.................X
 X........X...X.................X
 X........X...X.............XX..X
 XXXXX....X..XX..XXX..XXX...X...X
 X...............X......X...X...X
 X...............X......X...X...X
 X...X...........X......X...X...X
 XXXXXXXXXXXXXXXXX......XXXXXXXXX
end
 goto 1p13 bank1
area9 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 .......X..X........X........X...
 XXX..XXX..X..X..X..X..XXXX.....X
 XX...........XXXX..X..X..X..X...
 XXXXX..X..X..X..X.....X.....X..X
 X..XXXXXXXX..X..X..XXXXXXXXXX..X
 X............X.....X.....X..X..X
 XXXXXXXXXXXXXXXXX..X..X..X.....X
 X...X.....XXX......X..X..XXXX..X
 X..XX..X..XXX..XX..X..X..X.....X
 X......X...........X..X.....X..X
 X..XXXXXXXXXXXXXXXXX..XXXXXXXXXX
end
 goto 1p13 bank1
area10 playfield:
 X..XXXXXXXXXXXXXXXXX..XXXXXXXXXX
 X.......X.....XXX..X..X.........
 XXX..X.....X....X.....X..XXXX..X
 X....X..XXXXXXXXXXXXXXX.....XXXX
 X..XXXXXX.....X...X...X..X......
 X.....X....X......X..XX..X..XXXX
 XXXX..X..XXXXXXX.....XX..XXXX..X
 X.....X........X..X...X........X
 X..XXXXXXXXXX..X..XX..XXXXXXX..X
 X.....X.....X..X..X......X..XXXX
 X..X.....X.....X..XX..X..X......
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 if ram25 = 0 then pram39 = %11110000
 goto 1p13 bank1
area11 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXX......................XXX..
 XXX..........................X.X
 XX.............................X
 XX.............................X
 X..............................X
 X..............................X
 XX............................XX
 XX............................XX
 XXX..........................XXX
 XXXXX......................XXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end

 CTRLPF = $31 : ballheight = 8 : missile1x = ballx : missile1y = bally
 if joy0up then missile1y = bally - 9
 if joy0down then missile1y = bally + 9
 if joy0left then missile1x = ballx - 9
 if joy0right then missile1x = ballx + 9
 if player0x > ballx then ballx = ballx + 1
 if player0x < ballx then ballx = ballx - 1
 if player0y > bally then bally = ballx - 1
 if player0y < bally then bally = ballx + 1
 
 goto 1p13 bank1
area12 playfield:
 X..............................X
 X...............................
 X...............................
 X...............................
 X...............................
 X...............................
 X...............................
 X..........XXXXXXXXXXXXXX.......
 X......XXXXXXXXXXXXXXXXXXXX.....
 X....XXXXXXXXXXXXXXXXXXXXXXXX...
 X...XXXXXXXXXXXXXXXXXXXXXXXXXX..
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 gosub __artic
 goto 1p13 bank1
area13 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 ....XXXXXXXXXXXXXXXXXXXXXXXX....
 ....XXXXXXXXXXXXXXXXXXXXXXX.....
 ....XXXXXXXXXXXXXXXXXXXXX.......
 .....XXXXXXXXXXXXXXXXX..........
 ......XXXXXXXXXXXXXXX...........
 ......XXXXXXXXXXXXXX............
 .......XXXXXXXXXX...............
 .......XXXXXXX..................
 ........XXXXX...................
 ................................
 X..............................X
end
 gosub __artic
 goto 1p13 bank1
area14 playfield:
 X..............................X
 ...............................X
 ...............................X
 ...............................X
 ...............................X
 ...............................X
 ...............................X
 ...............................X
 ...............................X
 ...............................X
 ...............................X
 X..............................X
end
 gosub __artic
 goto 1p13 bank1
area15 playfield:
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X.............XXXX.............X
 X..........XXXXXXXXXXX.........X
 X.........XXXXXXXXXXXXX........X
 X........XXXXXXXXXXXXXXXX......X
 X........XXXXXXXXXXXXXXXXX.....X
 X.......XXXXXXXXXXXXXXXXXXX....X
 X......XXXXXXXXXXXXXXXXXXXX....X
 X.....XXXXXXXXXXXXXXXXXXXXX....X
end
 gosub __artic
 goto 1p13 bank1
area16 playfield:
 X.....XXXXXXXXXXXXXXXXXXXXX....X
 X.....XXXXXXXXXXXXXXXXXXXXX....X
 X......XXXXXXXXXXXXXXXXXXX.....X
 X........XXXXXXXXXXXXXXXXX.....X
 X.........XXXXXXXXXXXXXXX......X
 X..........XXXXXXXXXXXXX.......X
 X...........XXXXXXXXXXX........X
 X..............XXXXXX..........X
 X..............................X
 X..............................X
 X..............................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 gosub __artic
 goto 1p13 bank1
area17 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 .............XXXXXXXXXXXXX.....X
 ..............XXXXXXXXXX.......X
 ...............XXXXXXXX........X
 ...............XXXXXXXX........X
 .................XXXXX.........X
 ..................XXX..........X
 ...............................X
 .........XXXXXXXXX.............X
 ........XXXXXXXXXXX............X
 .......XXXXXXXXXXXXXX..........X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 gosub __artic
 goto 1p13 bank1

__artic
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
 COLUBK = $0E
 return

__ballrand
 ballx = rand : bally = rand
 if ballx > 148 then __ballrand
 if ballx < 5 then __ballrand
 if bally > 84 then __ballrand
 if bally < 4 then __ballrand
 return

__fixrand
 ram19 = rand
 if !ram19{7} then __fixrand
 ram19 = rand
 return

 inline credits.asm

 rem vblank
 rem __sloop
 rem if WSYNC{1} then ram21 = ram21 + 1
 rem if ram21 = 130 && ram34 = 1 then COLUBK = $22
 rem if ram21 = 191 && ram34 = 1 then COLUBK = $0F
 rem gosub __sloop
 rem return
