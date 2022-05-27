*&---------------------------------------------------------------------*
*& Report Z_S11_MOVE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_move.

TYPES : BEGIN OF lty_user,
          id           TYPE i,
          vname(15)    TYPE c,
          nname(15) TYPE c,
        END OF lty_user.

TYPES : BEGIN OF lty_user_age,
          name(15)   TYPE c,
          nname(15) TYPE c,
          dat          TYPE d,
        END OF lty_user_age.

DATA ls_user TYPE lty_user.
DATA lt_user TYPE TABLE OF lty_user.
DATA lt_user_move TYPE TABLE OF lty_user.

Data lt_user_age TYPE TABLE OF lty_user_age.


ls_user-id = 1.
ls_user-vname = 'Paul'.
ls_user-nname = 'Fischer'.
APPEND ls_user TO lt_user.

ls_user-id = 2.
ls_user-vname = 'Max'.
ls_user-nname = 'Musterman'.
APPEND ls_user TO lt_user.

*Daten werden von einer intern Tabelle in eine andere intern Tabelle mit gleichem Format kopiert
MOVE lt_user TO lt_user_move.

MOVE-CORRESPONDING lt_user to lt_user_age.

BREAK-POINT.
