*&---------------------------------------------------------------------*
*& Report Z_S03_TABELLEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s03_tabellen.

TYPES: BEGIN OF lty_s_user,
         vname(20) TYPE c,
         nname(20) TYPE c,
         alter     TYPE i,
         urlaub    TYPE i,
       END OF lty_s_user.

DATA ls_user TYPE lty_s_user.
DATA lt_user TYPE TABLE OF lty_s_user.

*befüllung der Tabelle
ls_user-vname = 'John'.
ls_user-nname = 'Rodd'.
ls_user-alter = 33.
APPEND ls_user TO lt_user.

ls_user-vname = 'Jana'.
ls_user-nname = 'Radd'.
ls_user-alter = 34.
APPEND ls_user TO lt_user.

ls_user-vname = 'Jini'.
ls_user-nname = 'Ridd'.
ls_user-alter = 35.
APPEND ls_user TO lt_user.

ls_user-vname = |Jen|.
ls_user-nname = |Redd|.
ls_user-alter = 36.
APPEND ls_user TO lt_user.

*  auslesen der Tabelle

CLEAR: ls_user.
* utile si on a une valeur vide avant, par ex l age pas rempli,
*pour que le tableau ne reprenne pas la valeur du user d'avant.


*SORT lt_user BY nname DESCENDING alter DESCENDING. Pas de difference sauf si plusieurs
*ont le meme nom  et ages differents.

*DELETE ADJACENT DUPLICATES FROM lt_user. Vorsicht, vorher Tabelle sortieren!

LOOP AT lt_user INTO ls_user.
*  WHERE alter GE 35 AND ( urlaub LE 24 or nname EQ 'Redd' 9.
*  On peut completer WHERE par AND ou OR
 IF ls_user-alter GE 35.
   ls_user-urlaub = 32.
   ELSE.
     ls_user-urlaub = 30.
     ENDIF.
     MODIFY lt_user from ls_user INDEX sy-tabix.

     CLEAR ls_user.

     READ TABLE lt_user INDEX sy-tabix INTO ls_user.
*     TRANSPORTING NO FIELDS.
     IF sy-subrc <> 0.
       MESSAGE: |Fehler bei Auslesen der Nutzerwerte.RC:{ sy-subrc }| TYPE 'E'.

       ENDIF.


   WRITE: / |Nachname: { ls_user-nname }|.
   WRITE: / |Urlaubstage: { ls_user-urlaub }|.

ENDLOOP.






*  BREAK-POINT.
