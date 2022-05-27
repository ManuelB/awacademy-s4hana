*&---------------------------------------------------------------------*
*& Module Pool      ZMP_GRP03_DEALING_SWEETS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE ZMP2_GRP02_SWEETSTOP.
*INCLUDE zmp_grp03_dealing_sweetstop             .    " Global Data

*INCLUDE zmp_grp03_dealing_sweetso01             .  " PBO-Modules
*INCLUDE zmp_grp03_dealing_sweetsi01             .  " PAI-Modules
INCLUDE ZMP2_GRP02_SWEETSF01.
*INCLUDE zmp_grp03_dealing_sweetsf01             .  " FORM-Routines

TABLES : zgrp03_sweets.
SELECTION-SCREEN BEGIN OF SCREEN 1100.

  PARAMETERS:
    p_artnr  TYPE zgrp03_sweets-artikelnummer,
    p_artgrp TYPE zgrp03_sweets-artikelgruppe,
    p_vk_b   TYPE zgrp03_sweets-vk_brutto.

SELECTION-SCREEN END OF SCREEN 1100.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    CASE sy-tcode.

********* transaction für neu preis ausführen*******

      WHEN 'ZGRP03_NEWARTPRICE'.
        IF screen-name = 'P_ARTGRP' OR screen-name = '%_P_ARTGRP_%_APP_%-TEXT'.
          screen-active = 0.
          screen-invisible = 1.
        ENDIF.

        MODIFY SCREEN.
*        *

********* transaction für warenbestandliste ausführen*******

      WHEN 'ZGRP03_GETLIST'.
        IF screen-name = 'P_VK_B' OR screen-name = '%_P_VK_B_%_APP_%-TEXT'.
          screen-active = 0.
          screen-invisible = 1.
        ENDIF.

*          IF screen-name = 'P_ARTNR' OR screen-name = '%_P_ARTNR_%_APP_%-TEXT'.
*          screen-active = 0.
*          screen-invisible = 1.
*        ENDIF.
        MODIFY SCREEN.


********* transaction für DATENSATZ DEAKTIVIEREN ausführen*******

      WHEN 'ZGRP03_DELIST_ARTICL'.
        IF screen-name = 'P_VK_B' OR screen-name = '%_P_VK_B_%_APP_%-TEXT'.
          screen-active = 0.
          screen-invisible = 1.
        ENDIF.

        IF screen-name = 'P_ARTGRP' OR screen-name = '%_P_ARTGRP_%_APP_%-TEXT'.
          screen-active = 0.
          screen-invisible = 1.
        ENDIF.

        MODIFY SCREEN.

    ENDCASE.

  ENDLOOP.

AT SELECTION-SCREEN.
*  DATA lo_sweets TYPE REF TO lcl_sweets.
  DATA(lo_sweets) = NEW lcl_sweets( ).


  CASE sy-tcode.
    WHEN 'ZGRP03_NEWARTPRICE'.
      lo_sweets->newarticleprice(
        EXPORTING
          im_artnr = p_artnr
          im_preis = p_vk_b
      ).

*      lo_sweets->articlelist(
*        EXPORTING
*          im_artnr   = p_artnr
*          IMPORTING
*            ex_tabelle = lo_sweets->waren_bestandlist
*      ).
*      cl_demo_output=>display( lo_sweets->waren_bestandlist ).

    WHEN 'ZGRP03_GETLIST'.
      lo_sweets->articlelist(
        EXPORTING
          im_artnr   = p_artnr
          im_artgr = p_artgrp
                ).
*          IMPORTING
*            ex_list = lo_sweets->waren_bestandlist
*      ).
*      cl_demo_output=>display( lo_sweets->waren_bestandlist ).

      lo_sweets->articlelist(
             EXPORTING
               im_artnr   = p_artnr
               im_artgr = p_artgrp
                     ).
*          IMPORTING
*            ex_list = lo_sweets->waren_bestandlist
*      ).
*      cl_demo_output=>display( lo_sweets->waren_bestandlist ).

    WHEN 'ZGRP03_DELIST_ARTICL'.
      lo_sweets->delistarticle(
        EXPORTING
          im_artnr   = p_artnr
          ).



  ENDCASE.
*  BREAK-POINT.
