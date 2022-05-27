*&---------------------------------------------------------------------*
*& Report Z_GRP03_DEAKTIVIEREN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_GRP3_DEAKTIVIEREN.

SELECTION-SCREEN BEGIN OF BLOCK 001 WITH FRAME TITLE text-001.
  PARAMETERS:

  p_artnr type ZGRP3_sweets-ARTIKELNUMMER.

SELECTION-SCREEN END OF BLOCK 001.


update ZGRP3_sweets set activeflag = '0'
where ARTIKELNUMMER = p_artnr and activeflag = 'X'.
