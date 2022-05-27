*&---------------------------------------------------------------------*
*& Report Z_GRP03_DELISTARTICEL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_GRP3_DELISTARTICEL.

*TABLES: ZS05_MINIDEMO,
*  ZGRP03_SWEETS.
*SELECT * INTO ZS05_MINIDEMO FROM ZGRP03_SWEETS. endselect.
*
*DATA neue_preis type P LENGTH 7 decimals 2.
*
*PARAMETERS:
*p_art TYPE ZS05_MINIDEMO-artikelnummer,
*p_preis TYPE P LENGTH 7 decimals 2.
*
*
**ZS05_MINIDEMO-vk_brutto
*UPDATE ZS05_MINIDEMO set vk_brutto = p_preis where artikelnummer EQ p_art.
