*&---------------------------------------------------------------------*
*& Report Z_S05_DEMO_TRANGRUPPE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_DEMO_TRANGRUPPE.

   selection-screen BEGIN OF BLOCK 001 WITH FRAME TITLE text-001.
  PARAMETERS:

  p_artkl type ZGRP03_sweets-artikelnummer.

SELECTION-SCREEN END OF BLOCK 001.


update ZGRP03_sweets set activeflag = '0'
where artikelnummer = p_artkl and activeflag = 'X'.
