*&---------------------------------------------------------------------*
*& Report Z_S06_DATUM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S06_DATUM.
"Datum

DATA: lv_tag TYPE i VALUE 01.
Data: lv_monat TYPE i VALUE 01.
DATA: lv_jahr TYPE i VALUE 2022.

DO 120 TIMES.
Write: / |{ lv_tag }-{ lv_monat }-{ lv_jahr }|.
add 1 TO lv_tag.
IF lv_tag GE 31.
ADD 1 to lv_monat.
lv_tag = 01.
ENDIF.
IF lv_monat GE 12.
  ADD 1 to lv_jahr.
  ENDIF.

ENDDO.
**********************************************************************
"Ubungsaufgabe

*DO 12 TIMES.

*  DO 30 TIMES.
*    Write: / |{ lv_tag }-{ lv_monat }-{ lv_jahr }|.
*    ADD 1 TO lv_tag.
*
*  ENDDO.
*ADD 1 TO lv_monat.
*ENDDO.
"espresso totoruals (Schnell einstig ABAP)???
