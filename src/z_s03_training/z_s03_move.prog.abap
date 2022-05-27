*&---------------------------------------------------------------------*
*& Report Z_S03_MOVE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s03_move.

* Kann Inhalte  von Tabellen in andere schieben, solange sie den selben Typ haben. Müssen gleiche Spaltennamen haben.

TYPES: BEGIN OF lty_user,
         id        TYPE i,
         vname(15) TYPE c,
         nname(15) TYPE c,
       END OF lty_user.

       TYPES: BEGIN OF lty_user_age,
         vname(15) TYPE c,
         nname(15) TYPE c,
         dat TYPE d,
       END OF lty_user_age.

DATA ls_user TYPE lty_user.
DATA lt_user TYPE TABLE OF lty_user.
DATA lt_user_move TYPE TABLE OF lty_user.
DATA lt_user_age TYPE TABLE OF lty_user_age.

ls_user-id = 1.
ls_user-vname = |Jon|.
ls_user-nname = |Rodd|.
APPEND ls_user to lt_user.

ls_user-id = 2.
ls_user-vname = |Jen|.
ls_user-nname = |Redd|.
APPEND ls_user to lt_user.

MOVE lt_user to lt_user_move.

* quand les 2 tableaux sont pas equivalents totalement, on emploie move corresponding.
*Mais il copie que les colonnes qui ont le meme nom.

MOVE-CORRESPONDING lt_user to lt_user_age.

BREAK-POINT.
