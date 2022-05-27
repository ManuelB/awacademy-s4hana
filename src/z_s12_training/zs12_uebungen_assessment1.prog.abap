*&---------------------------------------------------------------------*
*& Report ZS12_UEBUNGEN_ASSESSMENT1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs12_uebungen_assessment1.

*TYPES: zahl TYPE p LENGTH 5 DECIMALS 2.

*PARAMETERS:
*  a1  TYPE zs12_zahl,
*  op1 TYPE zs12_operator,
*  b1  TYPE zs12_zahl.
*
*DATA:  res TYPE zs12_zahl.
*
*CALL FUNCTION 'ZS12_ASSESSMENT1_RECHNEN'
*  EXPORTING
*    i_a            = a1
*    i_op           = op1
*    i_b            = b1
*  IMPORTING
*    ex_erg         = res
*  EXCEPTIONS
*    wrong_operator = 1
*    division_zero  = 2
*    negative_root  = 3
*    OTHERS         = 4.
*
*CASE sy-subrc.
*  WHEN 1.
*    WRITE: / 'Sie haben einen ungültigen Operator verwendet!' COLOR COL_NEGATIVE.
*  WHEN 2.
*    WRITE: 'Die Division durch 0 ist nicht erlaubt!' COLOR COL_NEGATIVE.
*  WHEN 3.
*    WRITE: / 'Das Radizieren durch eine negative Zahl ist hier nicht erlaubt!' COLOR COL_NEGATIVE.
*  WHEN OTHERS.
*    RAISE others.
*    WRITE: / 'Ein anderer Fehler ist aufgetreten!' COLOR COL_NEGATIVE.
*ENDCASE.


TYPES betrag TYPE p LENGTH 7 DECIMALS 2.

PARAMETERS:
  Brutto1 TYPE betrag,
  wt1(1)  TYPE c DEFAULT 'l' LOWER CASE,
  Brutto2 TYPE betrag,
  wt2(1)  TYPE c DEFAULT 'h' LOWER CASE.


DATA:
  netto1  TYPE betrag,
  netto2  TYPE betrag,
  mwrtst1 TYPE betrag,
  mwrtst2 TYPE betrag.


PERFORM steuer USING brutto1 wt1 CHANGING mwrtst1 netto1.
WRITE: / 'Für einen Bruttopreis von:', brutto1, 'fallen', mwrtst1, 'an Mehrwertsteuern an und der Nettopreis beträgt:', netto1.
PERFORM steuer USING brutto2 wt2 CHANGING mwrtst2 netto2.
WRITE: / 'Für einen Bruttopreis von:', brutto2, 'fallen', mwrtst2, 'an Mehrwertsteuern an und der Nettopreis beträgt:', netto2.





FORM Steuer USING brutto wt CHANGING mwrtst netto.
  CASE wt.
    WHEN 'l'.
      netto = brutto / '1.07'.
      mwrtst = brutto - netto.
    WHEN 'h'.
      netto = brutto / '1.18'.
      mwrtst = brutto - netto.
    WHEN OTHERS.
      WRITE: / 'Ein Fehler ist aufgetreten!'.
  ENDCASE.
ENDFORM.
