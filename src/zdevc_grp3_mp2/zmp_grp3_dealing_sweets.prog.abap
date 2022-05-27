*&---------------------------------------------------------------------*
*& Module Pool      ZMP_GRP3_DEALING_SWEETS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*Schematische Darstellung für Programmaufbau.
*
*Hauptprogramm (Modulpool)
*      Include *TOP - Datendeklaration / Definition der lokalen Klassen/Methoden
*      Include *F01 - Implementierung der Funktionalität für die definierten Methoden
*Instantiierung der Klassen/Methoden für eigentliche Funktionalität

INCLUDE zmp_grp3_dealing_sweetstop.
INCLUDE zmp_grp3_dealing_sweetsf01.
INCLUDE zmp_grp3_dealing_sweets_stao02.


**********************************************************************
*Selection Screen für MP1
SELECTION-SCREEN BEGIN OF SCREEN 1100.

  PARAMETERS:
    p_artnr  TYPE zgrp3_sweets-artikelnummer,
    p_artgrp TYPE zgrp3_sweets-artikelgruppe,
    p_vk_b   TYPE zgrp3_sweets-vk_brutto.

SELECTION-SCREEN END OF SCREEN 1100.


**********************************************************************
*Selection Screen für Filalanlegung


SELECTION-SCREEN BEGIN OF SCREEN 2000 TITLE TEXT-200.
  SELECTION-SCREEN BEGIN OF BLOCK b WITH FRAME.
    PARAMETERS: p_filnr TYPE zg03_filialnummer,
                p_filna TYPE zg03_filialbezeichnung OBLIGATORY,
                p_ort   TYPE ad_city1 OBLIGATORY,
                p_stras TYPE ad_street OBLIGATORY,
                p_plz   TYPE ad_pstcd1 OBLIGATORY VALUE CHECK,
                p_tel   TYPE ad_tlnmbr1 OBLIGATORY VALUE CHECK.
  SELECTION-SCREEN END OF BLOCK b.
SELECTION-SCREEN END OF SCREEN 2000.

**********************************************************************
*Selection Screen für Umlagerung
SELECTION-SCREEN BEGIN OF SCREEN 3000 TITLE TEXT-300.
  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-310.
    PARAMETERS: p_filnr1 TYPE zg03_filialnummer OBLIGATORY,
                p_artnr1 TYPE zgrp3_sweets-artikelnummer,
                p_menge1 TYPE menge_d,
                p_bwart  TYPE zg03_bewegungsart DEFAULT 106.
  SELECTION-SCREEN END OF BLOCK b1.
  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-320.
    PARAMETERS: p_filnr2 TYPE zg03_filialnummer,
                p_menge2 TYPE menge_d.
  SELECTION-SCREEN END OF BLOCK b2.
  SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-330.
    PARAMETERS: p_filnr3 TYPE zg03_filialnummer,
                p_menge3 TYPE menge_d.
  SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN END OF SCREEN 3000.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    CASE sy-tcode.

********* transaction für neu preis ausführen*******

      WHEN 'ZSD_GR03_NEWARTPRICE'.
        IF screen-name = 'P_ARTGRP' OR screen-name = '%_P_ARTGRP_%_APP_%-TEXT'.
          screen-active = 0.
          screen-invisible = 1.
        ENDIF.

        MODIFY SCREEN.

********* transaction für warenbestandliste ausführen*******

      WHEN 'ZSD_GR03_GETLIST'.
        IF screen-name = 'P_VK_B' OR screen-name = '%_P_VK_B_%_APP_%-TEXT'.
          screen-active = 0.
          screen-invisible = 1.
        ENDIF.

        IF screen-name = 'P_ARTNR' OR screen-name = '%_P_ARTNR_%_APP_%-TEXT'.
          screen-active = 0.
          screen-invisible = 1.
        ENDIF.
        MODIFY SCREEN.

********* transaction für DATENSATZ DEAKTIVIEREN ausführen*******

      WHEN 'ZSD_GR03_DELIST_ART'.
        IF screen-name = 'P_VK_B' OR screen-name = '%_P_VK_B_%_APP_%-TEXT'.
          screen-active = 0.
          screen-invisible = 1.
        ENDIF.

        IF screen-name = 'P_ARTGRP' OR screen-name = '%_P_ARTGRP_%_APP_%-TEXT'.
          screen-active = 0.
          screen-invisible = 1.

        ENDIF.
        MODIFY SCREEN.

