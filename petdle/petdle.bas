!--------------------------------------------------
!- Tuesday, February 21, 2023 2:49:45 PM
!- Import of : 
!- c:\dev\c=ordle\petdle\petdle.prg
!- VIC20 with 3K expansion
!--------------------------------------------------
10 rem petdle - for pet 32k
20 rem ======
30 rem by bo zimmerman and steve gray
40 rem v1.0, 2022-02-24
50 rem-------------------------------
60 :
70 ifpeek(53)<>19thenpoke53,19:poke52,176:clr
90 mw=12943
100 w$=""
110 t$="{space*12}"
120 z$="{reverse on}{space*3}{reverse off}="
130 b$(0)="{reverse on}O{cm t}P{down}{left*3}{cm g} {cm m}{down}{left*3}L{cm @}{sh @}{up*2}"
131 b$(1)="{reverse off}O{cm t}P{down}{left*3}{cm g} {cm m}{down}{left*3}L{cm @}{sh @}{up*2}"
132 b$(2)="{reverse off}{cm +*3}{down}{left*3}{cm +*3}{down}{left*3}{cm +*3}{up*2}"
133 b$(3)="{reverse off}O{cm t}P{down}{left*3}{cm g} {cm m}{down}{left*3}L{cm @}{sh @}{up*2}"
140 b4$="{down}{left*2}"
145 b5$="{up}{right}"
146 b6$=chr$(69):b7$=chr$(83)+chr$(84)+b6$+chr$(86)+b6$
150 p$="{home}{down*21}"
160 l$="CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC"
170 ifl=0thengosub2000:gosub3300
180 ifpeek(5040)=76goto210
190 ifl=0thenl=1:load"petdldict.bin",8,1
200 ifl=1thenl=2:load"petdlml.bin",8,1
210 :
220 rem---- generate the word
230 :
240 wx=int(rnd(.)*mw)
250 poke5047,int(wx/256)
260 poke5046,wx-(256*peek(5047))
270 sys5040:ifpeek(5046)=0then240
280 w$=""
290 fori=0to4
300 w$=w$+chr$(peek(5046+i))
310 next
315 sc(7)=sc(7)+1
320 :
330 rem---- draw screen
340 :
350 print"{clear}{142}{space*3}petdle - guess the 5 letter word!
360 PRINT L$
370 S$="{space*5}"
380 N=3
390 FORJ=1TO6
400 PRINT T$;
410 GOSUB940
420 NEXT J
430 PRINT"{down*3}";L$
450 PRINT"{space*4}{reverse on}{space*3}{reverse off}=correct {cm +*3}=place [ ]=wrong{home}{down}
490 :
500 rem---- enter a guess
510 :
520 gu=1
530 printt$;
540 c=0:g$=""
550 e=0:gosub1070:en=0
560 :
570 rem---- check it
580 :
585 ifg$=b7$thens$=g$:get a$:ifa$=""thengosub960:printspc(rnd(1)*30);:goto585
590 fori=1to5
600 a$=mid$(g$,i,1)
610 poke5045+i,asc(a$)
620 ifmid$(w$,i,1)=a$thenfe=0:goto670
630 fe=1
640 forii=1to5
650 if mid$(w$,ii,1)=a$thenifmid$(g$,ii,1)<>a$thenfe=2
660 nextii
670 an(i)=fe
680 nexti
690 ife=1goto550
700 sys5043
710 ifpeek(5046)=0thenprint"{down}not a word!{left*11}{up}";:en=1:goto550
720 :
730 rem---- display results
740 :
750 print"{up}"
760 printt$;
770 fori=1to5
780 n=an(i):c$=mid$(g$,i,1)
790 gosub1020
800 nexti
810 print"{down*2}
820 :
830 REM---- CHECK FOR WIN
840 :
850 GU=GU+1
860 IFW$=G$THENPRINT P$;"you win!":SC(GU-1)=SC(GU-1)+1:GOTO890
870 IFGU>6THENPRINT P$;"you failed. the word was: ";W$:GOTO890
880 GOTO530
890 PRINT"play again (y/n)?";
900 GETA$:IFA$="y"GOTO220
910 IFA$<>"n"GOTO900
920 PRINT"{clear}";:GOSUB3400:POKE52,0:POKE53,128:CLR:END
930 :
940 REM---- PRINT STRING INSIDE BOXES
950 :
960 FORA=1TOLEN(S$)
970 C$=MID$(S$,A,1):GOSUB1020
980 NEXT
990 PRINT"{down*2}
1000 return
1010 :
1020 rem---- draw box with letter inside
1030 :
1048 printb$(n);b4$;c$;b5$;
1050 return
1060 :
1070 rem---- enter guess
1080 :
1090 print"";
1100 getc$:ifc$=""goto1100
1110 ifc=5 and c$=chr$(13)thenreturn
1120 ifen=1thenen=0:print"{down}{reverse off}{space*11}{left*11}{up}";
1130 ifc>0 and c$=chr$(20)thengosub1200
1140 ifc=5goto1100
1150 ifc$<"a"or c$>"z"goto1100
1160 n=0:gosub1020
1170 g$=g$+c$:c=c+1
1180 goto1100
1190 :
1200 rem---- remove character
1210 :
1220 g$=left$(g$,len(g$)-1):c=c-1
1240 print"{left*3}";b$(3);"{left*3}";
1250 return
1260 :
2000 rem---- title screen
2010 :
2015 x$="{space*2}"
2020 print"{clear}{142}{down*3}
2025 N=0:PRINTX$;:POKE59468,12
2030 S$="{space*3}petdle{space*3}":GOSUB960
2035 N=1:PRINTX$;
2040 S$="{space*5}by{space*5}":GOSUB960
2045 N=0:PRINTX$;
2050 S$=" steve gray ":GOSUB960
2055 N=1:PRINTX$;
2060 S$="{space*5}and{space*4}":GOSUB960
2065 N=0:PRINTX$;
2070 S$="bo zimmerman":GOSUB960
2080 PRINT"{black}{down*2}{space*14}loading... "
2100 RETURN
3300 OPEN1,8,15:OPEN8,8,8,"scordle,s,r"
3310 INPUT#1,E:IFE>0THEN3330
3320 FORI=1TO7:INPUT#8,SC(I):NEXTI
3330 CLOSE8:CLOSE1:RETURN
3400 OPEN8,8,8,"@0:scordle,s,w"
3410 FORI=1TO7:PRINT#8,SC(I):NEXTI
3420 CLOSE8
3440 PRINT"totals from";SC(7);"games"
3450 FORI=1TO6:PRINT"guess";I;":";SC(I):NEXTI
3460 RETURN
