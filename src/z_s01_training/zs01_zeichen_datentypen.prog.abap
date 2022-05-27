*&---------------------------------------------------------------------*
*& Report Z_S01_ZEICHENARTIGE_DATENTYPEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_zeichenartige_datentypen.

*Verstanden

*Type c braucht Zifferangabe
DATA lv_vorne(20) TYPE c.
DATA lv_mitte(20) TYPE c.
DATA lv_hinten(20) TYPE c.
DATA lv_ausgabe(60) TYPE c.

DATA lv_offset TYPE i. "Offset soll variable sein.
DATA lv_length TYPE i.

*"Parameter übernimmt sämtliche Eigenschaften von deklarierten Datenobjekts"
*Defaulst stellt Bäume als default

*PARAMETERS ist eingabefeld. p_text dessen name. Hier wird eingstellst, dass die Eingabe in lv_vorne gespeichert wird.
PARAMETERS p_text LIKE lv_vorne DEFAULT 'Bäume' LOWER CASE. "Lower case macht allen text klein."

*bezieht sich auf den Befehl darüber. Auch nötig.
lv_vorne = p_text. "variable soll Inhalt von Text enthalten.
WRITE: / lv_vorne.

ULINE.
*Ersetzt lv_vorne mit das, was ins Textfeld eingegeben wurde.
*lv_vorne  = 'Bäume'.
lv_mitte  = 'blühen im'.
lv_hinten = 'Frühling'.

ULINE.
WRITE:/ 'Concatenate'.
*" Concatenate verkettet alle Strings in eine Ausgabe und definiert, dass die String mit einem Leerzeichen abstände haben."
CONCATENATE lv_vorne lv_mitte lv_hinten INTO lv_ausgabe SEPARATED BY ' '.
WRITE: / lv_ausgabe.

ULINE.

WRITE : / 'Replace'.
*Ersetzt Text mit anderen Text.
REPLACE 'Frühling' IN lv_ausgabe WITH 'Herbst'.
WRITE: / lv_ausgabe.

ULINE.
WRITE: / 'Translate to upper Case'.
*Alles wird groß geschrieben
TRANSLATE lv_ausgabe TO UPPER CASE.
WRITE: / lv_ausgabe.

ULINE.
WRITE: / 'Split'.
*Spaltet Ausgabe in 3 verschiedene Strings.
SPLIT lv_ausgabe AT ' ' INTO lv_vorne lv_mitte lv_hinten.

WRITE: / lv_vorne.
WRITE: / lv_mitte.
WRITE: / lv_hinten.

ULINE.

lv_ausgabe = 'Dies ist ein       Testtext'.

WRITE: / 'CONDENSE'.
*Entfernt nur die überflüssigen Leerzeichen
CONDENSE lv_ausgabe ."
WRITE: / lv_ausgabe .

*Entfernt alle Leerzeichen.
WRITE: / 'CONDENSE NO-GABPS'.
CONDENSE lv_ausgabe NO-GAPS.
WRITE: / lv_ausgabe .

ULINE.
WRITE:/ 'erster Buchstabe'.
* Nur erster Buchstabe von lv_vorne hat platz in der variable.
lv_ausgabe = lv_vorne(1).
WRITE: / lv_ausgabe .

ULINE.
WRITE:/ 'zweiter Buchstabe'.
* Nur zweiter Buchstabe von lv_vorne hat platz in der variable.
lv_ausgabe = lv_vorne+1(1).
WRITE: / lv_ausgabe .

ULINE.
WRITE:/ 'dritter Buchstabe'.
lv_offset = 2.

lv_ausgabe = lv_vorne+lv_offset(1).
WRITE: / lv_ausgabe .

ULINE.
WRITE : / |strlen|.
lv_length = strlen( lv_vorne ).
WRITE : / lv_length.

*Anzahl der Zeichen in arg, wobei schließende Leerzeichen in Datenobjekten nicht mitgezählt während sie in Datenobjekten vom Typ string gezählt werden.

lv_ausgabe = lv_vorne+lv_offset(lv_length).
WRITE: / lv_ausgabe .

ULINE.
lv_offset = 0.
lv_length = lv_length - 2.

lv_ausgabe = lv_vorne+lv_offset(lv_length).
WRITE: / lv_ausgabe .
