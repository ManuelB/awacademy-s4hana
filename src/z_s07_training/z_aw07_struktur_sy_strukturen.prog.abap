*&---------------------------------------------------------------------*
*& Report Z_AW07_STRUKTUR_SY_STRUKTUREN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_STRUKTUR_SY_STRUKTUREN.

DATA lv_nummer TYPE i.
DATA lv_staring TYPE string VALUE 'TESTEXT'.

FIND 'C' in lv_staring.
IF sy-subrc EQ 0.
  WRITE: '"T" wurde gefunden.'.
  ELSE.
    WRITE: '"T" wurde nicht gefunden.'.


ENDIF.

ULINE.
DATA lv_datum TYPE sy-datlo.
DATA lv_ausgabe TYPE string.
DATA lv_tag TYPE string.
DATA lv_monat TYPE string.
DATA lv_jahr TYPE string.

lv_datum = sy-datlo.

WRITE: / sy-datlo.
ULINE.


*WRITE: / lv_datum+6(2).

lv_tag = lv_datum+6(2).
lv_monat = lv_datum+4(2).
lv_jahr = lv_datum(4).


CONCATENATE lv_tag lv_monat lv_jahr into lv_ausgabe SEPARATED BY '.'.

Write: / 'DATUM: ', lv_ausgabe.

ULINE.


DATA lv_zeit TYPE sy-uzeit.

DATA lv_stunde TYPE string.
DATA lv_minute TYPE string.
DATA lv_sekunde TYPE string.

lv_zeit = sy-uzeit.

WRITE: / sy-uzeit.
ULINE.


*WRITE: / lv_datum+6(2).

lv_stunde = lv_zeit(2).
lv_minute = lv_zeit+2(2).
lv_sekunde = lv_zeit+4(2).

lv_zeit = sy-uzeit.





Write: / 'Stunde: ', lv_stunde.
Write: / 'Menute: ', lv_minute.
Write: / 'Sekunde: ', lv_sekunde.


ULINE.
