*&---------------------------------------------------------------------*
*& Report Z_S03_FELDSYMBOLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S03_FELDSYMBOLE.

* Ein Feldsymbol zeigt immer auf eine Variable, Struktur oder Tabelle und wird immer in < > geschrieben.

DATA lv_zahl TYPE i.

* wir  müssen  das Feldsymbol <zahl> deklarieren,hier unten
FIELD-SYMBOLS <zahl> TYPE i.

lv_zahl = 23.

ASSIGN lv_zahl to <zahl>.

<zahl> = 17.
* Qd on fait ca, lv_zahl se transforme aussi et devient 17 car le Feld Symbol n'a pas de capacité de stockage.



TYPES: BEGIN OF lty_user,
         id        TYPE i,
         vname(15) TYPE c,
         nname(15) TYPE c,
       END OF lty_user.



DATA ls_user TYPE lty_user.
DATA lt_user TYPE TABLE OF lty_user.

FIELD-SYMBOLS <user> TYPE lty_user.

ls_user-id = 1.
ls_user-vname = |Jon|.
ls_user-nname = |Rodd|.
APPEND ls_user to lt_user.

ls_user-id = 2.
ls_user-vname = |Jen|.
ls_user-nname = |Redd|.
APPEND ls_user to lt_user.

Loop at lt_user ASSIGNING <user>.
  <user>-nname = |Konstanz|.
* je change la valeur du user ( 1 ligne du tableau) quand je loupe au lieu d'utiliser modify et de se faire chier avec des key.
*  il faudrait filtrer ensuite pour qu'il ne change pas ts les noms de famille.
*  es ist möglich während eines Loops der aktuellen Zeile der Tabelle ein Feldsymbol zuzuordnen.
*  Damit können die Daten der Zeile direkt verändert werden.

  ENDLOOP.
