*&---------------------------------------------------------------------*
*& Report Z_S05_ASSESS1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_ASSESS1.

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

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

  PARAMETERS:

    org_pr2  TYPE t_summe DEFAULT '145.78',
    rab_prz2 TYPE i DEFAULT '40'.

SELECTION-SCREEN END OF BLOCK b2.

PERFORM rabat USING org_pr1 rab_prz1 CHANGING reduz_preis1 rabat_summe1.
PERFORM rabat USING org_pr2 rab_prz2 CHANGING reduz_preis2 rabat_summe2.

IF org_pr1 LE 0 OR org_pr2 LE 0.
  WRITE: 'Fehler! Bitte geben Sie den korrekten Preis ein.' COLOR COL_NEGATIVE.
  ELSEIF rab_prz1 LE 0 OR rab_prz2 LE 0.
  WRITE: 'Fehler! Der Rabatt ist nicht erfolgreich. Bitte prüfen Sie den Eintrag.' COLOR COL_NEGATIVE.
ELSE.

  WRITE:
  / |Original-Preis:       { org_pr1 }EUR|,
  / |Rabatt-Prozentsatz:   { rab_prz1 }%|,
  / |Rabatt:               -{ rabat_summe1 }EUR|,
  /22 '=',
  / |Reduzierten Preis 1:    { reduz_preis1 }EUR|.
  skip.
  ULINE.

  WRITE:
    / |Original-Preis:       { org_pr2 }EUR|,
  / |Rabatt-Prozentsatz:   { rab_prz2 }%|,
  / |Rabatt:               -{ rabat_summe2 }EUR|,
  /22 '=',
  / |Reduzierten Preis 2:    { reduz_preis2 }EUR|.

ENDIF.


FORM rabat USING org_pr rab_prz CHANGING reduz_preis rabat_summe.
rabat_summe =  org_pr * (  rab_prz / 100 ) .
reduz_preis = org_pr - rabat_summe.




   ENDFORM.
