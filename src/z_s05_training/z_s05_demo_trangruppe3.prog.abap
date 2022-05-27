*&---------------------------------------------------------------------*
*& Report Z_S05_DEMO_TRANGRUPPE3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_DEMO_TRANGRUPPE3.

*SELECTION-SCREEN BEGIN OF BLOCK 001 WITH FRAME.
*  PARAMETERS:
*
*  p_artkl type ZGRP03_sweets-artikelnummer,
*  p_preis type ZGRP03_sweets-vk_brutto.
*
*SELECTION-SCREEN END OF BLOCK 001.
*
*update ZGRP03_sweets set vk_brutto = p_preis
*where artikelnummer = p_artkl.

SELECTION-SCREEN begin OF block b1.

PARAMETERS p_art TYPE ZS05_minidemo-artikelnummer.
PARAMETERS p_price TYPE i.


SELECTION-SCREEN end OF block b1.



DATA lv_user TYPE sy-uname.

DATA lv_datum TYPE sy-datum.

lv_datum = sy-datum.

lv_user = sy-uname.


UPDATE ZS05_MINIDEMO
SET vk_brutto = @p_price,
 uname = @lv_user,
 datum = @lv_datum
 where artikelnummer = @p_art.
