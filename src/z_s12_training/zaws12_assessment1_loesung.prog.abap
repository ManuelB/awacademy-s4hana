*&---------------------------------------------------------------------*
*& Report ZAWS12_ASSESSMENT1_LOESUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaws12_assessment1_loesung.

******************************************
*Aufgabe 1
******************************************

*PARAMETERS:
*  Preis  TYPE p LENGTH 6 DECIMALS 2,
*  p_lebm RADIOBUTTON GROUP rb_1,
*  p_hanw RADIOBUTTON GROUP rb_1.
*
*
*DATA:
*  Bruttopreis TYPE p LENGTH 6 DECIMALS 2,
*  Nettopreis  TYPE p LENGTH 6 DECIMALS 2,
*  Netto  TYPE p LENGTH 6 DECIMALS 2,
*  Netto1  TYPE p LENGTH 6 DECIMALS 2.
*
*
*
*CASE 'X'.
*  WHEN p_lebm.
*    PERFORM Lebensmittel USING Preis CHANGING Bruttopreis Nettopreis.
*    WRITE: 'Das folgende Lebensmittel hat einen Nettopreis von', Netto1 , 'Die Mehrwertsteuer beträg', Netto.
*  WHEN  p_hanw.
*    PERFORM Handelsware USING Preis CHANGING Bruttopreis Nettopreis.
*    WRITE: 'Die folgende Handelsware hat einen Nettopreis von', Netto1, 'Die Mehrwertsteuer beträgt', Netto.
*  WHEN OTHERS.
*    WRITE: / 'Es tut uns leid, der folgende Warentyp entspricht nicht den Vorgaben.'.
*ENDCASE.
*
*
*
*FORM Lebensmittel USING Preis2 CHANGING Preis bruttopreis.
*  Netto = ( ( 7 / 100 ) * Preis2 ).
*  Netto1 = Preis2 - Netto.
*  Preis = Preis2.
*ENDFORM.
*
*FORM Handelsware USING Preis2 CHANGING Preis bruttopreis.
*  Netto =  ( ( 19 / 100 ) * Preis2 ).
*  Netto1 = Preis2 - Netto.
*  Preis = Preis2.
*ENDFORM.

TYPES: ty_betrag TYPE p LENGTH 7 DECIMALS 2.
PARAMETERS:
  Bwert1 TYPE ty_betrag DEFAULT '1.23',
  Wtyp1  TYPE c LENGTH 1 DEFAULT 'l',
  Bwert2 TYPE ty_betrag DEFAULT '12.50',
  Wtyp2  TYPE c LENGTH 1 DEFAULT 'h'.
DATA:
  Nwert1 TYPE ty_betrag,
  Twert1 TYPE ty_betrag,
  Nwert2 TYPE ty_betrag,
  Twert2 TYPE ty_betrag.

*ABAP-Code: Berechnungeng für beide Artikel
PERFORM rechnen USING bwert1 wtyp1 CHANGING nwert1 wtyp1.
WRITE: / 'Bruttowert:', bwert1, 'Nettoanteil:', nwert1, 'Mehrwertsteueranteil:', twert1.
PERFORM rechnen USING bwert2 wtyp2 CHANGING nwert2 wtyp2.
WRITE: / 'Bruttowert:', bwert2, 'Nettoanteil:', nwert2, 'Mehrwertsteueranteil:', twert2.

*Ausgabeliste:
FORM rechnen USING bwert wtyp CHANGING nwert twert.
  CASE wtyp.
    WHEN 'L'. "aktuell: 7%
      nwert = bwert / '1.07'.
      twert = bwert - nwert.
    WHEN 'H'. "aktuell 19%
      nwert = bwert / '1.19'.
      twert = bwert - nwert.
    WHEN OTHERS.
      WRITE: / 'Falscher Typ.'.
  ENDCASE.
ENDFORM.
