*&---------------------------------------------------------------------*
*& Report Z_S09_STRING_TEMPLATES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_string_templates.

DATA lv_ausgabetext TYPE string.
DATA lv_zahl TYPE i VALUE 192.
DATA lv_text(50) TYPE c VALUE 'TEXT'.


lv_ausgabetext = |Variableninhalt|.


WRITE: |Dies ist ein Text.|.


WRITE: / |Dies ist ein Text. { lv_ausgabetext } |.

"Ziel ist ein  Text der wie folgt aussieht: Testtext-192"

WRITE: / 'Testtext-', lv_zahl.    "So soll es nicht aussehen (alte Variante)"

WRITE / |Testtext-{ lv_zahl }|.   "So soll es aussehen (neue Variante)"

WRITE: / |LEFT: { lv_zahl ALIGN = RIGHT WIDTH = 100 }|.   "Erzeugt ein Feld mit Breite 100 und den TEXT rechtsbündig"

WRITE: / sy-datlo.    "Datum von SAP selbst formatiert"

WRITE: / | { sy-datlo DATE = RAW }|.    "Die "Rohe" Ausgabe (Rohdaten) des Datum"
WRITE: / | { sy-datlo DATE = ISO }|.    "Die "Rohe" Ausgabe (Rohdaten) des Datum nach ISO-Norm"
WRITE: / | { sy-datlo DATE = USER }|.   "Die USER Datumsausgabe"

ULINE.

WRITE: sy-uzeit.
WRITE: / |{ sy-uzeit TIME = RAW } |.     "Die "Rohe" Ausgabe (Rohdaten) der Systemzeit"
WRITE: / |{ sy-uzeit TIME = ISO } |.     "Die "Rohe" Ausgabe (Rohdaten) der Systemzeit nach ISO-Norm"
WRITE: / |{ sy-uzeit TIME = USER } |.    "Die USER der Systemzeit"

ULINE.

DATA lv_timestamp TYPE timestampl.
GET TIME STAMP FIELD lv_timestamp.  "Hier wird der Zeitstempel "befüllt""

WRITE: / 'Timestamp:', lv_timestamp. "Ausgabe des Zeitstempels"

WRITE: / |Timestamp: { lv_timestamp TIMESTAMP = USER }|.    "Ausgabe des Zeitstempels "gut auslesbar""

WAIT UP TO 2 SECONDS. "Wartet 2 Sekunden bis der Stempel ausgegeben wird"
GET TIME STAMP FIELD lv_timestamp.
WRITE: / |Timestamp: { lv_timestamp TIMESTAMP = ISO }|.
