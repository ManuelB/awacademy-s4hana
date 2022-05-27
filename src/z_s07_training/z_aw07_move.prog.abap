*&---------------------------------------------------------------------*
*& Report Z_AW07_MOVE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_MOVE.

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



ls_user-id    = 1.
ls_user-vname = 'Paul'.
ls_user-nname = 'Fischer'.
APPEND ls_user to lt_user.

ls_user-id    = 2.
ls_user-vname = 'Max'.
ls_user-nname = 'Mustermann'.
APPEND ls_user to lt_user.

BREAK-POINT.

*Daten werden von einer internen Tabelle zu einer anderen internen Tabelle mit gleichen format kopiert
Move lt_user to lt_user_move.

*Daten Namensgleicher Spalten werden kopiert
MOVE-CORRESPONDING lt_user to lt_user_age.


BREAK-POINT.
