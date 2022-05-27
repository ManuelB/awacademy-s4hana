*&---------------------------------------------------------------------*
*& Report Z_S03_ZEICHENARTIGE_DATENTYPEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S03_ZEICHENARTIGE_DATENTYPEN.

DATA lv_verarbeitung(50) TYPE c.
DATA lv_vorne(50) TYPE c.
DATA lv_mitte(50) TYPE c.
DATA lv_hinten(50) TYPE c.
DATA lv_ausgabe(150) TYPE c.

DATA lv_offset TYPE i.
DATA lv_length TYPE i.

PARAMETERS p_text LIKE lv_verarbeitung DEFAULT 'ABAP' LOWER CASE.

lv_verarbeitung = 'TEST'.
lv_verarbeitung = P_text.
WRITE: / lv_verarbeitung.



ULINE.

lv_vorne = 'Bäume'.
lv_mitte = 'blühen im'.
lv_hinten = 'Frühling'.


CONCATENATE lv_vorne lv_mitte lv_hinten '.' INTO lv_ausgabe SEPARATED BY ' '.
WRITE: / lv_ausgabe.

REPLACE 'Frühling' IN lv_ausgabe WITH 'Herbst'.
WRITE: / lv_ausgabe.

WRITE: / 'Translate to upper case'.

TRANSLATE lv_ausgabe TO UPPER CASE.
WRITE: / lv_ausgabe.

WRITE:'Split'.
SPLIT lv_ausgabe AT ' ' INTO lv_vorne lv_mitte lv_hinten.

* Kommentar

ULINE.

lv_ausgabe = 'Dies ist ein     Testtext'.

WRITE: / 'CONDENSE'.

CONDENSE lv_ausgabe NO-GAPS.

WRITE: / lv_ausgabe.

ULINE.

lv_ausgabe = lv_vorne(1).
WRITE: / lv_ausgabe .

lv_ausgabe = lv_vorne+0(1).
WRITE: / lv_ausgabe .


lv_ausgabe = lv_vorne+1(1).
WRITE: / lv_ausgabe .

lv_offset = 2.
lv_ausgabe = lv_vorne+lv_offset(1).
WRITE: / lv_ausgabe .

lv_length = strlen( lv_vorne ).


lv_ausgabe = lv_vorne+lv_offset(lv_length).
WRITE: / lv_ausgabe .

lv_offset = 0.
lv_length = lv_length - 2.
lv_ausgabe = lv_vorne+lv_offset(lv_length).
WRITE: / lv_ausgabe .
