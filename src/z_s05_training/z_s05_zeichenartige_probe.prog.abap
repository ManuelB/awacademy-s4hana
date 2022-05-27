*&---------------------------------------------------------------------*
*& Report Z_S05_ZEICHENARTIGE_PROBE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_ZEICHENARTIGE_PROBE.


DATA lv_verarbeitung(20) TYPE c.
DATA lv_vorne(20) TYPE c.
DATA lv_mitte(20) TYPE c.
DATA lv_hinten(20) TYPE c.
DATA lv_ausgabe(60) TYPE c.



PARAMETERS p_text LIKE lv_vorne DEFAULT 'Bäume'.


lv_vorne = p_text.
"WRITE: / lv_vorne.


"ULINE.

"lv_vorne = 'Baume'.
lv_mitte = 'blühen im'.
lv_hinten = 'Frühling'.


CONCATENATE lv_vorne lv_mitte lv_hinten '.' INTO lv_ausgabe SEPARATED BY ' '.


REPLACE 'Frühling' IN lv_ausgabe WITH 'Herbst'.

WRITE: / lv_ausgabe.

ULINE.

WRITE: '...TRANSLATE:'.


TRANSLATE lv_ausgabe TO UPPER CASE.

WRITE: / lv_ausgabe.

ULINE.

SPLIT lv_ausgabe AT ' ' INTO lv_vorne lv_mitte lv_hinten.


WRITE: '...SPLIT:'.

WRITE: / lv_vorne, lv_mitte, lv_hinten.

ULINE.

CONDENSE lv_ausgabe NO-GAPS.

WRITE: '...CONDENSE'.

WRITE: / lv_ausgabe.

DO.
ENDDO.
WRITE:'Fertig'.
