*&---------------------------------------------------------------------*
*& Report Z_S01_MOVE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_move.

*Verstanden.

*Kann inhalte und Variablen von Tabellen in andere Tabellen verschrieben.
*Auch möglich, wenn nicht gleiche Spalte. Bedingung: Gleiche Attribute.

*Erstellung von Strukturtyp.
TYPES:
  BEGIN OF lty_user,
    id         TYPE i,
    vnname(20) TYPE c,
    nname(20)  TYPE c,

  END OF lty_user.

  TYPES:
  BEGIN OF lty_user2,

    vnname(20) TYPE c,
    nname(20)  TYPE c,
    datum TYPE d,

  END OF lty_user2.

*Typsierung & Deklaration von Strukturen.
DATA ls_user TYPE lty_user.
DATA lt_user TYPE TABLE OF lty_user. "Deklariert die 1. Tabelle
DATA lt_user_move TYPE TABLE OF lty_user. "Dekl 2. Tabelle
DATA lt_user_age TYPE TABLE OF lty_user2.

*Eingabe Daten.
ls_user-id = 1.
ls_user-nname = |Hrost|.
ls_user-vnname = |Krause|.
APPEND ls_user to lt_user.

ls_user-id = 2.
ls_user-nname = |Albert|.
ls_user-vnname = |Zeller|.
APPEND ls_user to lt_user.


move lt_user to lt_user_move. " Kopiert Daten aus lt_user in lt_user_move.
"In nächste Zeile müsste der Eintrag in der alten Tabelle gelöscht werden.

MOVE-CORRESPONDING lt_user to lt_user_age.
*kopiert die Spalten, die Namensgleich sind. Dh. Das besondere daran ist, dass zwei verschiedene Strukturen typen haben.


BREAK-POINT.
