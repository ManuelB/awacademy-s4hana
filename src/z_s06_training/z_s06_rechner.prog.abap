*&---------------------------------------------------------------------*
*& Report Z_T04_RECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_t04_rechner.

*DATA lv_zahl TYPE p DECIMALS 2.
*DATA lv_ergebnis TYPE p DECIMALS 2. "type F for Float.
*DATA lv_operator(3) TYPE c.
*
*INITIALIZATION."Alles hier nach passiert zu erst!
*
*  SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME.
*
*    SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
*
*      PARAMETERS p_zahl_1 LIKE lv_zahl.
*      PARAMETERS p_zahl_2 LIKE lv_zahl.
*
*    SELECTION-SCREEN END OF BLOCK b1.
*
*    SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.
*
*      PARAMETERS p_add RADIOBUTTON GROUP r1.
*      PARAMETERS p_sub RADIOBUTTON GROUP r1.
*      PARAMETERS p_mult RADIOBUTTON GROUP r1.
*      PARAMETERS p_div RADIOBUTTON GROUP r1.
*
*    SELECTION-SCREEN END OF BLOCK b2.
*  SELECTION-SCREEN END OF BLOCK b0.
*
*START-OF-SELECTION.
*
*  DATA lv_zahl_1 TYPE i.
*  DATA lv_zahl_2 TYPE i.
*  DATA lv_zeichen(1) TYPE c.
*
*
*  lv_zahl_1 = 1.
*  lv_zahl_2 = 1.
*
*IF lv_zahl_1 EQ lv_zahl_2 .
*
*  WRITE: lv_zahl_2.
*
*ENDIF.
*
*  IF p_add EQ abap_true. " Addition
*    WRITE: / 'Addition!'.
*    lv_ergebnis = p_zahl_1 + p_zahl_2.
*
*  ELSEIF p_sub = 'X'.
*    WRITE: / 'Subtraktion!'.
*    lv_ergebnis = p_zahl_1 - p_zahl_2.
*
*  ELSEIF p_mult = 'X'.
*    WRITE: / 'Multiplikation!'.
*
*    lv_ergebnis = p_zahl_1 * p_zahl_2.
*
*  ELSEIF p_div = 'X'.
*    WRITE: / 'Division!'.
*    IF p_zahl_2 EQ 0.
*      WRITE: 'Fehler! Division durch 0 nicht zulässig!'.
*      EXIT.
*    ELSE.
*      lv_ergebnis = p_zahl_1 / p_zahl_2.
*    ENDIF.
*  ELSE.
*    WRITE: / 'Fehler! Keine korrekte Verrechnugsoperation gewählt'.
*  ENDIF.
*
*
*  IF lv_ergebnis IS NOT INITIAL.
*    WRITE: / lv_ergebnis.
*  ELSE.
*    WRITE: / 'Fehler: Ergebnismenge leer!'.
*  ENDIF.

*lv_zeichen = '+'.
*IF lv_zeichen EQ '+'.
*WRITE: / '+'.
*ENDIF.

***********************************************************************
**********************************************************************

  PARAMETERS:
    a1  TYPE i DEFAULT 3,
    op1 TYPE c LENGTH 1 DEFAULT '+',
    b1  TYPE i DEFAULT 4,
    a2  TYPE i DEFAULT 5,
    op2 TYPE c LENGTH 1 DEFAULT '+',
    b2  TYPE i DEFAULT 7.

  DATA:
        res TYPE i.
  CASE op1.
    WHEN '+'.
      res = a1 + b1.
    WHEN '/'.
      res = a1 / b1.
    WHEN '-'.
      res = a1 - b1.
    WHEN '*'.
      res = a1 * b1.
  ENDCASE.

  WRITE: /3 a1,
  / op1, b1.
  ULINE /3(12).
  WRITE: / res.
