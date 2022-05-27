*&---------------------------------------------------------------------*
*& Report Z_S02_STRING_TEMPLATES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_STRING_TEMPLATES.

DATA lv_ausgabetext TYPE string.
DATA lv_zahl TYPE i VALUE 192.
DATA lv_text(50) TYPE c VALUE 'TEXT'.

" Betragszeichen altgr+<


lv_ausgabetext = |Variableninhalt|.

WRITE: |Dies ist ein Text.|.

WRITE: / |Dies ist ein Text.{ lv_ausgabetext }|.

"Ziel: Testtext: Testtext-192.
WRITE: / 'Testtext-', lv_zahl. "Alte Variante - aufwändig!

WRITE: / |Testtext-{ lv_zahl }|.



"man kann auch bisshen Formatieren wie bei HTML
WRITE: / |{ lv_text ALIGN = RIGHT WIDTH = 100 }|.

WRITE: / sy-datlo. "so wird es ausgegeben, schon formatiert.
WRITE: / |{ sy-datlo DATE = RAW }|. "so kann man sich z.B. die Rohdarstellung ausgeben.
WRITE: / |{ sy-datlo DATE = ISO }|. "so kann man sich ISO ausgeben
WRITE: / |{ sy-datlo DATE = USER }|. " wie beim User standard.


WRITE: / |{ lv_text ALIGN = RIGHT WIDTH = 100 }|.


WRITE: / sy-uzeit.
WRITE: / |{ sy-uzeit TIME = USER }|.
WRITE: / |{ sy-uzeit TIME = RAW }|.
WRITE: / |{ sy-uzeit TIME = ISO }|.
WRITE: / |{ sy-uzeit TIME = ENVIRONMENT }|.




DATA lv_timestamp TYPE timestampl.
get TIME STAMP FIELD lv_timestamp. "Zeitstempel wird befüllt. Oft wichtig nachzuvollzeien, wann best. Dinge passieren.

WRITE: / 'Timestamp: ', lv_timestamp.
WRITE: / |Timestamp: { lv_timestamp TIMESTAMP = ISO }|.

WAIT UP TO 2 SECONDS.
get TIME STAMP FIELD lv_timestamp.
WRITE: / |Timestamp: { lv_timestamp TIMESTAMP = ISO }|.
