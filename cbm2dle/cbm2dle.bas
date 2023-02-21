!--------------------------------------------------
!- Tuesday, February 21, 2023 2:46:22 PM
!- Import of : 
!- c:\dev\c=ordle\cbm2dle\cbm2dle.prg
!- CBM-II / P500
!--------------------------------------------------
10 rem cbm2dle - for cbm-ii/p500
20 rem =======
30 rem by bo zimmerman and steve gray
40 rem v1.0, 2022-02-26
50 rem-------------------------------
60 :
70 :
100 gosub3000
110 gosub2000:dimsc(7)
120 open1,8,15:open8,8,8,"scoredle,s,r"
130 input#1,e:ife>0then160
140 fori=1to7:input#8,sc(i):nexti
160 close8:close1
170 bank15:if peek(1024)=76goto210
190 ifl=0thenl=1:bload"cbm2dict.bin",d0,u8,onb1
200 ifl=1thenl=2:bload"cbm2ml.bin",d0,u8,onb15
209 a$=ti$:ti=0:fori=5to8:ti=ti+peek(i):next:i=rnd(-ti)
210 :
220 rem---- generate the word
230 :
240 wx=int(rnd(.)*mw)
250 poke1031,int(wx/256)
260 poke1030,wx-(256*peek(1031))
270 sys1024:ifpeek(1030)=0then240
280 w$=""
290 fori=0to4
300 w$=w$+chr$(peek(1030+i))
310 next
315 sc(7)=sc(7)+1
320 :
330 rem---- draw screen
340 :
350 printtc$;"{clear}{142}{space*2}cbm2dle - guess the 5 letter word!
360 PRINT L$
370 S$="{space*5}"
380 N=3
390 FORJ=1TO6
400 PRINT T$;
410 GOSUB940
420 NEXT J
430 PRINT"{down*3}";TC$;L$
450 IFMT=0 THENPRINT"{space*4}{reverse on}{space*3}{reverse off}=correct {cm +*3}=place [ ]=wrong{home}{down}
452 ifmt=1 thenprint"{space*4}{green}{reverse on}{space*3}{reverse off}{black}=correct {yellow}{reverse on}{space*3}{reverse off}{black}=place {gray}{reverse on}{space*3}{reverse off}{black}=wrong{home}{down}
490 :
500 REM---- ENTER A GUESS
510 :
520 GU=1
530 PRINTT$;
540 C=0:G$=""
550 E=0:GOSUB1070:EN=0
560 :
570 REM---- CHECK IT
580 :
585 IFG$=B7$THENS$=G$:GET A$:IFA$=""THENGOSUB960:PRINTSPC(RND(1)*30);:GOTO585
590 FORI=1TO5
600 A$=MID$(G$,I,1)
610 POKE1029+I,ASC(A$)
620 IFMID$(W$,I,1)=A$THENFE=0:GOTO670
630 FE=1
640 FORII=1TO5
650 IF MID$(W$,II,1)=A$THENIFMID$(G$,II,1)<>A$THENFE=2
660 NEXTII
670 AN(I)=FE
680 NEXTI
690 IFE=1GOTO550
700 SYS1027
710 IFPEEK(1030)=0THENPRINT"{down}not a word!{left*11}{up}";:EN=1:GOTO550
720 :
730 REM---- DISPLAY RESULTS
740 :
750 PRINT"{up}"
760 PRINTT$;
770 FORI=1TO5
780 N=AN(I):C$=MID$(G$,I,1)
790 GOSUB1020
800 NEXTI
810 PRINT"{down*2}
820 :
830 rem---- check for win
840 :
850 gu=gu+1
860 ifw$=g$thenprint p$;tc$;"you win!":sc(gu-1)=sc(gu-1)+1:goto890
870 ifgu>6thenprint p$;"you failed. the word was: ";w$:goto890
880 goto530
890 printtc$;"play again (y/n)?";
900 geta$:ifa$="y"goto220
910 ifa$<>"n"goto900
915 open8,8,8,"@0:scoredle,s,w":fori=1to7:print#8,sc(i):nexti:close8
920 print"{clear}";tc$;:gosub3400:end
930 :
940 rem---- print string inside boxes
950 :
960 fora=1tolen(s$)
970 c$=mid$(s$,a,1):gosub1020
980 next
990 print"{down*2}
1000 RETURN
1010 :
1020 REM---- DRAW BOX WITH LETTER INSIDE
1030 :
1048 PRINT B$(N);B4$;C$;B5$;
1050 RETURN
1060 :
1070 REM---- ENTER GUESS
1080 :
1090 PRINT"";
1100 GETC$:IFC$=""GOTO1100
1101 IFC$=CHR$(27)THEN END
1110 IFC=5 AND C$=CHR$(13)THENRETURN
1120 IFEN=1THENEN=0:PRINT"{down}{reverse off}{space*11}{left*11}{up}";
1130 IFC>0 AND C$=CHR$(20)THENGOSUB1200
1140 IFC=5GOTO1100
1150 IFC$<"a"OR C$>"z"GOTO1100
1160 N=4:GOSUB1020
1170 G$=G$+C$:C=C+1
1180 GOTO1100
1190 :
1200 REM---- REMOVE CHARACTER
1210 :
1220 G$=LEFT$(G$,LEN(G$)-1):C=C-1
1240 PRINT"{left*3}";B$(3);"{left*3}";
1250 RETURN
1260 :
2000 REM---- TITLE SCREEN
2010 :
2015 X$="{space*2}"
2025 PRINT"{clear}{142}{down*3}
2026 n=0:printx$;
2030 s$="{space*3}cbm2dle{space*2}":gosub960
2035 n=1:printx$;
2040 s$="{space*5}by{space*5}":gosub960
2045 n=2:printx$;
2050 s$=" steve gray ":gosub960
2055 n=1:printx$;
2060 s$="{space*4}and{space*5}":gosub960
2065 n=2:printx$;
2070 s$="bo zimmerman":gosub960
2080 print"{black}{down*2}";t$;"loading... "
2100 return
2999 :
3000 rem---- identify machine
3001 :
3010 mt=0:sc=53248:print"{clear}{down}.
3020 bank15:IFPEEK(SC+40)=46THENMT=1
3022 :
3030 REM---- COMMON VARS
3031 :
3040 MW=12943
3042 W$=""
3044 T$="{space*12}"
3046 Z$="{reverse on}{space*3}{reverse off}="
3049 TC$=""
3050 L$="{sh asterisk*39}"
3060 B4$="{down}{left*2}"
3062 B5$="{up}{right}"
3064 B6$=CHR$(69):B7$=CHR$(83)+CHR$(84)+B6$+CHR$(86)+B6$
3066 P$="{home}{down*21}"
3080 IFMT=1 GOTO 3200
3099 :
3100 REM---- B-SERIES
3101 :
3110 B$(0)="{reverse on}o{cm t}p{down}{left*3}{cm g} {cm m}{down}{left*3}l{cm @}{sh @}{up*2}"
3120 B$(1)="{reverse off}o{cm t}p{down}{left*3}{cm g} {cm m}{down}{left*3}l{cm @}{sh @}{up*2}"
3130 B$(2)="{reverse off}{cm +*3}{down}{left*3}{cm +*3}{down}{left*3}{cm +*3}{up*2}"
3140 B$(3)="{reverse off}o{cm t}p{down}{left*3}{cm g} {cm m}{down}{left*3}l{cm @}{sh @}{up*2}"
3145 B$(4)="{reverse off}o{cm t}p{down}{left*3}{cm g} {cm m}{down}{left*3}l{cm @}{sh @}{up*2}"
3150 RETURN
3199 :
3200 REM---- P500
3201 :
3250 B$(0)="{green}{reverse on}o{cm y}p{down}{left*3}{cm g} {cm m}{down}{left*3}l{cm p}{sh @}{up*2}"
3260 B$(1)="{gray}{reverse on}o{cm y}p{down}{left*3}{cm g} {cm m}{down}{left*3}l{cm p}{sh @}{up*2}"
3270 B$(2)="{yellow}{reverse on}o{cm y}p{down}{left*3}{cm g} {cm m}{down}{left*3}l{cm p}{sh @}{up*2}"
3280 B$(3)="{light gray}{reverse on}o{cm y}p{down}{left*3}{cm g} {cm m}{down}{left*3}l{cm p}{sh @}{up*2}"
3285 B$(4)="{black}{reverse on}o{cm y}p{down}{left*3}{cm g} {cm m}{down}{left*3}l{cm p}{sh @}{up*2}"
3290 TC$="{black}":REM BLACK
3300 POKE55328,4:REM BORDER
3310 RETURN
3400 PRINT"totals out of";SC(7);"games."
3410 FORI=1TO6:PRINT"guess";I;":";SC(I):NEXTI:RETURN
