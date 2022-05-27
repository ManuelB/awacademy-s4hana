*&---------------------------------------------------------------------*
*& Report Z_S11_ZEICHENARTIGE_DATENTYPEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_zeichenartige_datentypen.
DATA lv_verarbeitung(20) type c.
data lv like lv_verarbeitung.   "like is used to refer to a variable of some type.
DATA lv_vorne(20) TYPE c.
DATA lv_mitte(20) TYPE c.
DATA lv_hinten(20) TYPE c.
DATA lv_ausgabe(60) TYPE c.

DATA lv_offset TYPE i.
DATA lv_length TYPE i.


PARAMETERS p_text LIKE lv_verarbeitung DEFAULT 'Bäume' LOWER CASE.

lv = 'weather'.
write lv.
WRITE :/ lv_verarbeitung.
lv_verarbeitung = p_text.
WRITE :/ lv_verarbeitung.

ULINE.

lv_vorne = p_text.
lv_mitte = 'blühen im '.
lv_hinten = 'Frühling'.

CONCATENATE lv_vorne lv_mitte lv_hinten '.' INTO lv_ausgabe SEPARATED BY ' '.
WRITE :/ '1.',lv_ausgabe.

REPLACE 'Frühling' IN lv_ausgabe WITH 'Herbst'.
WRITE:/ 'REPLACE ', lv_ausgabe.

TRANSLATE lv_ausgabe TO UPPER CASE.
WRITE :/ lv_ausgabe.

SPLIT lv_ausgabe AT space INTO : DATA(result1) DATA(result2), TABLE DATA(result3).
WRITE :/ result1.
WRITE :/ result2. "Das ist ein Inline-Kommentar.
*Das ist ein Ganzzeiliger Kommentar.

LOOP AT result3 INTO DATA(segment).
  WRITE :/ segment.
ENDLOOP.

*condense lv_ausgabe.

WRITE :/ lv_ausgabe.

ULINE.

lv_ausgabe = 'Dies ist ein          Testtext'.
WRITE :/ 'CONDENSE'.
CONDENSE lv_ausgabe. " NO-GAPS.
WRITE :/ lv_ausgabe.

WRITE :/ 'CONDENSE'.
CONDENSE lv_ausgabe NO-GAPS.
WRITE :/ lv_ausgabe.

ULINE.

lv_ausgabe = lv_vorne(1).
WRITE :/ lv_ausgabe.

lv_ausgabe = lv_vorne+0(1).
WRITE :/ lv_ausgabe.

lv_offset = 2.
lv_ausgabe = lv_vorne+lv_offset(1).
WRITE :/ lv_ausgabe.

lv_length = strlen( lv_vorne ).

lv_ausgabe = lv_vorne+lv_offset(lv_length).
WRITE :/ lv_ausgabe.

*BREAK-POINT.
