*&---------------------------------------------------------------------*
*& Report Z_S06_STRUKTUREN_SY_STRUKTUR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_strukturen_sy_struktur.


DATA lv_nummer TYPE i.
DATA lv_string TYPE string VALUE 'TesTTexT'.

FIND 'T' IN lv_string.
IF sy-subrc EQ 0.
  WRITE: '"T" wurde gefunden.'.
ELSE.
  WRITE: '"T" wurde nicht gefunden.'.

ENDIF.
**********************************************************************
WRITE: / sy-datlo.

*DATA lv_datum TYPE i.
DATA lv_datum TYPE sy-datlo.
DATA lv_ausgabe TYPE string.
DATA lv_tag TYPE string.
DATA lv_monat TYPE string.
DATA lv_jahr TYPE string.

lv_datum = sy-datlo.

WRITE: / sy-datlo.
ULINE.
**********************************************************************
lv_tag = lv_datum+6(2).
lv_monat = lv_datum+4(2).
lv_jahr = lv_datum(4).

CONCATENATE lv_tag lv_monat lv_jahr INTO lv_ausgabe SEPARATED BY '.'.

WRITE: / 'DATUM: ', lv_ausgabe.
ULINE.
**********************************************************************
DATA lv_zeit TYPE sy-uzeit.
DATA lv_std TYPE string.
DATA lv_min TYPE string.
DATA lv_sec TYPE string.

lv_std = sy-uzeit(2).
lv_min = sy-uzeit+2(2).
lv_sec = sy-uzeit+4(2).

lv_zeit = sy-uzeit.

WRITE: / 'SYST UHRZEIT.'.

WRITE: / '  Stunde:', lv_std.
WRITE: / '  Minute:', lv_min.
WRITE: / 'Sekunden:', lv_sec.
ULINE.
**********************************************************************
