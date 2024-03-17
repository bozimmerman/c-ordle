!--------------------------------------------------
!- Sunday, March 17, 2024 1:11:34 PM
!- Import of : 
!- c:\dev\c-ordle\friendle\friendle.prg
!- VIC20 with 32K expansion
!--------------------------------------------------
10 REM FRIENDLE VIC20
20 REM ========
22 REM      BY
30 REM BO ZIMMERMAN
34 REM & STEVE GRAY
36 REM
40 REM 2024-03-17
60 :
70 PRINTCHR$(142);:IFPEEK(56)<>39THENPOKE56,39:POKE55,16:CLR
80 :
90 MW=12943:REM POKE36879,0
100 W$=""
110 T$=" "
112 V$="{green}{red}{cyan}{blue}":REM COLORS
120 Z$="{reverse on}{space*2}{reverse off}{black}"
130 B1$="{reverse on}O"+CHR$(163)+"P{down}{left*3}{cm g}"
140 B2$=CHR$(167)+"{down}{left*3}L"+CHR$(164)+"{sh @}{up*2}"
150 P$="{home}{down*21}"
160 L$=" CCCCCCCCCCCCCCCCCCCC"
170 IFPEEK(6064)=76 THEN 210
180 IFL=0THENGOSUB2000
190 IFL=0THENL=1:LOAD"friendict2.bin",8,1
200 IFL=1THENL=2:LOAD"friendlml.bin",8,1
205 IFL=2THENL=3:LOAD"friendict.bin",8,1
210 GOSUB3000
215 :
220 REM-GENERATE THE WORD
230 :
240 WX=INT(RND(.)*MW)
250 POKE10007,INT(WX/256)
260 POKE10006,WX-(256*PEEK(10007))
270 SYS10000:IFPEEK(10006)=0THEN240
280 W$=""
290 FORI=0TO4
300 W$=W$+CHR$(PEEK(10006+I))
310 NEXT
315 SC(7)=SC(7)+1
320 :
330 REM-DRAW SCREEN
340 :
350 PRINT"{clear}{black}{space*7}friendle
360 PRINT L$
370 S$="{space*5}"
380 N=3:GOSUB1270
390 FORJ=1TO6
400 PRINT T$;
410 GOSUB940
420 NEXT J
430 PRINT "{black}";L$:PRINT" ";
450 N=0:GOSUB1270:PRINT Z$;"{black}good ";
460 N=2:GOSUB1270:PRINT Z$;"{black}place ";
470 N=1:GOSUB1270:PRINT Z$;"{black}bad";
480 PRINT"{home}{down*2}";
490 :
500 REM-ENTER GUESS
510 :
520 GU=1
530 PRINT T$;
540 C=0:G$=""
550 E=0:GOSUB1070:EN=0
560 :
570 REM-CHECK IT
580 :
590 FORI=1TO5
600 A$=MID$(G$,I,1)
610 POKE10005+I,ASC(A$)
620 IFMID$(W$,I,1)=A$ THEN FE=0:GOTO670
630 FE=1
640 FOR II=1 TO 5
650 IF MID$(W$,II,1)=A$ THEN IFMID$(G$,II,1) <> A$ THEN FE=2
660 NEXT II
670 AN(I)=FE
680 NEXT I
690 IF E=1 GOTO 550
700 SYS10003
710 IF PEEK(10006)=0 THEN PRINT"{red}{down}not a{down}{left*5}word!{left*5}{up*2}";:EN=1:GOTO550
720 :
730 REM-SHOW RESULTS
740 :
750 PRINT"{up}"
760 PRINT T$;
770 FOR I=1 TO 5
780 N=AN(I):GOSUB 1270:C$=MID$(G$,I,1)
790 GOSUB1020
800 NEXT I
810 PRINT"{down*2}
820 :
830 REM-CHECK WIN
840 :
850 GU=GU+1
860 IF W$=G$ THEN PRINT P$;"{blue} you win!{space*12}":SC(GU-1)=SC(GU-1)+1:GOTO 890
870 IF GU>6 THEN PRINT P$;"{black} sorry, the word was:{blue}":PRINT " ";W$;:GOTO 890
880 GOTO530
890 PRINT"{black} play again? ";
900 GET A$:IF A$="y" GOTO 220
910 IF A$<>"n"GOTO900
911 :
912 PRINT:PRINT"{down} thanks for playing!"
915 OPEN8,8,8,"@0:scoredle,s,w":FORI=1TO7:PRINT#8,SC(I):NEXTI:CLOSE8
920 PRINT"{clear}{black}":GOSUB3400:END
930 :
940 REM-PRINT STRING IN BOXES
950 PRINTMID$(V$,N+1,1);
960 FORA=1TO LEN(S$)
970 C$=MID$(S$,A,1):GOSUB 1020
980 NEXT
990 PRINT"{down*2}
1000 RETURN
1010 :
1020 REM-DRAW BOX+LETTER
1030 :
1040 PRINT B1$;C$;B2$;
1050 RETURN
1060 :
1070 REM---- ENTER GUESS
1080 :
1090 PRINT"{black}";
1100 GET C$:IF C$="" GOTO 1100
1110 IF C=5 AND C$=CHR$(13) THEN RETURN
1120 IFEN=1THENEN=0:PRINT"{reverse off}{down}{space*5}{left*5}{down}{space*5}{left*5}{up*2}";
1130 IF C>0 AND C$=CHR$(20) THEN GOSUB1200
1140 IF C=5 GOTO 1100
1150 IF C$<"a" OR C$>"z" GOTO 1100
1160 PRINT"{black}";:GOSUB 1020
1170 G$=G$+C$:C=C+1
1180 GOTO 1100
1190 :
1200 REM-DEL CHR
1210 :
1220 G$=LEFT$(G$,LEN(G$)-1):C=C-1
1230 N=3:GOSUB 1270
1240 PRINT"{left*3}";B1$;" ";B2$;"{left*3}{white}";
1250 RETURN
1260 :
1270 REM-SET COLOR
1280 :
1290 PRINTMID$(V$,N+1,1);
1300 RETURN
1330 :
2000 REM
2010 :
2015 X$="{space*2}"
2020 PRINT"{clear}{down}
2030 S$="friend-":N=0:GOSUB 950
2032 S$="le{space*5}":N=0:GOSUB 950
2040 S$="{space*2}by:{space*2}":N=2:GOSUB 950
2050 S$="bo zimm":N=1:GOSUB 950
2054 S$="{space*2}and{space*2}":N=2:GOSUB 950
2060 S$="steve g":N=3:GOSUB 950
2080 PRINT"{down}{black}{space*6}loading... "
2100 RETURN
2110 RETURN
3000 DIMSC(7):OPEN1,8,15:OPEN8,8,8,"scoredle,s,r"
3010 INPUT#1,E:IFE>0THEN3030
3020 FORI=1TO7:INPUT#8,SC(I):NEXTI
3030 CLOSE8:CLOSE1
3400 PRINT"totals out of";SC(7);"games."
3410 FORI=1TO6:PRINT"guess";I;":";SC(I):NEXTI:RETURN
