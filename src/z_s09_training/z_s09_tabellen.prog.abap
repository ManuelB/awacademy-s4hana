*&---------------------------------------------------------------------*
*& Report Z_S09_TABELLEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_tabellen.

TYPES: BEGIN OF lty_s_user,
         vname(20) TYPE c,
         nname(20) TYPE c,
         alter     TYPE i,
         urlaub    TYPE i,
       END OF lty_s_user.

DATA ls_user TYPE lty_s_user.  "Local Struktur"

"Damit haben wir eine Struktur erstellt (ALLES)"

DATA lt_user TYPE TABLE OF lty_s_user. "lt_ weil Local Table/Tabelle)"
"DATA lt_user TYPE  STANDARD TABLE OF lty_s_user. "Equivalent"

"Ab hier wird die Tabelle befüllt"

ls_user-vname = |Max|.    "ls, local struktur"
ls_user-nname = |Mustermann|.
ls_user-alter = 66.

APPEND ls_user TO lt_user.

ls_user-vname = |Erika|.
ls_user-nname = |Sonnenschein|.
ls_user-alter = 47.

APPEND ls_user TO lt_user.

ls_user-vname = |Hans|.
ls_user-nname = |Imglück|.
ls_user-alter = 21.

APPEND ls_user TO lt_user.

ls_user-vname = |Paula|.
ls_user-nname = |Müller|.
ls_user-alter = 34.

APPEND ls_user TO lt_user.

ls_user-vname = |Michaela|.
ls_user-nname = |Schmidt|.
ls_user-alter = 28.

APPEND ls_user TO lt_user.

ls_user-vname = |Julia|.
ls_user-nname = |Schmidt|.
ls_user-alter = 35.

APPEND ls_user TO lt_user.

"Vorsicht, gleicher Datensatz TEST"
ls_user-vname = |Julia|.
ls_user-nname = |Schmidt|.
ls_user-alter = 35.

APPEND ls_user TO lt_user.

CLEAR: ls_user.

"Ab hier wird die Tabelle ausgelesen"

"LOOP AT lt_user INTO ls_user WHERE alter GE 35 AND ( urlaub LE 24 or name EQ 'Mustermann' )." Urlaub"

DATA lv_descr(13) TYPE c.

CLEAR: ls_user.

LOOP AT lt_user INTO ls_user.  "WHERE alter GE 35 AND ( urlaub LE 24 or nname EQ 'Mustermann' ).

  IF ls_user-alter GE 35.
    ls_user-urlaub = 32.
  ELSE.
    ls_user-urlaub = 30.
  ENDIF.

  MODIFY lt_user FROM ls_user INDEX sy-tabix.

  CLEAR ls_user.

  "Nach Dingen indem Fall Nachname sortieren folgender Befehl SORT lt_Variable BY nname "

  SORT lt_user BY nname DESCENDING alter DESCENDING. "DESCENDING heißt absteigend sortieren"
  "alter kam danach das geht auch parallel dann muss nur descending dahinter wieder gesetzt werden"

  DELETE ADJACENT DUPLICATES FROM lt_user. "Vorsicht, Tabelle vorher sortieren!"

  "Das löscht doppelte Einträge/ Datensätze/ Zeilen raus"

  "--------------------------------------"


  "Delete lt_user INDEX sy-tabix"

  READ TABLE lt_user INDEX sy-tabix INTO ls_user. "Transporting NO FIELD

  IF  sy-subrc <> 0.
    MESSAGE: |FEHLER bei Auslesen der Nutzerwerrte. RC:{ sy-subrc }| TYPE 'E'. "RC = Return Code"

  ENDIF.



  "Ausgabe der Benutzerdaten--------------------

  lv_descr = |Vorname:|.
  WRITE: / | { lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-vname ALIGN = LEFT } |.
  lv_descr = |Nachname:|.
  WRITE: / | { lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-nname ALIGN = LEFT } |.
  lv_descr = |Alter:|.
  WRITE: / | { lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-alter ALIGN = LEFT } |.
  lv_descr = |Urlaubstage:|.
  WRITE: / | { lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-urlaub ALIGN = LEFT } |.


  ULINE.


ENDLOOP.
