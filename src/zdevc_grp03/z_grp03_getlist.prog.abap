*&---------------------------------------------------------------------*
*& Report Z_GRP03_GETLIST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_grp03_getlist.
*DATA p_artgrp TYPE string.

SELECTION-SCREEN BEGIN OF BLOCK 001 WITH FRAME.
  PARAMETERS:
 p_artgrp type ZGRP03_sweets-Artikelname.
SELECTION-SCREEN END OF BLOCK 001.


*SELECT Artikelname, Artikelnummer, AKTUELLER_LAGERBESTAND FROM zgrp03_sweets
SELECT * FROM zgrp03_sweets
  WHERE ARTIKELGRUPPE = @p_artgrp
    ORDER BY Artikelname, Artikelnummer, Artikelgruppe
INTO TABLE @DATA(Bestand).
cl_demo_output=>display( Bestand ).
