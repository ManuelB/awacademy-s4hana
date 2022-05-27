*&---------------------------------------------------------------------*
*& Report Z_S03_SCHLEIFEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s03_schleifen.



DATA: lv_i TYPE i VALUE 1.
DATA: lv_times TYPE i VALUE 5.

DO lv_times TIMES.

  WRITE: / lv_i.
  ADD 10 TO lv_i.
  IF lv_i GT 30.
    EXIT.
  ENDIF.
ENDDO.

ULINE.

lv_times = 30.

WHILE lv_times GE 0.


  SUBTRACT 1 FROM lv_times.

  DATA(lv_rest) = lv_times MOD 2.
  IF lv_rest IS INITIAL.
    CONTINUE.
  ENDIF.

  WRITE : / lv_times.

ENDWHILE.

ULINE.
WRITE: 'Tage des Monats Februar'.

DATA: lv_tag TYPE i VALUE 1.
DATA: lv_Monat TYPE i VALUE 1.
DATA: lv_Jahr TYPE i VALUE 2022.




DO 12 Times.

DO 30 Times.
  write: / lv_jahr, lv_monat,lv_tag.
  ADD 1 TO lv_tag.


  ENDDO.
  add 1 to lv_monat.
  lv_tag = 1.


    ENDDO.

*   SOLUTION CARLO
    "WHILE
*DATA: lv_days   TYPE i,
*      lv_months TYPE i.
*lv_months = 1.
*lv_days = 1.
*
*WHILE lv_months LE 12.
*  WHILE lv_days LE 30.
*    WRITE: / '2022', '-', lv_months, '-', lv_days.
*    ADD 1 TO lv_days.
*  ENDWHILE.
*  ADD 1 TO lv_months.
*  lv_days = 1.
*ENDWHILE.
