*&---------------------------------------------------------------------*
*& Report Z_S09_SCHLEIFEN_AUFGABE2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_SCHLEIFEN_AUFGABE2.

DATA lv_Jahr TYPE i VALUE 2022.
DATA lv_mon  TYPE i VALUE 1.
DATA lv_tag  TYPE i VALUE 1.

DATA lv_Ausgabe TYPE string.
DATA lv_jahr_c  TYPE string.
DATA lv_mon_c   TYPE string.
DATA lv_tag_c   TYPE string.

DO 12 TIMES. "12 Monate"


IF lv_mon = '1'. ADD 1 TO lv_tag.
ENDIF.

IF lv_mon = '2'. SUBTRACT 2 FROM lv_tag.

ENDIF.


IF lv_mon = '3'.  ADD 1 TO lv_tag.

ENDIF.

IF lv_mon = '5'. ADD 1 TO lv_tag.

ENDIF.
IF lv_mon = '7'. ADD 1 TO lv_tag.

ENDIF.
IF lv_mon = '8'. ADD 1 TO lv_tag.

ENDIF.
IF lv_mon = '10'. ADD 1 TO lv_tag.

IF lv_mon = '12'. ADD 1 TO lv_tag.

ENDIF.


ENDIF.




  DO 30 TIMES. " 30 Tage pro Monat"
    " lv_jahr_c = lv_jahr.
    "lv_mon_c = lv_mon.
    "CONCATENATE lv_jahr_c '-' lv_mon_c '-' lv_tag_c INTO lv_ausgabe.
    "WRITE: / lv_ausgabe.

    WRITE: / |{ lv_jahr } - { lv_mon } - { lv_TAG } |.

    ADD 1 TO lv_tag.
    ENDDO.
    ADD 1 TO lv_mon.
    lv_tag = 1.

ENDDO.
