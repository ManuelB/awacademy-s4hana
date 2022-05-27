*&---------------------------------------------------------------------*
*& Report Z_S02_ASS1_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_ass1_1fb.

TYPES: ty_betrag TYPE p LENGTH 7 DECIMALS 2.

PARAMETERS:
  bwert1 TYPE ZS02C_TY_BETRAG DEFAULT '1.23',
  wtyp1  TYPE ZS02C_TY_MWST DEFAULT 'L',
  bwert2 TYPE ZS02C_TY_BETRAG DEFAULT '12.50',
  wtyp2  TYPE ZS02C_TY_MWST DEFAULT 'H'.


DATA:
  nwert1 TYPE ZS02C_TY_BETRAG,
  twert1 TYPE ZS02C_TY_BETRAG,
  nwert2 TYPE ZS02C_TY_BETRAG,
  twert2 TYPE ZS02C_TY_BETRAG.


* FB Eingabewert1

CALL FUNCTION 'Z_S02_FB_ASS1'
  EXPORTING
    bwert         = bwert1
    wtyp          = wtyp1
 IMPORTING
   NWERT         = nwert1
   TWERT         = twert1
          .
* Ausgabe
WRITE:  /'Bruttowert 1:', bwert1,
        /'Netto-Anteil:', nwert1, 'MWSt-Anteil:', twert1.


* FB Eingabewert1

CALL FUNCTION 'Z_S02_FB_ASS1'
  EXPORTING
    bwert         = bwert2
    wtyp          = wtyp2
 IMPORTING
   NWERT         = nwert2
   TWERT         = twert2
   .

WRITE:  /'Bruttowert 2:', bwert2,
        /'Netto-Anteil:', nwert2, 'MWSt-Anteil:', twert2.
