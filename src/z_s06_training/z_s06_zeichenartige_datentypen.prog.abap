*&---------------------------------------------------------------------*
*& Report Z_S06_ZEICHENARTIGE_DATENTYPEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S06_ZEICHENARTIGE_DATENTYPEN.

DATA LV_vorne(30) TYPE c.
DATA LV_mitte(30) TYPE c.
DATA LV_hinten(30) TYPE c.
DATA LV_ausgabe(120) TYPE c.
DATA lv_offset TYPE i.
DATA lv_length TYPE i.

PARAMETERS p_text LIKE lv_vorne DEFAULT 'Bäume' LOWER CASE.

lv_vorne = p_text.
WRITE: / lv_vorne.

ULINE.

lv_vorne = 'Bäume'.
lv_mitte = 'blühen im'.
lv_hinten = 'Frühling'.
CONCATENATE lv_vorne lv_mitte lv_hinten  '.' into lv_ausgabe SEPARATED BY ' '.
WRITE: / lv_ausgabe.

ULINE.

WRITE: / 'Concatenate'.
REPLACE 'Frühling' IN lv_ausgabe WITH 'Herbst'.
WRITE: / lv_ausgabe.

ULINE.

WRITE: / 'Translate to upper case'.
TRANSLATE lv_ausgabe TO UPPER CASE.
WRITE: / lv_ausgabe.

ULINE.

WRITE: / 'Splite'.
SPLIT lv_ausgabe AT ' ' INTO lv_vorne lv_mitte lv_hinten .
WRITE: / lv_vorne.
WRITE: / lv_mitte.
WRITE: / lv_hinten.

ULINE.

lv_ausgabe = 'Das             ist             ein                   Testext'.

WRITE: / 'Condense'.
CONDENSE lv_ausgabe NO-GAPS.
WRITE: /  lv_ausgabe.

ULINE.

WRITE: / 'NO-Gaps'.
CONDENSE lv_ausgabe NO-GAPS.
WRITE: /  lv_ausgabe.

ULINE.

*Comment
*WRITE: / lv_vorne.
*WRITE: / lv_mitte.
*WRITE: / lv_hinten.
*  Das ist ein Ganzzeiliger Kommentar
"Das ist ein Inline-Kommentar

WRITE: / 'Offset'.
lv_ausgabe = lv_vorne(1).
lv_ausgabe = lv_vorne+1(1).
WRITE: / lv_ausgabe.

lv_offset = 2.
"lv_ausgabe = lv_vorne + lv_offset(1).
WRITE: / lv_ausgabe.

lv_length = strlen( lv_vorne ).

lv_length = lv_vorne+lv_offset(lv_length).
WRITE: / lv_ausgabe.


lv_offset = 0.

lv_length = lv_vorne+lv_offset(lv_length).
WRITE: / lv_ausgabe.
