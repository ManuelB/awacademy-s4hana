*&---------------------------------------------------------------------*
*& Report Z_AW07_ZEICHENARTIGE_DATENTYP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_ZEICHENARTIGE_DATENTYP.

DATA lv_vorne(20) Type c.
DATA lv_mitte(20) Type c.
DATA lv_hinten(20) Type c.
DATA lv_ausgabe(60) Type c.

DATA lv_offset TYPE i.
DATA lv_lenght TYPE i.






PARAMETERS p_text like lv_vorne DEFAULT 'Bäume' LOWER CASE.



lv_vorne = p_text.
write: / lv_vorne.

Uline.

*lv_vorne = 'Bäume'.
lv_mitte = 'blühen im'.
lv_hinten = 'Frühling'.

concatenate lv_vorne lv_mitte lv_hinten '.' INTO lv_ausgabe SEPARATED BY ' '.

Write: / lv_ausgabe.


REPLACE 'Frühling' IN lv_ausgabe WITH 'Herbst'.
Write: / lv_ausgabe.

ULINE.
Write: / 'Translate to upper Case'.

TRANSLATE lv_ausgabe to UPPER CASE.
Write: / lv_ausgabe.
ULINE.

Write: / 'Split'.

SPLIT lv_ausgabe AT ' ' INTO lv_vorne lv_mitte lv_hinten.

WRITE: / lv_vorne.
WRITE: / lv_mitte.
WRITE: / lv_hinten.

ULINE.
lv_ausgabe = 'Das ist ein      Testtext'.

WRITE: / 'CONDENSE'.
CONDENSE lv_ausgabe.
write: / lv_ausgabe.

WRITE: / 'CONDENSE NO-GAPS'.
CONDENSE lv_ausgabe NO-GAPS.

write: / lv_ausgabe.

ULINE.

lv_ausgabe = lv_vorne(1).
write: / lv_vorne .

lv_ausgabe = lv_vorne+1(1).
write: / lv_vorne.

lv_offset = 2.
lv_ausgabe = lv_vorne+lv_offset(1).
Write: / lv_ausgabe .

lv_lenght  = strlen( lv_vorne ).
Write: / lv_ausgabe.

lv_offset = 0.
lv_lenght = lv_lenght - 2.

lv_ausgabe = lv_vorne+lv_offset(lv_lenght).
Write: / lv_ausgabe.

lv_offset = 0.
lv_lenght = lv_lenght - 2.

lv_ausgabe = lv_vorne+lv_offset(lv_lenght).
Write: / lv_ausgabe.
