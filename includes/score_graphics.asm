 ifconst ROM2k
   ORG $F7AC-48
 else
   ifconst bankswitch
     if bankswitch == 8
       ORG $2F94-bscode_length-48
       RORG $FF94-bscode_length-48
     endif
     if bankswitch == 16
       ORG $4F94-bscode_length-48
       RORG $FF94-bscode_length-48
     endif
     if bankswitch == 32
       ORG $8F94-bscode_length-48
       RORG $FF94-bscode_length-48
     endif
   else
     ORG $FF9C-48
   endif
 endif

scoretable
       .byte %00111100
       .byte %01100110
       .byte %01100110
       .byte %01100110
       .byte %01100110
       .byte %01100110
       .byte %01100110
       .byte %00111100

       .byte %01111110
       .byte %00011000
       .byte %00011000
       .byte %00011000
       .byte %00011000
       .byte %00111000
       .byte %00011000
       .byte %00001000

       .byte %01111110
       .byte %01100000
       .byte %01100000
       .byte %00111100
       .byte %00000110
       .byte %00000110
       .byte %01000110
       .byte %00111100

       .byte %00111100
       .byte %01000110
       .byte %00000110
       .byte %00000110
       .byte %00011100
       .byte %00000110
       .byte %01000110
       .byte %00111100

       .byte %00001100
       .byte %00001100
       .byte %01111110
       .byte %01001100
       .byte %01001100
       .byte %00101100
       .byte %00011100
       .byte %00001100

       .byte %00111100
       .byte %01000110
       .byte %00000110
       .byte %00000110
       .byte %00111100
       .byte %01100000
       .byte %01100000
       .byte %01111110

       .byte %00111100
       .byte %01100110
       .byte %01100110
       .byte %01100110
       .byte %01111100
       .byte %01100000
       .byte %01100010
       .byte %00111100

       .byte %00110000
       .byte %00110000
       .byte %00110000
       .byte %00011000
       .byte %00001100
       .byte %00000110
       .byte %01000010
       .byte %00111110

       .byte %00111100
       .byte %01100110
       .byte %01100110
       .byte %01100110
       .byte %00111100
       .byte %01100110
       .byte %01100110
       .byte %00111100

       .byte %00111100
       .byte %01000110
       .byte %00000110
       .byte %00111110
       .byte %01100110
       .byte %01100110
       .byte %01100110
       .byte %00111100 

       .byte %10001100
       .byte %01010001
       .byte %01010001
       .byte %00110001
       .byte %00010001
       .byte %11111101
       .byte %00000001
       .byte %11111000

       .byte %11100000
       .byte %00010000
       .byte %00010000
       .byte %00000111
       .byte %00000111
       .byte %00000000
       .byte %00000000
       .byte %00000000

       .byte %00010001
       .byte %00011000
       .byte %00010000
       .byte %00011101
       .byte %01000101
       .byte %01100110
       .byte %01010101
       .byte %01100110

       .byte %11010101
       .byte %10011001
       .byte %10010101
       .byte %11011001
       .byte %01110110
       .byte %01100011
       .byte %01000100
       .byte %01110011

       .byte %11000000
       .byte %10000000
       .byte %00000000
       .byte %11000000
       .byte %01100000
       .byte %00110000
       .byte %01000000
       .byte %00110000

       .byte %00000000
       .byte %00000000
       .byte %00000000
       .byte %00000000
       .byte %00000000
       .byte %00000000
       .byte %00000000
       .byte %00000000

       .byte %01000101
       .byte %01110011
       .byte %01100011
       .byte %01101001
       .byte %00100011
       .byte %00110010
       .byte %00110000
       .byte %00110000
       .byte %00110100

 ifconst ROM2k
   ORG $F7FC
 else
   ifconst bankswitch
     if bankswitch == 8
       ORG $2FF4-bscode_length
       RORG $FFF4-bscode_length
     endif
     if bankswitch == 16
       ORG $4FF4-bscode_length
       RORG $FFF4-bscode_length
     endif
     if bankswitch == 32
       ORG $8FF4-bscode_length
       RORG $FFF4-bscode_length
     endif
   else
     ORG $FFFC
   endif
 endif
