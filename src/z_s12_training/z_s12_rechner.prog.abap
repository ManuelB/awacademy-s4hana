*&---------------------------------------------------------------------*
*& Report Z_S12_RECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_rechner.


DATA lv_zahl_1 TYPE p DECIMALS 2.
DATA lv_zahl_2 TYPE p DECIMALS 2.

DATA lv_ergebnis TYPE p DECIMALS 2.
*DATA lv_ergebnis TYPE f. "Float: Datentyp für Gleit --> Vorzeichen steht vorne"p DECIMALS 2.

INITIALIZATION.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
  PARAMETERS p_zahl_1 LIKE lv_zahl_1.
  PARAMETERS p_zahl_2 LIKE lv_zahl_2.
  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

    PARAMETERS p_add RADIOBUTTON GROUP rb_1.
    PARAMETERS p_sub RADIOBUTTON GROUP rb_1.
    PARAMETERS p_mult RADIOBUTTON GROUP rb_1.
    PARAMETERS p_div RADIOBUTTON GROUP rb_1.

  SELECTION-SCREEN END OF BLOCK b2.
SELECTION-SCREEN END OF BLOCK b1.

p_zahl_1 = 1.

START-OF-SELECTION.
*INITIALISATION und START-OF-SELEKTION können genutzt werden um einem Program zu sagen was in welcher Reihenfolge passieren soll
*z.B. auch gut um GUI zu verstecken, falls der Benutzer nicht über die benötigten Rechte verfügt
IF p_add EQ 'X'.
  lv_ergebnis = p_zahl_1 + p_zahl_2.
  WRITE: / 'Ergebnis der Addition:', lv_ergebnis.
ELSEIF p_sub EQ 'X'.
  lv_ergebnis = p_zahl_1 - p_zahl_2.
  WRITE: / 'Ergebnis der Subtraktion:', lv_ergebnis.
ELSEIF p_mult EQ 'X'.
  lv_ergebnis = p_zahl_1 * p_zahl_2.
  WRITE: / 'Ergebnis der Miltiplikation:', lv_ergebnis.
ELSEIF p_div EQ 'X'.
  IF  p_zahl_2 EQ 0.
    WRITE: / 'Division durch Null nicht möglich!'.
    exit.
  ELSE.
    lv_ergebnis = p_zahl_1 DIV p_zahl_2.
    WRITE: / 'Ergebnis der Division:', lv_ergebnis.
  ENDIF.
ELSE.
  WRITE: / 'Fehler! Keine Rechenoperation ausgewählt!'.

ENDIF.


IF lv_ergebnis IS NOT INITIAL.
  WRITE: / lv_ergebnis.
  ELSE.
  WRITE: / 'Fehler: Ergebnismenge leer!'.
ENDIF.

*************************************************************************************************************************************************
*Rechner mit 2 Rechenoperationen
*************************************************************************************************************************************************
PARAMETERS:
  a1  TYPE i DEFAULT 3,
  op1 TYPE c LENGTH 1 DEFAULT '+',
  b1  TYPE i DEFAULT 4,
  a2  TYPE i DEFAULT 5,
  op2 TYPE c LENGTH 1 DEFAULT '*',
  b2  TYPE i DEFAULT 7.
*
DATA:
      res TYPE i.
*1. Berechnung
PERFORM rechnen USING a1 op1 b1 CHANGING res. "Verwendung von Aktualparametern
PERFORM ausgabe USING a1 op1 b1 CHANGING res.
*2. Berechung
PERFORM rechnen USING a2 op2 b2 CHANGING res.
PERFORM ausgabe USING a2 op2 b2 CHANGING res.

FORM rechnen USING a op b CHANGING res. "Subroutine wird definiert beeinhaltet Formalparamater
  CASE op.
    WHEN '+'.
      res = a + b.
    WHEN '-'.
      res = a - b.
    WHEN '*'.
      res = a * b.
    WHEN '/'.
      res = a / b.
  ENDCASE.
ENDFORM.


FORM ausgabe USING a op b res.
  WRITE: /3 a,
  / op, b.
  ULINE /3(12).
  WRITE: /3 res.
ENDFORM.

"Ursprünglich so
**2. Berechung
*  CASE op2.
*    WHEN '+'.
*      res = a2 + b2.
*    WHEN '-'.
*      res = a2 - b2.
*    WHEN '*'.
*      res = a2 * b2.
*    WHEN '/'.
*      res = a2 / b2.
*  ENDCASE.
*  WRITE: /3 a2,
*  /op2, b2.
*  ULINE /3(12).
*  WRITE: /3 res.
















*DATA lv_zahl_1 TYPE i.
*DATA lv_zahl_2 TYPE i.
*DATA lv_zeichen(1) TYPE c.
*
*IF lv_zahl_1 EQ lv_zahl_2.
*  WRITE: lv_zahl_2.
*
*ENDIF.
*
*IF p_add EQ 'X'.
*  WRITE: / 'Addition!'.
*
*ENDIF.
*lv_zeichen = '+'.
*IF lv_zeichen EQ 'X'.
*  WRITE: / 'Addition!'.
*ELSEIF p_sub = 'X'.
*  write: /
*else.
*WRITE: / 'keine Addition!'.
*ENDIF.


*SELECT-OPTIONS so_sel FOR p_para1.
*SELECT-OPTIONS so_sel FOR p_para2.
*
*
*
*PARAMETERS p_check AS CHECKBOX DEFAULT 'X'. "Boolean --> ja oder nein - in ABAP ' ' oder 'X'
*PARAMETERS p_rad1 RADIOBUTTON GROUP rb_1.
*PARAMETERS p_rad2 RADIOBUTTON GROUP rb_1.
*lv_ergebnis = lv_zahl_1 * lv_zahl_2.
*WRITE: / 'Ergebnis (*):', lv_ergebnis.
*
*uline.
