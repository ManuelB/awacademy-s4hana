*&---------------------------------------------------------------------*
*& Report Z_S05_XPROBE32
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_XPROBE32.

*DATA: count TYPE i VALUE 3.
*DO 3 TIMES.
*WHILE count < 5.
*count = count + 1.
*IF count = 2.
*CONTINUE.
*ELSE.
*count = count + 2.
*ENDIF.
*ENDWHILE.
*ENDDO.
*WRITE: / count.

*DATA: a TYPE i VALUE 3, b TYPE i VALUE 7.
*
*B = a *b -c.
