*&---------------------------------------------------------------------*
*& Report Z_S02_ASS1_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_ass1_1.

TYPES: ty_betrag TYPE p LENGTH 7 DECIMALS 2.

PARAMETERS:
  bwert1 TYPE ty_betrag DEFAULT '1.23',
  wtyp1  TYPE c LENGTH 1 DEFAULT 'L',
  bwert2 TYPE ty_betrag DEFAULT '12.50',
  wtyp2  TYPE c LENGTH 1 DEFAULT 'H'.


DATA:
  nwert1 TYPE ty_betrag,
  twert1 TYPE ty_betrag,
  nwert2 TYPE ty_betrag,
  twert2 TYPE ty_betrag.



* ABAP-Code
PERFORM rechnen USING bwert1 wtyp1 CHANGING nwert1 twert1.
PERFORM rechnen USING bwert2 wtyp2 CHANGING nwert2 twert2.


* Ausgabe
WRITE:  /'Bruttowert 1:', bwert1,
        /'Netto-Anteil:', nwert1, 'MWSt-Anteil:', twert1.
SKIP.
WRITE:  /'Bruttowert 2:', bwert2,
        /'Netto-Anteil:', nwert2, 'MWSt-Anteil:', twert2.



* FORM-Routine
FORM rechnen USING bwert wtyp CHANGING nwert twert.

  CASE wtyp.
    WHEN 'L'.
      nwert = bwert / '1.07'.
      twert = bwert - nwert.
    WHEN 'H'.
      nwert = bwert / '1.19'.
      twert = bwert - nwert.
    WHEN OTHERS.
  ENDCASE.

  ENDFORM.
