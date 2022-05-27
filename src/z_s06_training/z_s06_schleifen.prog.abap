*&---------------------------------------------------------------------*
*& Report Z_S06_SCHLEIFEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_SCHLEIFEN.

DATA: lv_i     TYPE i VALUE 1,
      lv_times TYPE i VALUE 5.

Do Schleife
WRITE: / 'Do Schleife'.

DO 5 TIMES.
  WRITE: / lv_i.
  ADD 10 TO lv_i.
  IF lv_i GT 30.
    EXIT."Abbruchbedinung
  ENDIF.
ENDDO.
ULINE.

While Schleife

lv_times = 30.
WRITE: / 'While Schleife'.
WHILE lv_times GE 0.
  SUBTRACT 1 FROM lv_times.

  DATA(lv_rest) = lv_times MOD 2.

  IF lv_rest IS INITIAL.
    CONTINUE.
  ENDIF.
  WRITE: / lv_times.
ENDWHILE.

"Datum
WRITE: / 'FEB 2022'

DDMMYY.
