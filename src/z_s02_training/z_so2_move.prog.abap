*&---------------------------------------------------------------------*
*& Report Z_SO2_MOVE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_so2_move.


TYPES: BEGIN OF lty_user,
         id        TYPE i,
         vname(15) TYPE c,
         nname(15) TYPE c,
       END OF lty_user.

TYPES: BEGIN OF lty_user_age,
         vname(15) TYPE c,
         nname(15) TYPE c,
         dat       TYPE d,
       END OF lty_user_age.

DATA ls_user TYPE lty_user.
DATA lt_user TYPE TABLE OF lty_user.
DATA lt_user_move TYPE TABLE OF lty_user.

DATA lt_user_age TYPE TABLE OF lty_user_age.


ls_user-id    = 1.
ls_user-vname = 'Paul'.
ls_user-nname = 'Fischer'.
APPEND ls_user TO lt_user.

ls_user-id    = 2.
ls_user-vname = 'Mickey'.
ls_user-nname = 'Mouse'.
APPEND ls_user TO lt_user.


MOVE lt_user TO lt_user_move. "Mit MOVE werden die Daten aus aus einer internen Tabelle in eine andere interne Tabelle mit gleichem Format kopiert.lt_user nach lt_user_move kopiert. D.h.

MOVE-CORRESPONDING lt_user TO lt_user_age.  "Mit MOVE-CORRESPONDING werden die DAten kopiert mit demselben Spaltennamen. Andere werden ignoriert.

BREAK-POINT.
