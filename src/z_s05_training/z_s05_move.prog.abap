*&---------------------------------------------------------------------*
*& Report Z_S05_MOVE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_MOVE.

TYPES: BEGIN OF lty_user,
  id TYPE i,
  vname(15) TYPE c,
  nname(15) TYPE c,
   END OF lty_user.

   TYPES: BEGIN OF lty_user_age,
  vname(15) TYPE c,
  nname(15) TYPE c,
  dat TYPE d,
   END OF lty_user_age.

   DATA ls_user type lty_user.
   DATA lt_user TYPE TABLE OF lty_user.
   DATA lt_user_move TYPE TABLE OF lty_user.
   DATA lt_user_age TYPE TABLE OF lty_user_age.


   ls_user-id = 1.
   ls_user-vname = 'Paul'.
   ls_user-nname = 'Fischer'.
   APPEND ls_user TO lt_user.

   ls_user-id = 2.
   ls_user-vname = 'Max'.
   ls_user-nname = 'Mustermann'.
   APPEND ls_user TO lt_user.

*Daten werden von einer interne Tabelle in eine andere interne Tabelle mit gleichem Format kopiert.
MOVE lt_user TO lt_user_move.

*Daten Namensgleicher Spalten werden kopiert.
MOVE-CORRESPONDING lt_user TO lt_user_age.

BREAK-POINT.
