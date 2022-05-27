*&---------------------------------------------------------------------*
*& Report Z_S04_SCHLEIFEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_schleifen.

DATA: lv_i     TYPE i VALUE 0,
      lv_times TYPE i VALUE 25.


*DO Schleife
WRITE: / 'DO-SChleife'.
DO lv_times TIMES.

  WRITE: / lv_i.

  ADD 10 TO lv_i.

  IF lv_i GT 30.
    EXIT. "Abbruchbedingung
  ENDIF.

ENDDO.


ULINE.


*WHILE SChleife
WRITE: / 'WHILE-SChleife'.

lv_times = 30.

WHILE lv_times GE 0.

  SUBTRACT 1 FROM lv_times.

  DATA(lv_rest) = lv_times MOD 2.

  IF lv_rest IS INITIAL.
    CONTINUE.
  ENDIF.

  WRITE: / lv_times.


ENDWHILE.
