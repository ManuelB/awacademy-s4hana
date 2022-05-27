*&---------------------------------------------------------------------*
*& Report Z_AW07_SCHLEIFEN_AUFGABE_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_SCHLEIFEN_AUFGABE_2.

DATA lv_jahr TYPE i VALUE 2022.
DATA lv_mon  TYPE i VALUE 1.
DATA lv_tag  TYPE i VALUE 1 .

DATA lv_days TYPE i.

*DATA lv_Ausgabe TYPE string.
*DATA lv_jahr_c  TYPE string.
*DATA lv_mon_c   TYPE string.
*DATA lv_tag_c   TYPE string.

DO 12 TIMES. " 12 Monate
  CASE lv_mon.
    WHEN 1 or 3.
      lv_days = 31.
    WHEN 2.
      lv_days = 28.
*    WHEN 3.
*      lv_days = 31.
    WHEN 4.
      lv_days = 30.
    WHEN 5.
      lv_days = 31.
    WHEN 6.
      lv_days = 30.
    WHEN 7.
      lv_days = 31.
    WHEN 8.
      lv_days = 31.
    WHEN 9.
      lv_days = 30.
    WHEN 10.
      lv_days = 31.
    WHEN 11.
      lv_days = 30.
    WHEN 12.
      lv_days = 31.
    WHEN OTHERS.
  ENDCASE.

  DO lv_days TIMES. " 30 Tage Pro monat

    WRITE: / |{ lv_jahr }-{ lv_mon }-{ lv_TAG }|.

    ADD 1 TO lv_tag.
  ENDDO.
  ADD 1 TO lv_mon.
  lv_tag = 1.
ENDDO.
