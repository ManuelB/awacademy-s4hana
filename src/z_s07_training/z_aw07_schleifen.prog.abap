*&---------------------------------------------------------------------*
*& Report Z_AW07_SCHLEIFEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_SCHLEIFEN.

DATA lv_i TYPE i VALUE 1.
DATA  lv_times TYPE i value 5.
DATA lv_tag type i VALUE 1.
DATA lv_Monat type i value 1.
DATA lv_Jahr TYPE i VALUE 2022.







DO 5 TIMES.

  WRITE: / lv_i.
ADd 10 to lv_i.
If lv_i GT 30.
  EXIT.
  endif.


ENDDO.

ULINE.

WRITE: / 'WHILE Schleife'.

lv_times = 30.

WHILE lv_times GE 0.


  Subtract 1 from lv_times.
  DATA(lv_rest) = lv_times MOD 2.

  IF lv_rest is INITIAL.
    CONTINUE.
ENDIF.
Write: / lv_times.

ENDWHILE.

ULINE.

WRITE: / 'Aufgabe DATUM'.




  Do 12 Times.
    Do 30 Times.
 WRITE: / |{ lv_jahr }-{ lv_monat }-{ lv_TAG }|.
add 1 to lv_tag.
  ENDDO.
  lv_tag = 1.
    add 1 to lv_monat.

    ENDDO.


*  Do 30 Times.
*  WRITE: / lv_tag, lv_monat, lv_Jahr.
*  lv_tag = 1.
*add 1 to lv_tag.
*lv_monat = 2.
*
*  ENDDO.
