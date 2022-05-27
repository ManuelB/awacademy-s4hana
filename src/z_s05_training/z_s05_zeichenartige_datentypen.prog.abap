*&---------------------------------------------------------------------*
*& Report Z_S05_ZEICHENARTIGE_DATENTYPEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_zeichenartige_datentypen.


DATA lv_verarbeitung(20) TYPE c.
DATA lv_vorne(20) TYPE c.
DATA lv_mitte(20) TYPE c.
DATA lv_hinten(20) TYPE c.
DATA lv_ausgabe(60) TYPE c.

DATA lv_offset TYPE i.
DATA lv_lenght TYPE i.

PARAMETERS p_text LIKE lv_vorne DEFAULT 'Bäume'.


lv_vorne = p_text.
WRITE: / lv_vorne.

ULINE.

"lv_vorne = 'Baume'.
lv_mitte = 'blühen im'.
lv_hinten = 'Frühling'.

CONCATENATE lv_vorne lv_mitte lv_hinten '.' INTO lv_ausgabe SEPARATED BY ' '.
WRITE: / lv_ausgabe.

REPLACE 'Frühling' IN lv_ausgabe WITH 'Herbst'.

ULINE.

WRITE: '...TRANSLATE:'.


TRANSLATE lv_ausgabe TO UPPER CASE.

WRITE: / lv_ausgabe.

ULINE.

SPLIT lv_ausgabe AT ' ' INTO lv_vorne lv_mitte lv_hinten.


WRITE: '...SPLIT:'.

WRITE: / lv_vorne.
WRITE: / lv_mitte.
WRITE: / lv_hinten.

ULINE.

CONDENSE lv_ausgabe NO-GAPS.

WRITE: '...CONDENSE'.

WRITE: / lv_ausgabe.

ULINE.

lv_ausgabe = lv_vorne+0(1).
WRITE: lv_ausgabe.

lv_ausgabe = lv_vorne+1(1).
WRITE: / lv_ausgabe.

lv_offset = 2.
lv_ausgabe = lv_vorne+lv_offset(1).
WRITE: / lv_ausgabe.

lv_lenght = strlen( lv_vorne ).

lv_ausgabe = lv_vorne+lv_offset(lv_lenght).
WRITE: / lv_ausgabe.


lv_Offset = 0.
lv_lenght = lv_lenght - 2. "erste 3 Buchstabe = B Ä U M E , 1 2 3 4 5 = 5-2 = 3

lv_ausgabe = lv_vorne+lv_offset(lv_lenght).
WRITE: / lv_ausgabe.
