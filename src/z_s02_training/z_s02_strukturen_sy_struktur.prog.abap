*&---------------------------------------------------------------------*
*& Report Z_S02_STRUKTUREN_SY_STRUKTUR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_strukturen_sy_struktur.

DATA lv_nummer TYPE i.
DATA lv_string TYPE string VALUE 'TESTTEXT'.



"Find kann bestimmte Sachen finden. Mann kann abfragen mit IF, ob er es gefunden hat.
" das Feld sy-subrc ist der Returncode des vorherigen Befehls.
" Returncode = heisst, das Gesuchte wurde mindestens 1x gefunden. 4 heisst, es wurde  nicht gefunden.


FIND 'C' IN lv_string.
IF sy-subrc EQ 0.
  WRITE: '"T" wurde gefunden'.
ELSE.
  WRITE: '"T" wurde nicht gefunden'.

ENDIF.

ULINE.

" sy-subrc > F1 Hilfe > ABAP-Systemfelder. Damit kann man wichtige Informationen zum Programmablauf abragen.

" nach "sy-" kann man mit strg+Leertaste auswählen.
" aktuelles Datum ausgeben.
" Andere Darstellung durch anderen TYPE.


*DATA lv_datum TYPE string.
DATA lv_datum TYPE sy-datlo.
DATA lv_ausgabe TYPE string.
DATA lv_tag TYPE string.
DATA lv_monat TYPE string.
DATA lv_jahr TYPE string.

lv_datum = sy-datlo.

WRITE: / sy-datlo.

*WRITE: / lv_datum+6(2). " Auslesen an der 6. STelle (Offset), Zwei Stelle ausgeben.

lv_tag = lv_datum+6(2).
lv_monat = lv_datum+4(2).
lv_Jahr = lv_datum(4).



CONCATENATE lv_tag lv_monat lv_jahr INTO lv_ausgabe SEPARATED BY '.'.

WRITE: / 'DATUM: ', lv_ausgabe.

ULINE.

" Zeilen verschieben mittels Hotkey.

DATA lv_uhrzeit TYPE sy-uzeit.
DATA lv_sek TYPE string.
DATA lv_min TYPE string.
DATA lv_std TYPE string.

lv_uhrzeit = sy-uzeit.

lv_sek = lv_uhrzeit+4(2).
lv_min = lv_uhrzeit+2(2).
lv_std = lv_uhrzeit(2).


WRITE: sy-uzeit.


WRITE: / 'Stunde :',  lv_std.
WRITE: / 'Minute :',  lv_min.
WRITE: / 'Sekunde :', lv_sek.
