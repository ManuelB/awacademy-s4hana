*&---------------------------------------------------------------------*
*& Report Z_S01_FELDSYMBOL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_feldsymbol.

*Verstanden.
*Feldsymbol zeigt auf den Datenbereich einer Variable, egal, was der Wert ist.
*Vergleich Excel, wo man einfach auch einfach nur ein Feld referzenziert. Referenz auf die Position auf den Wert der Variable im Datenbereich.


DATA lv_zahl TYPE i.


*Deklaration des Feldsymbols. Muss zugeschrieben werden
FIELD-SYMBOLS <zahl> type i.



*Zuordnung des Feldsymbols zum Speicherbereich der Variable.
lv_zahl = 23.
Assign lv_zahl to <zahl>.


<zahl> = 17.
*ändert wert der Variable, weil sie auf dessen WerteSpeicherbereich referezenziert.






*Mit Feldsymbolen sparen wir uns den Kram.
TYPES:
  BEGIN OF lty_user,
    id         TYPE i,
    vnname(20) TYPE c,
    nname(20)  TYPE c,

  END OF lty_user.


DATA ls_user TYPE lty_user.
DATA lt_user TYPE TABLE OF lty_user. "Deklariert die 1. Tabelle

FIELD-SYMBOLS <user> TYPE lty_user. "Schreiben Feldsymbol Typen der Struktur.

ls_user-id = 1.
ls_user-nname = |Hrost|.
ls_user-vnname = |Krause|.
APPEND ls_user to lt_user.

ls_user-id = 1.
ls_user-nname = |Max|.
ls_user-vnname = |Mustermann|.
APPEND ls_user to lt_user.


*zuweist automatisch das Feldsymbol zur aktuellen Zeile der Variable. Gleichzeitig bearbeitung möglich.
*Spart read table & modify
*Damit können die Daten der Zeile direkt verändert werden.

BREAK-POINT.
LOOP AT lt_user ASSIGNING <user> . "Geh durch lt_user und schreib jeder Zeile ein Feldsymbol zu. Gleichzeitig: Wert = Albert.
*  <user>-vname = |Albert|.

ENDLOOP.
