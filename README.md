# C-ORDLE

Written by Bo Zimmerman and Steven J Gray

A port of the popular word-guessing game to various 8-bit Commodore computers.  Imported into CBM Prg Studio 4.0+ for distribution.

Also includes a dictionary generator in Java.

Sub-Projects:
- 6fourdle: Commodore 64 version
- friendle: Commodore VIC-20 version (35k)
- herdle: Commodore 128 version (40 or 80 cols)
- cbm2dle: Commodore CBM-II version (B128/610, P500, etc.)
- petdle: Commodore PET with 32k, BASIC 4.0
- teddle: Commodore Plus/4 and Commodore V364 version
- freddle: Commodore C65 and MEGA65 version
- word-table-maker: Java tool to generate dictionary file

Building:
- Build the BASIC program: e.g. herdle
- Build the ML binary: e.g. herdlml.bin
- Put the above on a disk, and include the dictionary file: e.g. herdict.bin

Running:
LOAD"HERDLE",8
RUN


