*&---------------------------------------------------------------------*
*& Report Z_S09_STRUKTUREN_SY_STRUKTUREN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_strukturen_sy_strukturen.

DATA lv_nummer TYPE i.
DATA lv_string TYPE string VALUE 'TESTTEXT'.

FIND 'C' IN lv_string.   "FIND C"
IF sy-subrc EQ 0.  "RC= Returncode"
  WRITE: '"T" wurde gefunden.'.
ELSE.
  WRITE: '"T" wurde nicht gefunden'.

ENDIF.

ULINE.

DATA lv_datum TYPE sy-datlo.
DATA lv_ausgabe TYPE string.
DATA lv_tag TYPE string.
DATA lv_monat TYPE string.
DATA lv_jahr TYPE string.

lv_datum = sy-datlo.
ULINE.

"WRITE: / lv_datum+6(2).

lv_tag = lv_datum+6(2).
lv_monat = lv_datum+4(2).
lv_jahr = lv_datum(4).


CONCATENATE lv_tag lv_monat lv_jahr INTO lv_ausgabe SEPARATED BY '.'.


WRITE: / 'DATUM: ', lv_ausgabe.

ULINE.


WRITE: / sy-uzeit.

ULINE.


DATA lv_uhrzeit   TYPE sy-uzeit.  "sy-uzeit ist die System Uhrzeit MEZ-1)
DATA lv_ausgabe2  TYPE string.  "Neue Ausgabe?"
DATA lv_stunde    TYPE string.
DATA lv_minute    TYPE string.
DATA lv_sekunde   TYPE string.

lv_uhrzeit = sy-uzeit.

lv_stunde = lv_uhrzeit(2).       "Lese die ersten beiden Stellen"
lv_minute = lv_uhrzeit+2(2).    "Lese die ersten beiden Stellen aber erst nach plus 2"
lv_sekunde = lv_uhrzeit+4(2).   "Lese die ersten beiden Stellen aber erst nach plus 4"

WRITE: / 'Stunde', lv_stunde.
WRITE: / 'Minuten', lv_minute.
WRITE: / 'Sekunden', lv_sekunde.
