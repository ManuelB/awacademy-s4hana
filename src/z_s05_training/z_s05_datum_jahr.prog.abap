*&---------------------------------------------------------------------*
*& Report Z_S05_DATUM_JAHR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_DATUM_JAHR.



DATA lv_tag TYPE string VALUE 1.
DATA lv_monat TYPE string VALUE 1.
DATA lv_jahr TYPE string VALUE 2022.
DATA lv_datum TYPE string.






DO 12 TIMES.





  DO 30 TIMES.


CONCATENATE  lv_tag lv_monat lv_jahr  INTO lv_datum SEPARATED BY '-'.
  CONDENSE lv_datum NO-GAPS.
   WRITE: / lv_datum.




  ADD 01 TO lv_tag.
  ENDDO.



 ADD 1 TO lv_monat.
  lv_tag = 01.
  ENDDO.