********* transaction für neue Filiale anlegen *********

      WHEN 'ZSD_GRP03_NEW_BRANCH'.

        IF screen-name = 'P_FILNR' OR screen-name = '%_P_FILNR_%_APP_%-TEXT'.

          screen-active = 0.
          screen-invisible = 1.

        ENDIF.
        MODIFY SCREEN.

********* transaction für Filiale pflegen *********


********* transaction für Umlagerung *********
      WHEN 'ZGRP3_MOVE'.
*--- do nothing

      WHEN OTHERS.
        BREAK-POINT.
        MODIFY SCREEN.
    ENDCASE.
  ENDLOOP.

********* At Sselection-screen *********

AT SELECTION-SCREEN.

  DATA(lo_sweets) = NEW lcl_sweets( ).
  DATA(lo_filiale) = NEW lcl_filiale( ).
  DATA(lo_umlagerung) = NEW lcl_umlagerung( ).
  SET HANDLER lcl_reloc_succ_handler=>on_reloc_succ FOR lo_umlagerung.

********* ZSD_GR03_NEWARTPRICE *********
  CASE sy-tcode.
    WHEN 'ZSD_GR03_NEWARTPRICE'.
      lo_sweets->newarticleprice(
        EXPORTING
          im_artnr = p_artnr
          im_preis = p_vk_b
      ).

********* ZSD_GR03_GETLIST *********

    WHEN 'ZSD_GR03_GETLIST'.
      lo_sweets->articlelist(
        EXPORTING
          im_artnr = p_artnr
          im_artgr = p_artgrp
      ).

        WHEN 'ZSD_GR03_DELIST_ART'.
      lo_sweets->delistarticle(
        EXPORTING
          im_artnr   = p_artnr
          ).


********* ZSD_GR03_NEW_BRANCH *********

    WHEN 'ZSD_GRP03_NEW_BRANCH'.

      lo_filiale->new_branch(
EXPORTING
        im_filname = p_filna
      IMPORTING
        ex_filnr   = p_filnr
        ex_ort     = p_ort
        ex_strasse = p_stras
        ex_plz     = p_plz
        ex_tel     = p_tel
      EXCEPTIONS
        error   = 1
        OTHERS     = 2
    ).
      CASE sy-subrc.
        WHEN 0.
          COMMIT WORK.
          MESSAGE 'Die neue Filiale wurde erfolgreich angelegt!' TYPE 'I'.
        WHEN 1.
          MESSAGE e016.
        WHEN 2.
          MESSAGE e016.
        WHEN OTHERS.
          MESSAGE e016.
      ENDCASE.

********* ZSD_GR03_MOVE *********

    WHEN 'ZGRP3_MOVE'.

      TRY.
          IF p_bwart = '105'.
            lo_umlagerung->umlagern_zugang(
            EXPORTING
              im_artnr = p_artnr1
              im_filnr1 = p_filnr1
              im_menge1 = p_menge1
              im_filnr2 = p_filnr2
              im_menge2 = p_menge2
              im_filnr3 = p_filnr3
              im_menge3 = p_menge3
            ).
          ELSE.
            lo_umlagerung->umlagern_abgang(
            EXPORTING
              im_artnr = p_artnr1
              im_filnr1 = p_filnr1
              im_menge1 = p_menge1
              im_filnr2 = p_filnr2
              im_menge2 = p_menge2
              im_filnr3 = p_filnr3
              im_menge3 = p_menge3
            ).
          ENDIF.
        CATCH cx_falsche_menge.
          MESSAGE e017.
        CATCH cx_min_best.
          MESSAGE e018.
        CATCH cx_max_best.
          MESSAGE e019.
      ENDTRY.

  ENDCASE.

********* ZSD_GR03_Filchange *********

MODULE user_command_2005 INPUT.

  DATA(lo_filiale) = NEW lcl_filiale( ).

  CASE sy-ucomm.

    WHEN 'SHOW'.
      CALL SCREEN 2010.
    WHEN 'BACK'.
*      set SCREEN 2005.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.

MODULE user_command_2010 INPUT.

  CASE sy-ucomm.

    WHEN 'UPDATE'.

      lo_filiale->branch_maintenance(
        EXPORTING
          im_filnr =  zgrp3_filstamm-filialnummer
          im_filname = zgrp3_filstamm-filialbezeichnung
          im_ort     = zgrp3_filstamm-ort
          im_strasse = zgrp3_filstamm-strasse
          im_plz     = zgrp3_filstamm-plz
          im_tel     = zgrp3_filstamm-telefon
          im_user    = sy-uname
          im_datum   = sy-datum
      ).
      SET SCREEN 2005.


    WHEN 'BACK'.

      SET SCREEN 2005.

  ENDCASE.

ENDMODULE.
