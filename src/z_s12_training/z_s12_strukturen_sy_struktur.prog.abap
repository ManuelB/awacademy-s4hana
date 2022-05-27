*&---------------------------------------------------------------------*
*& Report Z_S12_STRUKTUREN_SY_STRUKTUR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_strukturen_sy_struktur.


DATA lv_string TYPE string VALUE 'TESTTEXT'.

FIND 'C' IN lv_string.

IF sy-subrc EQ 0. "Systemstruktur, rc = Returncode, 0 heißt, dass es mind. einmal gefunden wurde
  WRITE: / '"T" wurde gefunden'.
ELSE.
  WRITE: / '"T" wurde nichtgefunden'.
ENDIF.

ULINE.
DATA lv_datum TYPE sy-datlo. "lv_datum vom Datentyp sy-datlo "Wenn SAP den Datentyp von datlo änder funktioniert der code weiterhin --> BESSER
DATA lv_ausgabe TYPE string.
DATA lv_tag TYPE string.
DATA lv_monat TYPE string.
DATA lv_jahr TYPE string.
*data lv_datum type d. "Datentyp d = Datumsfeld mit Feldlänge von 8 Zeichen
lv_datum = sy-datlo. "lv_datum hat jetzt den Datentyp sy-datlo

WRITE: / sy-datlo.
ULINE.
lv_tag = lv_datum+6(2).
lv_monat = lv_datum+4(2).
lv_jahr = lv_datum(4).
*write:/ lv_datum+6(2). "Ab welcher Stelle meiner Vartiablen gelesen wird(Offset (hier 6)) + wie viele Stellen ausgegben werden
CONCATENATE lv_tag lv_monat lv_jahr INTO lv_ausgabe SEPARATED BY '.'.
WRITE: / 'Datum:', lv_ausgabe.

DATA lv_zeit TYPE sy-uzeit.
DATA lv_min TYPE string.
DATA lv_sec TYPE string.
DATA lv_hour TYPE string.


lv_zeit  =   sy-uzeit. "Essentieller Schritt da lv_zeit sonst keinen Inhalt hat.
lv_min   =   lv_zeit+2(2).
lv_sec   =   lv_zeit+4(2).
lv_hour  =   lv_zeit(2).

WRITE: / sy-uzeit. " STRG + Löschen-Taste löscht alles bis sy-
WRITE: / 'Aktuelle Zeit'.
ULINE.
WRITE: / 'Stunde:', lv_hour.
WRITE: / 'Minute:', lv_min.
WRITE: / 'Sekunde:', lv_sec.


*WRITE: / 'Stunde:', lv_hour, / 'Minute:', lv_min, 'Sekunde:', lv_sec.
