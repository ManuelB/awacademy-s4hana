*&---------------------------------------------------------------------*
*& Report Z_S06_SCHLEIFEN_AUFGABE_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_schleifen_aufgabe_2.

"Ubungsaufgabe Datum.
**********************************************************************
DATA lv_jahr TYPE i VALUE 2022.
DATA lv_mon TYPE i VALUE 1.
DATA lv_tag TYPE i VALUE 1.
**********************************************************************
DO 12 TIMES.
  IF:  lv_mon = 1 OR lv_mon = 3 OR lv_mon = 5 OR lv_mon = 7 OR lv_mon = 8 OR lv_mon = 10 OR lv_mon = 12.
    DO 31 TIMES.
      WRITE: / |{ lv_jahr }-{ lv_mon }-{ lv_tag }|.
      ADD 1 TO lv_tag.
    ENDDO.
    ADD 1 TO lv_mon.
    lv_tag = 1.
    ULINE.
  ENDIF.
  IF:  lv_mon = 4 OR lv_mon = 6 OR lv_mon = 9 OR lv_mon = 11.
    DO 30 TIMES.
      WRITE: / |{ lv_jahr }-{ lv_mon }-{ lv_tag }|.
      ADD 1 TO lv_tag.
    ENDDO.
    ADD 1 TO lv_mon.
    lv_tag = 1.
    ULINE.
  ENDIF.
  IF  lv_mon = 2.
    DO 29 TIMES.
      WRITE: / |{ lv_jahr }-{ lv_mon }-{ lv_tag }|.
      ADD 1 TO lv_tag.
    ENDDO.
    ADD 1 TO lv_mon.
    lv_tag = 1.
    ULINE.
  ENDIF.
  WRITE: / |{ lv_jahr }-{ lv_mon }-{ lv_tag }|.
ENDDO.

**********************************************************************

"CASE lv_mon.
  "WHEN: 1 OR 3 OR 5 OR 7 OR 8 OR 10 OR 12.
   " lv_tag = 31
  "WHEN .
"	WHEN OTHERS.
"ENDCASE.
