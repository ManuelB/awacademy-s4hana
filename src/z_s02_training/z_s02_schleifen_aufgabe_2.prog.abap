*&---------------------------------------------------------------------*
*& Report Z_S02_SCHLEIFEN_AUFGABE_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_schleifen_aufgabe_2.

*DATA: lv_jahr   TYPE i VALUE 2022,
*      lv_mon   TYPE i VALUE 1,
*      lv_tag TYPE i.
*
*DATA lv_Ausgabe TYPE string.
*DATA lv_jahr_c TYPE string.
*DATA lv_mon_c TYPE string.
*DATA lv_tag_c TYPE string.
*
*
*
*DO 12 TIMES.
*  DO 30 TIMES.
*    WRITE: / '2022', '-', lv_months, '-', lv_days.
*    ADD 1 TO lv_days.
*  ENDDO.
*  ADD 1 TO lv_months.
*  lv_days = 1.
*ENDDO.


*Code von Robin v


DATA lv_jahr TYPE i VALUE 2022.
DATA lv_mon  TYPE i VALUE 1.
DATA lv_tag  TYPE i VALUE 1 .

DATA lv_Ausgabe TYPE string.
DATA lv_jahr_c  TYPE string.
DATA lv_mon_c   TYPE string.
DATA lv_tag_c   TYPE string.



DO 12 TIMES. " 12 Monate

  DO 30 TIMES. " 30 Tage Pro monat

*    lv_jahr_c = lv_jahr. "Typecasting: Der caracter (string) bekommt den Wert der Variable
*    lv_mon_c = lv_mon.
*    lv_tag_c = lv_tag.
*    CONCATENATE lv_jahr_c '-' lv_mon_c '-' lv_tag_c INTO lv_ausgabe.
*    CONDENSE lv_ausgabe NO-GAPS.
*    WRITE / lv_ausgabe.

  WRITE: / |{ lv_jahr }-{ lv_mon }-{ lv_TAG }|.
  IF lv_mon EQ '1' OR lv_Jahr EQ '3' OR lv_Jahr EQ '5' OR lv_Jahr EQ '7' OR lv_Jahr EQ '8' OR lv_Jahr EQ '10' OR lv_Jahr EQ '12'. " Schachtelung funktioniert nicht.
    DO 31 TIMES.
      WRITE: / |{ lv_jahr }-{ lv_mon }-{ lv_TAG }|.
      ADD 1 TO lv_tag.
    ENDDO.
  ELSEIF lv_mon = 2.
    DO 28 TIMES.
      WRITE: / |{ lv_jahr }-{ lv_mon }-{ lv_TAG }|.
      ADD 1 TO lv_tag.
    ENDDO.
  ELSE.
    DO 30 TIMES.
      WRITE: / |{ lv_jahr }-{ lv_mon }-{ lv_TAG }|.
      ADD 1 TO lv_tag.
    ENDDO.
  ENDIF.
ADD 1 TO lv_mon.
lv_tag = 1.
ENDDO.
ENDDO.



*
*
*DO 12 TIMES. " 12 Monate
*  CASE lv_mon.
*    WHEN 1.
*        WHEN .
*      lv_days = 31.
*    WHEN 2.
*      IF (lv_jahr/4 MOD = 0).
*      ENDIF. lv_jahr.
*      lv_days = 28.
*       lv_days = 28.
*    WHEN 3.
*      lv_days = 31.
*    WHEN 4.
*      lv_days = 30.
*    WHEN 5.
*      lv_days = 31.
*    WHEN 6.
*      lv_days = 30.
*    WHEN 7.
*      lv_days = 31.
*    WHEN 8.
*      lv_days = 31.
*    WHEN 9.
*      lv_days = 30.
*    WHEN 10.
*      lv_days = 31.
*    WHEN 11.
*      lv_days = 30.
*    WHEN 12.
*      lv_days = 31.
*    WHEN OTHERS.
*  ENDCASE.
*
*  DO lv_days TIMES. " 30 Tage Pro monat
*
**    lv_jahr_c = lv_jahr.
**    lv_mon_c = lv_mon.
**    lv_tag_c = lv_tag.
**    CONCATENATE lv_jahr_c '-' lv_mon_c '-' lv_tag_c INTO lv_ausgabe.
**    CONDENSE lv_ausgabe NO-GAPS.
**    WRITE / lv_ausgabe.
*
*    WRITE: / |{ lv_jahr }-{ lv_mon }-{ lv_TAG }|.
*
*
*    ADD 1 TO lv_tag.
*  ENDDO.
*  ADD 1 TO lv_mon.
*  lv_tag = 1.
*ENDDO.
