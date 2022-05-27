*&---------------------------------------------------------------------*
*& Report Z_S04_SCHLEIFEN_AUFGABE2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_schleifen_aufgabe2.

DATA lv_day   TYPE i VALUE 01.
DATA lv_month TYPE i VALUE 01.
DATA lv_year  TYPE string VALUE 2022.
DATA lv_zeile TYPE i VALUE 01.


WRITE: '      Zeile | Jahr  | Monat | Tag'.

ULINE.

DO 12 TIMES.

  IF lv_month EQ 1 OR lv_month EQ 3 OR lv_month EQ 5 OR lv_month EQ 7 OR lv_month EQ 8 OR lv_month EQ 10 OR lv_month EQ 12.

    DO 31 TIMES.

      "WRITE: / |{ lv_year }-{ lv_month }-{ lv_day }|.
      WRITE: / lv_zeile,'|',|{ lv_year }|,'|',|{ lv_month }|,'    |',|{ lv_day }|.

      ADD 1 TO lv_zeile.
      ADD 1 TO lv_day.

    ENDDO.
  ENDIF.

  IF lv_month EQ 2.

    DO 28 TIMES.

      WRITE: / lv_zeile,'|',|{ lv_year }|,'|',|{ lv_month }|,'    |',|{ lv_day }|.

      ADD 1 TO lv_zeile.
      ADD 1 TO lv_day.

    ENDDO.

  ENDIF.

  IF lv_month EQ 4 OR lv_month EQ 6 OR lv_month EQ 9 OR lv_month EQ 11.

    DO 30 TIMES.

      WRITE: / lv_zeile,'|',|{ lv_year }|,'|',|{ lv_month }|,'    |',|{ lv_day }|.

      ADD 1 TO lv_zeile.
      ADD 1 TO lv_day.

    ENDDO.

  ENDIF.

  ULINE.
  WRITE: '      Zeile | Jahr  | Monat | Tag'.
  ULINE.

  ADD 1 TO lv_month.
  lv_day = 01.

ENDDO.
