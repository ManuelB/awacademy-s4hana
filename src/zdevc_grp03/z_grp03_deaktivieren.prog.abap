*&---------------------------------------------------------------------*
*& Report Z_GRP03_DEAKTIVIEREN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_GRP03_DEAKTIVIEREN.

SELECTION-SCREEN BEGIN OF BLOCK 001 WITH FRAME TITLE text-001.
  PARAMETERS:

  p_artnr type ZGRP03_sweets-artikelnummer.

SELECTION-SCREEN END OF BLOCK 001.


update ZGRP03_sweets set activeflag = '0'
where artikelnummer = p_artnr and activeflag = 'X'.
