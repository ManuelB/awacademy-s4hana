*&---------------------------------------------------------------------*
*& Report Z_S11_SCHLEIFEN_AUFGABE2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_schleifen_aufgabe2.

DATA lv_jahr TYPE i VALUE 2022.
DATA lv_mon TYPE i VALUE 1.
DATA lv_tag TYPE i VALUE 1.

*DATA lv_ausgabe TYPE string.
*DATA lv_jahr_c TYPE string.
*DATA lv_mon_c TYPE string.
*DATA lv_tag_c TYPE string.

*DO 12 TIMES.  "12 Monate
*
*  DO 30 TIMES.  "30 Tage pro monat

*    lv_jahr_c = lv_jahr.
*    lv_mon_c = lv_mon.
*    lv_tag_c = lv_tag.
*    CONCATENATE lv_jahr_c'-' lv_mon_c '-' lv_tag_c INTO lv_ausgabe.
*    CONDENSE lv_ausgabe NO-GAPS.
*    WRITE / lv_ausgabe.

*    WRITE :/ |{ lv_jahr }{ lv_mon }{ lv_tag }|.
*
*    ADD 1 TO lv_tag.
*  ENDDO.
*  ADD 1 TO lv_mon.
*  lv_tag = 1.
*ENDDO.




DO 12 TIMES.  "12 Monate

  IF lv_mon = 1 .

    DO 31 TIMES.  "30 Tage pro monat
      WRITE :/ |{ lv_jahr }-{ lv_mon }-{ lv_tag }|.
       ADD 1 TO lv_tag.
    ENDDO.

  ELSEIF lv_mon = 2 .

    DO 28 TIMES.  "30 Tage pro monat
      WRITE :/ |{ lv_jahr }-{ lv_mon }-{ lv_tag }|.
       ADD 1 TO lv_tag.
    ENDDO.

  ELSEIF lv_mon BETWEEN 2 AND 8. "für monat 3,4,5,6,7
  IF lv_mon MOD 2 EQ 0.
    DO 30 TIMES.  "30 Tage pro monat

        WRITE :/ |{ lv_jahr }-{ lv_mon }-{ lv_tag }|.
        ADD 1 TO lv_tag.
      ENDDO.
    ELSE.
      DO 31 TIMES.
        WRITE :/ |{ lv_jahr }-{ lv_mon }-{ lv_tag }|.
        ADD 1 TO lv_tag.
         ENDDO.
      ENDIF.



  ELSEIF lv_mon BETWEEN 7 AND 13 AND lv_mon MOD 2 NE 0. "für monat 8,9,10,11,12

    DO 30 TIMES.  "30 Tage pro monat

      WRITE :/ |{ lv_jahr }-{ lv_mon }-{ lv_tag }|.
      ADD 1 TO lv_tag.
    ENDDO.
  ELSE.
    DO 31 TIMES.
      WRITE :/ |{ lv_jahr }-{ lv_mon }-{ lv_tag }|.
      ADD 1 TO lv_tag.

    ENDDO.
  ENDIF.
  ADD 1 TO lv_mon.
  lv_tag = 1.
ENDDO.
