*&---------------------------------------------------------------------*
*& Report Z_S03_SCHLEIFEN_AUGABE2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S03_SCHLEIFEN_AUGABE2.

DATA lv_jahr TYPE i VALUE 2022.
DATA lv_mon  TYPE i VALUE 1.
DATA lv_tag  TYPE i VALUE 1 .

DATA lv_Ausgabe TYPE string.
DATA lv_jahr_c  TYPE string.
DATA lv_mon_c   TYPE string.
DATA lv_tag_c   TYPE string.



DO 12 TIMES. " 12 Monate.

IF lv_mon = 2.
  DO 28 TIMES.
   WRITE: / |{ lv_jahr }-{ lv_mon }-{ lv_TAG }|.
    ADD 1 TO lv_tag.
  ENDDO.
 ADD 1 TO lv_mon.
  lv_tag = 1.
ENDIF.

IF  lv_mon = 4 OR lv_mon = 6 OR lv_mon = 9 OR lv_mon = 11.
  DO 30 TIMES. " 30 Tage Pro monat

*    lv_jahr_c = lv_jahr.
*    lv_mon_c = lv_mon.
*    lv_tag_c = lv_tag.
*    CONCATENATE lv_jahr_c '-' lv_mon_c '-' lv_tag_c INTO lv_ausgabe.
*    CONDENSE lv_ausgabe NO-GAPS.
*    WRITE / lv_ausgabe.

    WRITE: / |{ lv_jahr }-{ lv_mon }-{ lv_TAG }|.


    ADD 1 TO lv_tag.
  ENDDO.
  ADD 1 TO lv_mon.
  lv_tag = 1.
  ENDIF.

 IF  lv_mon = 1 OR lv_mon = 3 OR lv_mon = 5 OR lv_mon = 7 OR lv_mon = 8 OR lv_mon = 10.
  DO 31 TIMES.

    WRITE: / |{ lv_jahr }-{ lv_mon }-{ lv_TAG }|.


    ADD 1 TO lv_tag.
  ENDDO.
  ADD 1 TO lv_mon.
  lv_tag = 1.
  ENDIF.

ENDDO.
