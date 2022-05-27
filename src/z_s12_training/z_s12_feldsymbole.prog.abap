*&---------------------------------------------------------------------*
*& Report Z_S12_FELDSYMBOLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S12_FELDSYMBOLE.

"Feldsymbol --> Zeiger welcher immer auf den Speicherbereich eines bestimmten Datenobjektes zeigt
"Dieses Datenobjekt kann eine Variable, Tabelle, Textbereich etc. sein
*<BeispielFeldsymbol>

data lv_zahl type i.
FIELD-SYMBOLS <zahl> type i. "Deklaration des Feldsymbols <zahl>

lv_zahl = 23.
"Zuordnung des Feldsymbols zum Speicherbereich der Variable
assign lv_zahl to <zahl>. "lokale Variable dem Feldsymbol zu ordnen

<zahl> = 17.



************************************************************************************************************************
TYPES: BEGIN OF lty_user,
         id        TYPE i,
         vname(15) TYPE c,
         nname(15) TYPE c,
       END OF lty_user
       .

DATA ls_user TYPE lty_user.
DATA lt_user TYPE TABLE OF lty_user.

FIELD-SYMBOLS <user> type lty_user.

ls_user-id    = 1.
ls_user-vname = |Paul|.
ls_user-nname = |Fischer|.
APPEND ls_user TO lt_user.

ls_user-id    = 2.
ls_user-vname = |Max|.
ls_user-nname = |Mustermann|.
APPEND ls_user TO lt_user.

"Es ist möglich während eines Loops der aktuellen Zeile der Tabelle ein Feldsymbol zuzuordnen
"Damit können die Daten der Zeile direkt verändert werden
loop at lt_user ASSIGNING <user>. "Assignement erfolg hier und nicht seperat
  <user>-nname = |Konstanz|.

  ENDLOOP.

BREAK-POINT.
