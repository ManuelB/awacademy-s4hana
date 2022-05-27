*&---------------------------------------------------------------------*
*& Report Z_S09_DATUMSAUFGABE
*&---------------------------------------------------------------------*

REPORT Z_S09_DATUMSAUFGABE.

DATA: lv_TAG TYPE i VALUE 0,
      lv_MONAT TYPE i VALUE 0,
      lv_Jahr TYPE i VALUE 2022.




    WHILE lv_Jahr < 2024.
      lv_Jahr = lv_Jahr + 1 .
      WRITE: / 'Jahr', lv_Jahr.

    WHILE lv_MONAT < 12.
    lv_MONAT = lv_MONAT + 1.
    WRITE: / 'MONAT', lv_MONAT.

     WHILE lv_TAG < 30.
      lv_TAG = lv_TAG + 1.
      WRITE: / 'TAG', lv_TAG.




      ENDWHILE.
       lv_TAG = 0.
     ENDWHILE.
      Endwhile.
