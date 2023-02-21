!--------------------------------------------------
!- Tuesday, February 21, 2023 2:52:31 PM
!- Import of : 
!- c:\dev\c=ordle\teddle\teddle-364.prg
!- Unexpanded VIC20 / C16 / Plus4
!--------------------------------------------------
10 rem teddle - for plus/4 or v364
20 rem ======
30 rem by bo zimmerman and steve gray
40 rem v1.0, 2022-02-22
50 rem-------------------------------
60 :
70 ifpeek(56)<>119thenpoke56,119:clr
80 :
90 mw=12943
100 w$=""
110 t$="{space*12}"
120 z$="{reverse on}{space*3}{reverse off}{black}="
130 b1$="{reverse on}O{183}P{down}{left*3}{165}"
140 b2$="{170}{down}{left*3}L{175}{186}{up*2}"
150 p$="{home}{down*21}"
160 l$="{black}CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC"
170 ifpeek(30720)=76 goto 210
180 gosub2000
190 ifl=0thenl=1:load"teddldict.bin",8,1
200 ifl=1thenl=2:load"teddlml.bin",8,1
210 :
220 rem---- generate the word
230 :
240 wx=int(rnd(.)*mw)
250 poke30727,int(wx/256)
260 poke30726,wx-(256*peek(30727))
270 sys30720
280 w$=""
290 fori=0to4
300 w$=w$+chr$(peek(30726+i))
310 next
320 :
330 rem---- draw screen
340 :
350 print"{clear}{black}{space*3}teddle - guess the 5 letter word!"
360 print l$
370 s$="{space*5}"
380 n=3:gosub1270
390 forj=1to6
400 print t$;
410 gosub940
420 next j
430 print"{down*3}";l$
440 print"{space*4}";
450 n=0:gosub1270:print z$;"correct ";
460 n=2:gosub1270:print z$;"place ";
470 n=1:gosub1270:print z$;"wrong";
480 print"{home}{down}
490 :
500 REM---- ENTER A GUESS
510 :
520 GU=1
530 PRINT T$;
540 C=0:G$=""
550 E=0:GOSUB1070:EN=0
560 :
570 REM---- CHECK IT
580 :
590 FORI=1TO5
600 A$=MID$(G$,I,1)
610 POKE30725+I,ASC(A$)
620 IFMID$(W$,I,1)=A$ THEN FE=0:GOTO670
630 FE=1
640 FOR II=1 TO 5
650 IF MID$(W$,II,1)=A$ THEN FE=2
660 NEXT II
670 AN(I)=FE
680 NEXT I
690 IF E=1 GOTO 550
700 SYS30723
710 IF PEEK(30726)=0 THEN PRINT"{red}{down}not a word!{left*11}{up}";:EN=1:GOTO550
720 :
730 REM---- DISPLAY RESULTS
740 :
750 PRINT"{up}"
760 PRINT T$;
770 FOR I=1 TO 5
780 N=AN(I):GOSUB 1270:C$=MID$(G$,I,1)
790 GOSUB1020
800 NEXT I
810 PRINT"{down*2}
820 :
830 rem---- check for win
840 :
850 gu=gu+1
860 if w$=g$ then print p$;"{green}you win!":last_token "you win":goto 890
870 if gu>6 then print p$;"{red}you failed. the word was: {black}";w$:last_token"sorry":goto 890
875 goto530
880 last_token "play again"
890 print"{black}play again (y/n)?";
900 get a$:if a$="y" goto 220
910 if a$<>"n"goto900
915 last_token "good bye"
920 print"{clear}{black}";:end
930 :
940 rem---- print string inside boxes
950 :
960 fora=1to len(s$)
970 c$=mid$(s$,a,1):gosub 1020
980 next
990 print"{down*2}
1000 RETURN
1010 :
1020 REM---- DRAW BOX WITH LETTER INSIDE
1030 :
1040 PRINT B1$;C$;B2$;
1050 RETURN
1060 :
1070 REM---- ENTER GUESS
1080 :
1090 PRINT"{black}";
1100 GET C$:IF C$="" GOTO 1100
1110 IF C=5 AND C$=CHR$(13) THEN RETURN
1120 IFEN=1THENEN=0:PRINT"{down}{black}{reverse off}{space*11}{left*11}{up}";
1130 IF C>0 AND C$=CHR$(20) THEN GOSUB1200
1140 IF C=5 GOTO 1100
1150 IF C$<"a" OR C$>"z" GOTO 1100
1155 N=ASC(C$)-44:LAST_TOKEN N
1160 GOSUB 1020
1170 G$=G$+C$:C=C+1
1180 GOTO 1100
1190 :
1200 REM---- REMOVE CHARACTER
1210 :
1215 LAST_TOKEN "correct"
1220 G$=LEFT$(G$,LEN(G$)-1):C=C-1
1230 N=3:GOSUB 1270
1240 PRINT"{left*3}";B1$;" ";B2$;"{left*3}{black}";
1250 RETURN
1260 :
1270 REM---- SET COLOR
1280 :
1290 IF N=0 THEN COLOR 1,6,4:REM GREEN
1300 IF N=1 THEN COLOR 1,2,3:REM GREY
1310 IF N=2 THEN COLOR 1,8,5:REM YELLOW
1320 IF N=3 THEN COLOR 1,2,6:REM LT GRY
1330 RETURN
2000 REM
2010 :
2015 X$="{space*2}"
2020 PRINT"{clear}{down*3}
2022 last_token "please wait"
2025 n=0:gosub 1290:printx$;
2030 s$="{space*3}teddle{space*3}":gosub 960
2035 n=1:gosub 1290:printx$;
2040 s$="{space*5}by{space*5}":gosub 960
2045 n=2:gosub 1290:printx$;
2050 s$="bo zimmerman":gosub 960
2055 n=1:gosub 1290:printx$;
2060 s$="{space*5}and{space*4}":gosub 960
2065 n=2:gosub 1290:printx$;
2070 s$=" steve gray ":gosub 960
2080 print"{black}{down*2}{space*14}loading... "
2100 return
2110 return
