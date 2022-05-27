*&---------------------------------------------------------------------*
*& Report Z_S04_ZEICHENARTIGE_DATENTYPEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_zeichenartige_datentypen.

DATA lv_vorne(20) TYPE c.
DATA lv_mitte(20) TYPE c.
DATA lv_hinten(20) TYPE c.
DATA lv_ausgabe(60) TYPE c.

DATA lv_offset TYPE i.
DATA lv_length TYPE i.


PARAMETERS p_text LIKE lv_vorne DEFAULT 'Bäume' LOWER CASE.

lv_vorne = p_text.
WRITE: / lv_vorne.

ULINE.

lv_vorne = 'Bäume'.
lv_mitte = 'blühen im'.
lv_hinten = 'Frühling'.

CONCATENATE lv_vorne lv_mitte lv_hinten '.' INTO lv_ausgabe SEPARATED BY ' '.
WRITE: / lv_ausgabe.

ULINE.

WRITE: 'REPLACE (TEXT):'.
REPLACE 'Frühling' IN lv_ausgabe WITH 'Winter'.
REPLACE 'Bäume' IN lv_ausgabe WITH 'Tannenbäume'.
WRITE: / lv_ausgabe.

ULINE.

WRITE: 'TRANSLATE (UPPER CASE):'.
TRANSLATE lv_ausgabe TO UPPER CASE.
WRITE: / lv_ausgabe.

ULINE.

WRITE: 'SPLIT:'.
SPLIT lv_ausgabe AT ' ' INTO lv_vorne lv_mitte lv_hinten.
WRITE: / lv_vorne.
WRITE: / lv_mitte.
WRITE: / lv_hinten. "Das ist ein Inline-Kommentar

* Das ist ein ganzzeiliger Kommentar.
ULINE.


lv_ausgabe = 'Dies ist ein    Testtext'.

WRITE: 'CONDENSE:'.
CONDENSE lv_ausgabe. "Komprimiert mehrere Leerzeichen zu einem
WRITE: / lv_ausgabe.

CONDENSE lv_ausgabe NO-GAPS. "Löscht alle Leerzeichen
WRITE: / lv_ausgabe.

ULINE.

lv_ausgabe = lv_vorne(1). "Zeigt nur soviele Zeichen wie in der Klammer angegeben = (T)annenbäume
WRITE: / lv_ausgabe.

lv_ausgabe = lv_vorne+1(1). "Offset +1. Fängt bei 0 an. Offset 0 ist das 1. Zeichen = T(a)nnenbäume
WRITE: / lv_ausgabe.

lv_offset = 3. "Offset ist das 3. Zeichen
lv_ausgabe = lv_vorne+lv_offset(1). "Offset +1 mit Start beim 3. Zeichen = Tan(n)enbäume
WRITE: / lv_ausgabe.

lv_length = strlen( lv_vorne ).
lv_ausgabe = lv_vorne+lv_offset(lv_length).
WRITE: / lv_ausgabe.
