*&---------------------------------------------------------------------*
*& Report Z_S08_RECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S08_RECHNER


DATA  lv_zahl  TYPE 1.
SELECTION-SCREEN BEGIN OF BLOCK bi  WITH FRAME.



PARAMETERS p_param LIKE  lv_zahl1.
PARAMETERS  p_param  LIKE  lv_zahl2.
PARAMETERS  p_param LIKE  lv_zahl3.



SELECT-OPTIONS  so_sei FOR lv_zahl NO INTERVALS.
SELECTION-SCREEN





WRITE : / lv_ergebnis.

DATA LV_ZAHL_1 TYPE i.
DATA LV_ZAHL_2 TYPE i.
DATA lv_zeichen(1)  type c.


IF lv_zahl_1 EQ lv_zahl_2.
  WRITE:  lv_zahl_2.

  ELSEIF  P-div = 'x'.
      WRITE: / 'Division'.
      IF p_zahl_2 EQ 0.
        WRITE: 'Fehler! Division durch 0 nicht zulässig!'




WRITE: Addition.
IF lv_zeichen EQ #1'.


IF p_add  EQUIV'x'.
  WRITE: / 'Addition!'.
  ELSEIF  p_sub = 'x'.
    WRITE: / 'Keine Addition!'.
    ENDIF.


*lv_zeichen = '+'.
