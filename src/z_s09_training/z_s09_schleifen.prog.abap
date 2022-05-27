*&---------------------------------------------------------------------*
*& Report Z_S09_SCHLEIFEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_SCHLEIFEN.

DATA: lv_i TYPE i VALUE 1,
     lv_times TYPE i VALUE 5.

WRITE: / 'DO SCHLEIFE'.
"DO Schleife"
DO lv_times TIMES.

  WRITE: / lv_i.
  ADD 10 TO lv_i.

  IF lv_i GT 30.
    EXIT. "Abbruchbedingung"

  ENDIF.

ENDDO.


WRITE:/ 'WHILE SCHLEIFE'.
*WHILE Schleife

lv_times = 30.
WHILE lv_times GE 0. "Greater equal Null".

SUBTRACT 1 FROM lv_times.

DATA(lv_rest) = lv_times MOD 2.
if lv_rest IS INITIAL.
  CONTINUE.
  ENDIF.



WRITE: / lv_times.

ENDWHILE.
