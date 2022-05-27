*&---------------------------------------------------------------------*
*& Report Z_S11_RECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_rechner.

DATA lv_zahl_1 TYPE p.  "VALUE IS INITIAL.
DATA lv_zahl_2 TYPE p.
DATA lv_ergebnis TYPE p DECIMALS 2.
*DATA lv_ergebnis TYPE F.

INITIALIZATION.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
  PARAMETERS p_zahl_1 LIKE lv_zahl_1 DEFAULT 35.
  PARAMETERS p_zahl_2 LIKE lv_zahl_2 default 5.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.
  PARAMETERS p_add RADIOBUTTON GROUP rb_1.
  PARAMETERS p_sub RADIOBUTTON GROUP rb_1.
  PARAMETERS p_mul RADIOBUTTON GROUP rb_1.
  PARAMETERS p_div RADIOBUTTON GROUP rb_1.
SELECTION-SCREEN END OF BLOCK b2.

START-OF-SELECTION.

WRITE : /'Zahl 1', p_zahl_1.
WRITE : /'Zahl 2', p_zahl_2.
IF p_add = 'X'.
  lv_ergebnis = p_zahl_1 + p_zahl_2.
ELSEIF
  p_sub = 'X'.
  if p_zahl_1 >= p_zahl_2.
  lv_ergebnis = p_zahl_1 - p_zahl_2.
  else.
   lv_ergebnis = p_zahl_2 - p_zahl_1.
   endif.
ELSEIF
  p_mul = 'X'.

  lv_ergebnis = p_zahl_1 * p_zahl_2.
*  write :/ | p_zahl_1 { * } p_zahl_2 |.
ELSEIF
  p_div = 'X'.
  IF p_zahl_2 EQ 0.
    WRITE :/ 'Division by 0 is not possible'.
    Exit.

  ELSE.
    lv_ergebnis = p_zahl_1 / p_zahl_2.
  ENDIF.
*ELSE.
*  WRITE :/ 'No operand selected'.

ENDIF.

*
*IF lv_ergebnis IS NOT INITIAL.

  WRITE : /'The ergebnis is',lv_ergebnis.
*ELSE.
*  WRITE : / 'The result is 0.00'.
*ENDIF.

End-of-SELECTION.
