*&---------------------------------------------------------------------*
*& Report Z_S12_STRING_TEMPLATES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_string_templates.

DATA lv_ausgabetext TYPE string.
DATA lv_zahl TYPE i VALUE 192.
DATA lv_text(50) TYPE c VALUE 'Text'.

lv_ausgabetext = |Variableninhalt|. "|| funktioniert wie ''

WRITE: |text|.

WRITE: / |text{ lv_ausgabetext }|. "vor den {} muss ein Leerzeichen

*Ziel Text: Testtext-192
WRITE: / 'Testtext-', lv_zahl. "Alte Variante (Aufwändig)
WRITE: / |Testtext-{ lv_zahl }|.

WRITE: / |{ lv_text ALIGN = RIGHT WIDTH = 100 } |.

WRITE: / sy-datlo.
WRITE: / | { sy-datlo DATE = RAW }|. "Rohdaten
WRITE: / | { sy-datlo DATE = ISO }|. "ISO-Norm des Datums
WRITE: / | { sy-datlo DATE = USER }|. "Datumsanzeige anhand des Nutzer-Standortes

ULINE.

WRITE: / sy-uzeit.
WRITE: / | { sy-uzeit TIME = RAW }|.
WRITE: / | { sy-uzeit TIME = ISO }|.
WRITE: / | { sy-uzeit TIME = USER }|.

uline.
DATA lv_timestamp TYPE timestampl.
GET TIME STAMP FIELD lv_timestamp."Zeitstempel wird befüllt - gut um Laufzeit zu messen
write: / 'timestamp:', lv_timestamp.
write: / |Timestamp: { lv_timestamp timestamp = iso  }|.

uline.
wait up to 2 seconds.
GET TIME STAMP FIELD lv_timestamp.
write: / |Timestamp: { lv_timestamp timestamp = iso  }|.
