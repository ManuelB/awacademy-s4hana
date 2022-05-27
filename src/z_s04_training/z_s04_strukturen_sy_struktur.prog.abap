*&---------------------------------------------------------------------*
*& Report Z_S04_STRUKTUREN_SY_STRUKTUR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_strukturen_sy_struktur.

DATA lv_string TYPE string VALUE 'TESTTEXT'.

FIND  'T' IN lv_string.
IF sy-subrc EQ 0. "rc = returncode.
  WRITE: '"T" wurde gefunden.'.
ELSE.
  WRITE: '"T" wurde nicht gefunden!'.
ENDIF.

ULINE.
ULINE.

"DATA lv_datum TYPE d.
DATA lv_datum   TYPE sy-datlo.
DATA lv_ausgabe TYPE string.
DATA lv_tag     TYPE string.
DATA lv_monat   TYPE string.
DATA lv_jahr    TYPE string.

lv_datum = sy-datlo.

WRITE: / sy-datlo.
ULINE.

"WRITE: lv_datum+6(2).

lv_tag   = lv_datum+6(2).
lv_monat = lv_datum+4(2).
lv_jahr  = lv_datum(4).

CONCATENATE lv_tag lv_monat lv_jahr INTO lv_ausgabe SEPARATED BY '.'.


WRITE: / 'DATUM:', lv_ausgabe.

ULINE.
ULINE.

DATA lv_uhrzeit TYPE sy-uzeit.
DATA lv_std     TYPE string.
DATA lv_min     TYPE string.
DATA lv_sek     TYPE string.

lv_uhrzeit = sy-uzeit.

WRITE: / 'UHRZEIT:', sy-uzeit.

ULINE.

lv_std = lv_uhrzeit(2).
lv_min = lv_uhrzeit+2(2).
lv_sek = lv_uhrzeit+4(2).

WRITE: / 'Stunde:', lv_std.
WRITE: / 'Minute:', lv_min.
WRITE: / 'Sekunde:', lv_sek.

ULINE.

WRITE: / 'Std.:', lv_std, '|', 'Min.:', lv_min, '|', 'Sek.:', lv_sek, '|'.

ULINE.
ULINE.
