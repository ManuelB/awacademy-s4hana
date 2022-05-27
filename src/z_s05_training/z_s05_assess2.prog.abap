*&---------------------------------------------------------------------*
*& Report Z_S05_ASSESS1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_ASSESS2.


TYPES:
  t_summe TYPE p LENGTH 6 DECIMALS 2.

DATA:
  reduz_preis1 TYPE t_summe,
  reduz_pr TYPE t_summe,
  rabat_summe1 TYPE t_summe,
  reduz_preis2 TYPE t_summe,
  rabat_summe2 TYPE t_summe.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  PARAMETERS:
   org_pr1  TYPE t_summe DEFAULT '218',
   rab_prz1 TYPE i DEFAULT '25'.

SELECTION-SCREEN END OF BLOCK b1.


   reduz_pr = ( org_pr1 - ( org_pr1 * ( (  rab_prz1 / 100 )  ) ) ).
   write: reduz_pr.
