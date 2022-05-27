*&---------------------------------------------------------------------*
*& Report Z_S09_ZEICHENARTIGE_DATENTYPEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_ZEICHENARTIGE_DATENTYPEN.

DATA lv_vorne(20) TYPE c.
DATA lv_mitte(20) TYPE c.
DATA lv_hinten(20) TYPE c.
DATA lv_ausgabe(60) TYPE c.

data lv_offset TYPE i.
data lv_length TYPE i.


PARAMETERS p_text LIKE lv_vorne DEFAULT 'Bäume' LOWER CASE.

lv_vorne = p_text.
WRITE: / lv_vorne.


ULINE. "Dieser Befehl ist für den Trennstrich"

*lv_vorne = 'Bäume'.
lv_mitte = 'blühen im'.
lv_hinten ='Frühling'.


CONCATENATE lv_vorne lv_mitte lv_hinten '.' INTO lv_ausgabe SEPARATED BY ' '. "Dieser Befehl (concatenate) fügt die Texte zusammen"
WRITE: / lv_ausgabe.

REPLACE 'Frühling' IN lv_ausgabe WITH 'Herbst'.
WRITE: / lv_ausgabe.

ULINE.

WRITE: / 'Translate to upper Case'.
Translate lv_ausgabe TO UPPER CASE.
WRITE: / lv_ausgabe.

ULINE.

WRITE: / 'Split'.
SPLIT  lv_ausgabe AT ' ' INTO lv_vorne lv_mitte lv_hinten.
WRITE: / lv_vorne.
WRITE: / lv_mitte.
WRITE: / lv_hinten.

ULINE.
lv_ausgabe = 'Dies ist ein Testtext'.

WRITE: / 'Condense'.
CONDENSE lv_ausgabe. "NO-GAPS"
WRITE: / lv_ausgabe.

WRITE: / 'CONDENSE NO-GAPS'.
CONDENSE lv_ausgabe NO-GAPS.

WRITE: / lv_ausgabe.

ULINE.

lv_ausgabe = lv_vorne(1).
WRITE: / lv_ausgabe.

lv_ausgabe = lv_vorne+1(1).
WRITE: / lv_ausgabe.

lv_offset = 2.

lv_ausgabe = lv_vorne+lv_offset(1).
WRITE: / lv_ausgabe.

lv_length = strlen( lv_vorne ).

lv_ausgabe = lv_vorne+lv_offset(lv_length).
WRITE: / lv_ausgabe.

lv_offset = 0.
lv_length = lv_length - 2.
lv_ausgabe = lv_vorne+lv_offset(lv_length).
WRITE: / lv_ausgabe.
