*&---------------------------------------------------------------------*
*& Report Z_S01_STRUKTUREN_SY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_strukturen_sy.

*VERSTANDEN.

*Irritierender Name. Hier ist keine Struktur. Das Sind alles nur Systemfelder.
*In F1 ist eine Liste mit Systemfelder. Die alles mögliche abfragen können.

DATA lv_string TYPE String VALUE 'test'.


*Finde T in der String-Variable.
FIND 'T' IN lv_string.


*Systemfelder werden genutzt, um Systemzustände abzufragen.

IF sy-subrc = 0. " rc = Gibt ergebnis zurück. 0 true. 4 false.
*interessant: lv_string in der if bedingung nicht referenziert.

  WRITE: 'T wurde gefunden'.

ELSE.
  WRITE: 'T wurde nicht gefunden'.

ENDIF.

ULINE.


*Datentyp für Datum.
*DATA lv_Datum TYPE d.


*Dictionary-Objekt, das technische/semantische Eigenschaften von elementaren Datentypen definiert. Fungieren so also auch als Datentypen.
*Hinter Type ist eine DDic-Domäne.
DATA lv_Datum TYPE sy-datlo. "Systemfeld fungiert hier also datentyp für Datum.
DATA lv_ausgabe TYPE String.
DATA lv_tag TYPE String.
DATA lv_Monat TYPE String.
DATA lv_Jahr TYPE String.


lv_datum = sy-datlo. " hier wird die variable lv_datum gefüllt mit systemfeldinformation sy-datlo.



ULINE.
* 6 Ab wo meine Variable gelesen wird, 2 wie viele Stellen gelesen werden.
* Offset = An welcher stell beginnt er das lesen. (In Klammer wieviele Stellen er ab da liest.)
*
*write: lv_datum+6 (2).
*lv_ausgabe = lv_datum+6.
lv_tag = lv_datum+6(2).
lv_monat = lv_datum+4(2).
lv_jahr = lv_datum(4).

CONCATENATE lv_tag lv_monat lv_jahr INTO lv_ausgabe SEPARATED BY '.'.
WRITE: / 'Datum: ', lv_ausgabe.


*WRITE: / sy-sysid.
*WRITE: / sy-datum.
*WRITE: / sy-datlo.

ULINE.

DATA lv_Uhrzeit TYPE sy-uzeit.
DATA lv_Sek TYPE String.
DATA lv_Min TYPE String.
DATA lv_STu TYPE String.
DATA lv_UhrE TYPE String.

lv_uhrzeit = sy-uzeit.

lv_sek = lv_uhrzeit(2).
lv_min = lv_uhrzeit+2(2). "offset = +2 Länge (2)."
lv_stu = lv_uhrzeit+4(2).

CONCATENATE lv_sek lv_min lv_Stu  INTO lv_uhre SEPARATED BY ':'.

WRITE: / 'Uhrzeit ', lv_UhrE.

WRITE: / lv_sek ,'-', lv_min,'-',  lv_stu.

ULINE.

*DATA lv_Uhrzeit TYPE sy-uzeit.
*DATA lv_UhrE TYPE String.
*DATA lv_Sek TYPE String.
*DATA lv_Min TYPE String.
