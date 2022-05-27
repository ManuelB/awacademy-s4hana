*&---------------------------------------------------------------------*
*& Report Z_S12_SCHLEIFEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_schleifen.

DATA: lv_i     TYPE i VALUE 1, ": bla bla bla. startet einen Kettensatz
      lv_times TYPE i VALUE 5.

*DO Schleife
WRITE: / 'DO Schleife'.
DO lv_times TIMES.
  WRITE: / lv_i.

  ADD 10 TO lv_i.
  IF lv_i GT 30.
    EXIT. "Springt aus der Schleife
  ENDIF.

ENDDO.


ULINE.
*WHILE Schleife#
WRITE: / 'WHILE Schleife'.
lv_times = 30.

WHILE lv_times GT 0. "Abbruchbedingung

  SUBTRACT 1 FROM lv_times.
  DATA(lv_rest) = lv_times MOD 2. "INLINE Deklaration - MOD "durch 2 teilbar"
  IF lv_rest IS INITIAL. "IS INITIAL wenn der Wert der Variable der durch MOD deklarierten Funktion entspricht
    CONTINUE. "gibt nur Zahlen wieder auf die die MOD Funktion nicht zutrifft.

  ENDIF.
  WRITE: / lv_times.

ENDWHILE.


ULINE.
WRITE: / 'Aufgabe'.
DATA lv_year_c TYPE string.
DATA lv_month_c TYPE string.
DATA lv_day_c TYPE string.
DATA lv_ausgabe TYPE string.

*Im Debugger Manuell die Werte für das Jahr und den Monat eingefügt.

DO 12 TIMES. "Anzahl der Monate
  lv_year_c = 2022.
  lv_month_c = 1.
  DO 30 TIMES. "Anzahl der Tage
    WRITE: / |{ lv_year_c } - { lv_month_c } - { lv_day_c }|. "Ausgabeastring für das Datum
    ADD 1 TO lv_day_c.

  ENDDO.

  ADD 1 TO lv_month_c.
  lv_day_c = 1.


ENDDO.

*DO lv_month TIMES.
*  WRITE: / 'Datum'.
*   WRITE: / lv_day, lv_month, lv_year.
*   ADD 1 TO lv_month.
*  DO lv_day TIMES.
* WRITE: / lv_day, lv_month, lv_year.
*  ENDDO. lv_day EQ 30.
* WRITE: / lv_day, lv_month, lv_year.
*ENDDO. lv_month EQ 12.




*WHILE lv_day LE 30.
*  ADD 1 TO lv_day.
*  DATA(lv_datum) = lv_day MOD 1.
*  IF lv_datum IS INITIAL.
*    CONTINUE.
*  ENDIF.
*  CONCATENATE lv_year lv_month lv_day '.' INTO lv_date SEPARATED BY ' '.
*  WRITE: / lv_date.
*
*
*ENDWHILE.

*WHILE lv_day LT 30 AND lv_month LT 12.
*  ADD 1 TO lv_day.
*  ADD 1 TO lv_month.
*
*  IF lv_day IS INITIAL.
*    CONTINUE.
*  ELSEIF lv_month IS INITIAL.
*    CONTINUE.
*  ENDIF.
*  WRITE: / lv_day.
*
*  WRITE: / lv_month.
*
*ENDWHILE.
