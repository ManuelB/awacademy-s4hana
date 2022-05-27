*&---------------------------------------------------------------------*
*& Modulpool        Z_S05_INLUDE_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE z_s05_include_demotop                   .    " Global Data

* INCLUDE Z_S05_INCLUDE_DEMOO01                   .  " PBO-Modules
* INCLUDE Z_S05_INCLUDE_DEMOI01                   .  " PAI-Modules
* INCLUDE Z_S05_INCLUDE_DEMOF01                   .  " FORM-Routines


*SELECTION-SCREEN BEGIN OF SCREEN 1100.
*
*  PARAMETERS:
*    P_ARTNR TYPE ZS05_MINIDEMO-artikelnummer MODIF ID SC1,
*    P_ARTGRP TYPE c,
*    P_VK_B   TYPE c.
*
*SELECTION-SCREEN END OF SCREEN 1100.
*
*AT SELECTION-SCREEN OUTPUT.
*
*  LOOP AT SCREEN.
*
*    CASE sy-tcode.
*
********** transaction für neu preis ausführen*******
*
*      WHEN 'Z_S05_GRDEM2'.
*        IF screen-name = 'P_ARTNR'. "AND screen-name = p_vk_b.
*screen-intensified = 0.
*
**      IF    screen_wa-group1 = 'BL2'.
**screen_wa-active = '0'.
*
**          REPLACE 'P_ARTNR' IN P_ARTNR WITH '´      '.
*        MODIFY SCREEN.
* ENDIF.
*    ENDCASE.
*
*  ENDLOOP.
