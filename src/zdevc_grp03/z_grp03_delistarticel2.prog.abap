*&---------------------------------------------------------------------*
*& Report Z_GRP03_DELISTARTICEL2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_GRP03_DELISTARTICEL2.

DATA p_artname TYPE string.

SELECTION-SCREEN BEGIN OF BLOCK 001 WITH FRAME.
  PARAMETERS:
  p_artn type ZGRP03_sweets-Artikelname.

SELECTION-SCREEN END OF BLOCK 001.


SELECT Artikelname, Artikelnummer, AKTUELLER_LAGERBESTAND FROM zgrp03_sweets
  WHERE Activeflag = 'X'
  modify activeflag from  ZGRP03_sweets,
  ORDER BY Artikelname, Artikelnummer, Artikelgruppe
INTO TABLE @DATA(Bestand).
cl_demo_output=>display( Bestand ).
