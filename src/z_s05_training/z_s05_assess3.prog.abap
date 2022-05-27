REPORT Z_S05_ASSESS3 .
*
*PARAMETERS: b TYPE i DEFAULT 4.
*DATA: res TYPE i VALUE 5.
*WRITE: b, res.
*PERFORM rechne USING res CHANGING b.
*WRITE: b, res.
*FORM rechne USING b CHANGING c.
*DATA: res TYPE i VALUE 6.
*c = res.
*WRITE: b, res.
*ENDFORM.

TYPES: ty_betrag TYPE p LENGTH 7 DECIMALS 2.
parameters:
bwert1 tYPE ty_betrag DEFAULT '1.23',
Wtyp1 TYPE C LENGTH 1 DEFAULT 'L',
bwert2 TYPE ty_betrag DEFAULT 12,
wtyp2 TYPE C LENGTH 1 DEFAULT 'H'.
*
DATA:
nwert1 TYPE ty_betrag,
twert1 TYPE ty_betrag,
nwert2 TYPE ty_betrag,
twert2 TYPE ty_betrag.
* ABAP-Code: Berechnungen für beide Artikel
PERFORM rechnen USING bwert1 wtyp1 CHANGING nwert1 twert1.
PERFORM rechnen USING bwert2 wtyp2 CHANGING nwert2 twert2.
* Ausgabeliste:
WRITE: / 'bw1:', bwert1,
/ 'Netto-Anteil:', nwert1, 'MWSt-Anteil:', twert1.
skip.
WRITE: / 'bw1:', bwert1,
/ 'Netto-Anteil:', nwert1, 'MWSt-Anteil:', twert1.
FORM rechnen USING bw wt CHANGING nw tw.
CASE wt.
WHEN 'L'. "aktuell: 7%
nw = bw / '1.07'.
* brutto = 2.14 = 2.00 + 0.14 = 2 Euro * (100% + 7%) = 2 Euro * (1 +
*7/100)
* = netto * 1.07
tw = bw - nw.  "nw + tw = bw
WHEN 'H'. "aktuell: 19%
nw = bw / '1.19'.
tw = bw - nw.
WHEN OTHERS.
write: / 'Falscher Typ'. exit.
ENDCASE.
ENDFORM.
