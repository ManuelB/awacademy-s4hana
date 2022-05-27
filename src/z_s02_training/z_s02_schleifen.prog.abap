*&---------------------------------------------------------------------*
*& Report Z_S02_SCHLEIFEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_schleifen.

*" es gibt verschiedenen SChleifen. Loop für Tabellen. Do-Schleife gibt es auch. While-Schleife auch.
*
*DATA: lv_i     TYPE i VALUE 1,
*      lv_times TYPE i VALUE 20.
*
*
*WRITE: / 'DO-SChleife'.
** Do-Schleife
*
*DO 5 TIMES.
*  WRITE: / lv_i.
*  ADD 10 TO lv_i.
*  IF lv_i GT 30.
*    EXIT.
*  ENDIF.
*ENDDO.
*
*ULINE.
*
*
*
*WRITE: / 'WHILE-SChleife'.
**WHILE-Schleife
*
*
*
*lv_times = 30.
*
*WHILE lv_times GE 0. "while und Abbruchbedingung
*  SUBTRACT 1 FROM lv_times.
*
*  DATA(lv_rest) = lv_times MOD 2. "Inlinedeklaration. in lv_rest steht drin, was der REst ist bei der Division von 2. Also 1 oder 0.
*  IF lv_rest IS INITIAL. "Bedeutet, dass wenn der Wert der Variable leer ist, bedeutet bei Integer auch 0.
*    CONTINUE.
*  ENDIF.
*
*
*  WRITE: / lv_times.
*
*ENDWHILE.

"Jahr-Monat-Tag

*DATA: lv_days   TYPE i VALUE IS INITIAL,
*      lv_months TYPE i.
*lv_months = 1.
*
*
*WHILE lv_months LE 12.
*  ADD 1 TO lv_days.
*  IF lv_days GT 30.
*    ADD 1 TO lv_months.
*  ELSEIF lv_days GT 60.
*    ADD 1 TO lv_months.
*  ELSEIF lv_days GT 90.
*    ADD 1 TO lv_months.
*  ELSEIF lv_days GT 120.
*    ADD 1 TO lv_months.
*  ELSEIF lv_days GT 150.
*    ADD 1 TO lv_months.
*  ELSEIF lv_days GT 180.
*    ADD 1 TO lv_months.
*  ELSEIF lv_days GT 210.
*    ADD 1 TO lv_months.
*  ELSEIF lv_days GT 240.
*    ADD 1 TO lv_months.
*  ELSEIF lv_days GT 270.
*    ADD 1 TO lv_months.
*  ELSEIF lv_days GT 300.
*    ADD 1 TO lv_months.
*  ELSEIF lv_days GT 330.
*    ADD 1 TO lv_months.
*  ELSEIF lv_days GE 360.
*    ADD 1 TO lv_months.
*
*  ENDIF.
*
*
*
*
*  WRITE: / '2022', '-', lv_months, '-', lv_days.
*
*ENDWHILE.
*
*

"WHILE
*DATA: lv_days   TYPE i,
*      lv_months TYPE i.
*lv_months = 1.
*lv_days = 1.
*
*WHILE lv_months LE 12.
*  WHILE lv_days LE 30.
*    WRITE: / '2022', '-', lv_months, '-', lv_days.
*    ADD 1 TO lv_days.
*  ENDWHILE.
*  ADD 1 TO lv_months.
*  lv_days = 1.
*ENDWHILE.


"DO
DATA: lv_days   TYPE i,
      lv_months TYPE i.
lv_months = 1.
lv_days = 1.

DO 12 TIMES.
  DO 30 TIMES.
    WRITE: / '2022', '-', lv_months, '-', lv_days.
    ADD 1 TO lv_days.
  ENDDO.
  ADD 1 TO lv_months.
  lv_days = 1.
ENDDO.
