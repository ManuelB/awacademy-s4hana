*&---------------------------------------------------------------------*
*& Report Z_S12_ZEICHENARTIGE_DATENTYPEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_zeichenartige_datentypen.

DATA lv_vorne(20) TYPE c.
DATA lv_mitte(20) TYPE c.
DATA lv_hinten(20) TYPE c.
DATA lv_ausgabe(60) TYPE c.
DATA lv_offset TYPE i.
DATA lv_length TYPE i.

PARAMETERS p_text LIKE lv_vorne DEFAULT 'Bäume'.


lv_vorne = p_text.
WRITE: / lv_vorne.

ULINE. "Trennstrich wird eingefügt"

"lv_vorne = 'Bäume'."
lv_mitte = '20'.
lv_hinten = '30'.



CONCATENATE lv_vorne lv_mitte lv_hinten '.' INTO lv_ausgabe SEPARATED BY ' '. "verkettet Variablen"
WRITE: / lv_ausgabe.

REPLACE 'Frühling' IN lv_ausgabe WITH 'Herbst'.
WRITE: / lv_ausgabe.

TRANSLATE lv_ausgabe TO UPPER CASE.
WRITE: / lv_ausgabe.

WRITE: / 'Split'.
SPLIT lv_ausgabe AT ' ' INTO lv_vorne lv_mitte lv_hinten. "Teilt ... bei in..."
WRITE: / lv_vorne.
WRITE: / lv_mitte.
WRITE: / lv_hinten. "Das ist ein inline Kommentar

"mehrere Zeilen gleichzeitig ausblenden: STRG + <"
"mehrere Zeilen gleichzeitig einblenden: STRG + >"

* Das ist ein ganzzeiliger Kommentar

WRITE: / 'Condense'.
lv_ausgabe = 'Das ist ein   Testtext'.
CONDENSE lv_ausgabe. "NO-GAPS.
WRITE: / lv_ausgabe.
CONDENSE lv_ausgabe NO-GAPS.
WRITE: / lv_ausgabe.

ULINE.

lv_ausgabe = lv_vorne(1).
WRITE: / lv_ausgabe.

lv_ausgabe = lv_vorne+1(1). "offset+1 --> fängt beim +1 +(Wert in Klammern) Wert/Buchstaben an
WRITE: / lv_ausgabe.

lv_offset = 2.
lv_ausgabe = lv_vorne+lv_offset(1).
WRITE: / lv_ausgabe.

lv_length = strlen( lv_vorne ). "strlen = string length ( x ) Wert in Klammern braucht die Leerzeichen
lv_ausgabe = lv_vorne+lv_offset(lv_length).
WRITE: / lv_ausgabe.

lv_offset = 0.
lv_length = lv_length - 2. " Länge von lv_vorne war 5(Bäume) --> -2 = 3
lv_ausgabe = lv_vorne+lv_offset(lv_length).
WRITE: / lv_ausgabe.
