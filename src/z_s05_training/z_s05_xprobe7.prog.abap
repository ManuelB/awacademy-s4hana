*&---------------------------------------------------------------------*
*& Report Z_S05_XPROBE7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_xprobe7.

TYPES:
  t_summe TYPE p LENGTH 6 DECIMALS 2,
  t_par   TYPE c LENGTH 15.

DATA:
  netto1 TYPE t_summe,
  mws1   TYPE t_summe,
  netto2 TYPE t_summe,
  mws2   TYPE t_summe.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  PARAMETERS:
    brutto1 TYPE t_summe DEFAULT '15.48',
    wtyp1   TYPE t_par DEFAULT 'LEBENSMITTEL'.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

  PARAMETERS:

    brutto2 TYPE t_summe DEFAULT '204.78',
    wtyp2   TYPE t_par DEFAULT 'HANDELSWARE'.


SELECTION-SCREEN END OF BLOCK b2.

PERFORM steuer USING brutto1 wtyp1 CHANGING netto1 mws1.
PERFORM steuer USING brutto2 wtyp2 CHANGING netto2 mws2.

IF brutto1 LE 0 OR brutto1 LE 0.
  WRITE: 'Fehler! Uberprüfen Sie bitte Ihre Eingabe.' COLOR COL_NEGATIVE.
ELSE.

  WRITE:
  / |Warentyp 1:       { wtyp1 }|,
  / |Brutto 1:           { brutto1 }|,
  /22 '-',
  / |MWS Betrag 1 :       { mws1 }|,
  /22 '=',
  / |Netto 1 :           { netto1 }|.
  ULINE.

  WRITE:
  / |Warentyp 2:      { wtyp2 }|,
  / |Brutto 2:          { brutto2 }|,
  /22 '-',
  / |MWS Betrag 2 :      { mws2 }|,
  /22 '=',
  / |Netto 2 :          { netto2 }|.

ENDIF.


FORM steuer USING brutto wtyp CHANGING netto mws.

  CASE wtyp.
    WHEN 'LEBENSMITTEL'.
 mws = brutto * '0.07'.
 netto = brutto - mws.
    WHEN 'HANDELSWARE'.
 mws = brutto * '0.19'.
 netto = brutto - mws.
 when others.
   WRITE: / 'Fehler! Falsches Warentyp.' color COL_NEGATIVE.
   RETURN.
   ENDCASE.

   ENDFORM.
