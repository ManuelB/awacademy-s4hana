*&---------------------------------------------------------------------*
*& Include          Z_DEMO_INCLUDE_GRUPPEF01
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK 001 WITH FRAME TITLE text-001.
  PARAMETERS:

  p_artkl type ZGRP03_sweets-artikelnummer.

  update ZGRP03_sweets set activeflag = '0'
where artikelnummer = p_artkl and activeflag = 'X'.

SELECTION-SCREEN END OF BLOCK 001.
