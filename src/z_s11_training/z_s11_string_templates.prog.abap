*&---------------------------------------------------------------------*
*& Report Z_S11_STRING_TEMPLATES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_string_templates.

DATA lv_ausgabetext TYPE string.
DATA lv_zahl TYPE i VALUE 192.
DATA lv_text(50) TYPE c VALUE 'text'.

lv_ausgabetext = |Variableinhalt|.
WRITE: |Dies ist ein Text|.
WRITE: / |Dies ist ein Text { lv_ausgabetext }|.

*Zieltext : Testtext-192

WRITE:/ 'Testtext-', lv_zahl. "alte variante
WRITE :/ |Testtext-{ lv_zahl }|.

WRITE: / | { lv_text ALIGN = RIGHT WIDTH = 100 }|.
WRITE :/ sy-datlo.
WRITE: /'Raw', | { sy-datlo DATE = RAW }|.
WRITE: /'ISO', | { sy-datlo DATE = ISO }|.
WRITE: /'User', | { sy-datlo DATE = USER }|.

write :/ sy-uzeit.
write:/ 'Raw', | { sy-uzeit time = RAW } |.
write:/ 'ISO', | { sy-uzeit time = ISO } |.
write:/ 'User',| { sy-uzeit time = USER } |.

Data lv_timestamp type timestampl.
get TIME STAMP FIELD lv_timestamp.

write :/ 'Timestamp', lv_timestamp.
write :/ |Timestamp : { lv_timestamp TIMESTAMP = ISO }|.

wait UP TO 2 seconds.
get TIME STAMP FIELD lv_timestamp.
write :/ |Timestamp : { lv_timestamp TIMESTAMP = ISO }|.

write :/ sy-timlo.
