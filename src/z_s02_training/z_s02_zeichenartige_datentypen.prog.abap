*&---------------------------------------------------------------------*
*& Report Z_S02_ZEICHENARTIGE_DATENTYPEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_zeichenartige_datentypen.

"Textauswahl mit gedrückter ALT-Tast
DATA lv_vorne(20) TYPE c.
DATA lv_mitte(20) TYPE c.
DATA lv_hinten(20) TYPE c.
DATA lv_ausgabe(60) TYPE c.
DATA lv_offset TYPE i.
DATA lv_length TYPE i.



PARAMETERS p_text LIKE lv_vorne DEFAULT 'Bäume'.


lv_vorne = p_text.
WRITE: / lv_vorne.

ULINE.


"lv_vorne = 'Bäume '.
lv_mitte = 'blühen im '.
lv_hinten = 'Frühling'.


CONCATENATE lv_vorne lv_mitte lv_hinten '.' INTO lv_ausgabe SEPARATED BY ' '. "Befehl fügt Texte zusammen
WRITE: / lv_ausgabe.

ULINE.

REPLACE 'Frühling' IN lv_ausgabe WITH 'Herbst'.
WRITE: / lv_ausgabe.

ULINE.

WRITE: / 'Translate to upper case'.
TRANSLATE lv_ausgabe TO UPPER CASE.
WRITE: / lv_ausgabe.

ULINE.

"Split teilt TEXT. z.B. CSV eingelesen mit Teilung druch Semikolon.
WRITE: / 'Split'.
SPLIT lv_ausgabe AT ' ' INTO lv_vorne lv_mitte lv_hinten. " schiebt die Teile aus lv_ausgabe in die anderen Variablen.

WRITE: / lv_vorne.
WRITE: / lv_mitte.
WRITE: / lv_hinten.

* Das ist ein ganzzeiliger Kommentar


ULINE.

WRITE: / 'CONDENSE NO-GAPS'.
CONDENSE lv_ausgabe NO-GAPS. " ohne no-gaps wird der Text auf normales Deutsch, z.B. werden aus zwei Leerzeichen eines.
WRITE: / lv_ausgabe.

ULINE.

" nur einzelne Zeichen verwenden
lv_ausgabe = lv_vorne(1). " ein Zeichen
WRITE : / lv_ausgabe.

lv_ausgabe = lv_vorne+1(1). " offset + 1.  Fängt bei 0 an. Offset 0 ist das erste Zeichen.
WRITE : / lv_ausgabe.

lv_ausgabe = lv_vorne+2(1). " offset + 2.  Fängt bei 0 an. Offset 0 ist das erste Zeichen.
WRITE : / lv_ausgabe.

lv_offset = 2.

lv_length = strlen( lv_vorne ). "die Länge eines STings auslesen. Syntax:

lv_ausgabe = lv_vorne+lv_offset(lv_length).
WRITE: / lv_ausgabe.


WRITE: / lv_ausgabe.
