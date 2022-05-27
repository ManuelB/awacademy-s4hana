*&---------------------------------------------------------------------*
*& Report Z_S01_SCHLEIFEN02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S01_SCHLEIFEN02.

* Verstanden.

DATA lv_jahr Type I Value 2022.
DATA lv_mon Type I Value 1.
DATA lv_tag Type I Value 1.

*DATA lv_Ausgabe Type String.
*DATA lv_jahr_C Type String.
*DATA lv_mon_C Type String.
*DATA lv_tag_c Type String.

DO 12 TIMES.

  lv_tag = +1.
DO 30 TIMES.

*lv_jahr_c = lv_jahr "Type casting rechts wird links als c eingefügt."


write: / |{ lv_jahr } - { lv_mon } - { lv_Tag }|.

  lv_tag = lv_tag + 1.
ENDDO.
lv_mon = lv_mon + 1.
lv_tag = 1.
ENDDO.
