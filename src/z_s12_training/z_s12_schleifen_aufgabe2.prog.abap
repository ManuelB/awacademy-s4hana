*&---------------------------------------------------------------------*
*& Report Z_S12_SCHLEIFEN_AUFGABE2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_schleifen_aufgabe2.

DATA lv_day TYPE i VALUE 0.
DATA lv_month TYPE i VALUE 1.
DATA lv_year TYPE i VALUE 2022.

DATA lv_aufgabe TYPE string.
DATA lv_day_c TYPE string.
DATA lv_month_c TYPE string.
DATA lv_year_c TYPE string.
*lv_year_c = lv_year.
*lv_month_c = lv_month.
*lv_day_c = lv_day.

*DO 12 TIMES.
*  IF lv_month EQ '1' OR lv_month EQ '3' OR lv_month EQ '5' OR lv_month EQ '7' OR lv_month EQ '8' OR lv_month EQ '10' OR lv_month EQ '12'.
*    DO 31 TIMES.
*      ADD 1 TO lv_day.
*      WRITE:/ | { lv_year }-{ lv_month }-{ lv_day } |.
*    ENDDO.
*    ULINE.
*  ELSEIF lv_month EQ '4' OR lv_month EQ '6' OR lv_month EQ '9' OR lv_month EQ '11'.
*    DO 30 TIMES.
*      ADD 1 TO lv_day.
*      WRITE:/ | { lv_year }-{ lv_month }-{ lv_day } |.
*    ENDDO.
*    ULINE.
*  ELSEIF lv_month = 2.
*    DO 28 TIMES.
*      ADD 1 TO lv_day.
*      WRITE:/ | { lv_year }-{ lv_month }-{ lv_day } |.
*    ENDDO.
*    ULINE.
*  ENDIF.
*  ADD 1 TO lv_month.
*  lv_day = 0.
*ENDDO.

DO 12 TIMES.
  CASE lv_month.
    WHEN: 1 or 3 or 5 or 7 or 8 or 10 or 12.
      DO 31 TIMES.
 ADD 1 TO lv_day.
 WRITE:/ | { lv_year }-{ lv_month }-{ lv_day } |.
      ENDDO.
    WHEN: 4 or 6 or 9 or 11.
    DO 30 TIMES.
      ADD 1 TO lv_day.
  WRITE:/ | { lv_year }-{ lv_month }-{ lv_day } |.
       ENDDO.
    WHEN 2.
      DO 28 TIMES.
      ADD 1 TO lv_day.
   WRITE:/ | { lv_year }-{ lv_month }-{ lv_day } |.
       ENDDO.
  ENDCASE.
  ADD 1 TO lv_month.
  lv_day = 0.
    ENDDO.




*DO 12 TIMES. "12 Monate
*  IF lv_month = '1, 3, 5, 7, 8, 10, 12'.
*    DO 31 TIMES.
*      WRITE:/ | { lv_year }-{ lv_month }-{ lv_day } |.
*      ADD 1 TO lv_day.
*    ENDDO.
*  ELSEIF lv_month = '4, 6, 9, 11'.
*    DO 30 TIMES.
*      WRITE:/ | { lv_year }-{ lv_month }-{ lv_day } |.
*      ADD 1 TO lv_day.
*    ENDDO.
*  ELSEIF lv_month = '2'.
*    DO 28 TIMES.
*      WRITE:/ | { lv_year }-{ lv_month }-{ lv_day } |.
*      ADD 1 TO lv_day.
*    ENDDO.
*
*  ENDIF.
*  DO 30 TIMES. "30 Tage pro Monat
**    lv_year_c = lv_year.
**    lv_month_c = lv_month.
**    lv_day_c = lv_day. "Ausgabe der Zahlen so nicht möglich, deshalb in Typ String umwandeln.
**    CONCATENATE lv_year_c '-' lv_month_c '-' lv_day_c INTO lv_ausgabe.
**    CONDENSE lv_ausgabe NO-GAPS.
**    WRITE : / lv_ausgabe.
*    WRITE:/ | { lv_year }-{ lv_month }-{ lv_day } |.
*    ADD 1 TO lv_day.
*  ENDDO.
*  ADD 1 TO lv_month.
*  lv_day = 1.
*ENDDO.
