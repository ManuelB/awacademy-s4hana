*&---------------------------------------------------------------------*
*& Report Z_S03_STRUKTUREN_SY_STRUKTUREN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s03_strukturen_sy_strukturen.


DATA lv_string TYPE string VALUE 'TESTTEXT'.

FIND 'T' IN lv_string.

IF sy-subrc EQ 0.
*  RC = Return code, 0 wurde gefunden. 4 wurde nicht gefunden.
  WRITE: '"T" wurde gefunden'.
ELSE.
  WRITE: '"T" wurde nicht gefunden'.
ENDIF.

WRITE: / 'ENDE DES PROGRAMMS'.
*ABAP-Systemfelder zeigt alle SY Strukturen, die es gibt.

ULINE.

*AUTHORITY-CHECK = Prüfung auf eine Berechtigung

* DATA lv_datum TYPE d.
* DATA lv_datum TYPE i. Geht auch weil i groß genug ist.
*REVOIR LES DIFFÉRENTS TYPES DE DONNÉES!! EX: type d est un Datumfeld.
DATA lv_datum TYPE sy-datlo.
lv_datum = sy-datlo.
WRITE: / sy-datlo.

WRITE: / lv_datum+6(2).
*Offset +6(2) veut dire qu'il demarre apres pour montrer les 2
* derniers.
* par ex sur 20220322, il va montrer 22.

WRITE:  / 'Uhrzeit'.

WRITE: / sy-uzeit.

DATA lv_uzeit TYPE sy-uzeit.
DATA lv_Stunde TYPE string.
DATA lv_Minute TYPE string.
DATA lv_Sekunde TYPE string.

lv_uzeit = sy-uzeit.

lv_stunde = lv_uzeit(2).
lv_Minute = lv_uzeit+2(2).
lv_Sekunde = lv_uzeit+4(2).

WRITE: / 'Stunde :', lv_stunde.
WRITE: / 'Sekunde :', lv_Sekunde.
WRITE: / 'Minute :', lv_minute.
