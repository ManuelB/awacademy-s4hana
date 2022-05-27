*&---------------------------------------------------------------------*
*& Report Z_S04_DATUM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_datum.

DATA lv_day   TYPE string VALUE 01.
DATA lv_month TYPE string VALUE 01.
DATA lv_year  TYPE string VALUE 2022.
DATA lv_zeile TYPE string VALUE 01.


WRITE: / 'Zeile | Jahr - Monat - Tag'.


DO 12 TIMES.

  ULINE.

  DO 30 TIMES.

    WRITE: /(5) lv_zeile, '|', lv_year, '-', lv_month, '-', lv_day.

    ADD 1 TO lv_zeile.
    ADD 1 TO lv_day.

  ENDDO.

ULINE.

  ADD 1 TO lv_month.
  lv_day = 01.

ENDDO.
