*&---------------------------------------------------------------------*
*& Report Z_S09_FELDSYMBOLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_FELDSYMBOLE.

INCLUDE TYPE

TYPES: BEGIN OF lty_spfli,
         cityto(40) TYPE c,
         cityfrom(40) TYPE c,
       END OF lty_user.

DATA ls_spfli TYPE lty_spfli.


FIELD-SYMBOLS <CITYTO> TYPE spfli.
FIELD-SYMBOLS <user> TYPE spfli.


 LOOP AT lt_spfli ASSIGNING <CITYTO.
  <cityto> = 'Frankfurt'.
  ENDLOOP.
