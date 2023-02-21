# C-ORDLE

Written by Bo Zimmerman and Steven J Gray

A port of the popular word-guessing game to various 8-bit Commodore computers.  Imported into CBM Prg Studio 4.0+ for distribution.

Also includes a dictionary generator in Java.

Sub-Projects:
- 128dle: Commodore 128 version (40 or 80 cols)
- cbm2dle: Commodore CBM-II version (B128/610, P500, etc.)
- petdle: Commodore PET with 32k, BASIC 4.0
- teddle: Commodore Plus/4 and Commodore V364 version
- word-table-maker: Java tool to generate dictionary file

Building:
- Build the BASIC program: e.g. 128dle
- Build the ML binary: e.g. 128dlml.bin
- Put the above on a disk, and include the dictionary file: e.g. 128dict.bin

Running:
LOAD"128DLE",8
RUN


