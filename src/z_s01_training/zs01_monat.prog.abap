*&---------------------------------------------------------------------*
*& Report Z_S01_MONAT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_monat.

*Verstanden.

DATA: lv_day   TYPE i VALUE 0,
      lv_month TYPE i VALUE 0,
      lv_year  TYPE i VALUE 2021.


WHILE lv_year = 2021 .

  lv_year = lv_year + 1.

  WHILE lv_month < 12 .
    lv_month = lv_month + 1.

    CASE lv_month.
      WHEN: 1 OR 3 OR  5 OR 7 OR 10 OR 12.

        DO 31 TIMES.
          lv_day = lv_day + 1.
          WRITE:/  lv_day  , lv_month , lv_year.
        ENDDO.
        lv_day = 0.


      WHEN: 4 OR 6 OR 9 OR 11.
        DO 30 TIMES.
          lv_day = lv_day + 1.
          WRITE: / lv_day , lv_month, lv_year.
        ENDDO.
        lv_day = 0.

      WHEN OTHERS.
        DO 29 TIMES.
          lv_day = lv_day + 1.
          WRITE: / lv_day  , lv_month,  lv_year.
        ENDDO.
        lv_day = 0.
    ENDCASE.
  ENDWHILE.
  lv_day = 0.
  ULINE.


ENDWHILE.
