*&---------------------------------------------------------------------*
*& Modulpool        ZSD_GRP1_DEALINGSWEETS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
INCLUDE zsd_grp01_dealingsweetstop.
INCLUDE zsd_grp01_dealingsweetsf01.


**********************************************************************
*Selektion Screen MP1

SELECTION-SCREEN BEGIN OF SCREEN 1100 TITLE TEXT-100.
  PARAMETERS: p_artnr TYPE zsd_grp1_sw-artnr,
              p_neupr TYPE zsd_grp1_sw-vkpreis,
              p_artgr TYPE zsd_grp1_sw-artgr.
SELECTION-SCREEN END OF SCREEN 1100.

**********************************************************************
*Selektion Screen: Filiale Neu

SELECTION-SCREEN BEGIN OF SCREEN 1200 TITLE TEXT-200.
  SELECTION-SCREEN BEGIN OF BLOCK b WITH FRAME TITLE TEXT-201.
    PARAMETERS: p_filnr TYPE zsd_grp1_fsnu,
                p_filna TYPE zsd_grp1_fsna OBLIGATORY,
                p_ort   TYPE ad_city1 OBLIGATORY,
                p_stras TYPE ad_street OBLIGATORY,
                p_plz   TYPE ad_pstcd1 OBLIGATORY VALUE CHECK,
                p_tel   TYPE ad_tlnmbr1 OBLIGATORY VALUE CHECK.
    DATA:       lv_land TYPE t005-land1.
  SELECTION-SCREEN END OF BLOCK b.
SELECTION-SCREEN END OF SCREEN 1200.

**********************************************************************
*Selektion Screen: Umlagerung

SELECTION-SCREEN BEGIN OF SCREEN 1300 TITLE TEXT-300.
  SELECTION-SCREEN BEGIN OF BLOCK c1 WITH FRAME TITLE TEXT-301.
    PARAMETERS: p_fil_a  TYPE zsd_grp1_fsnu OBLIGATORY VALUE CHECK,
                p_artnr1 TYPE zsd_grp1_sw-artnr OBLIGATORY,
                p_mengea TYPE menge_d OBLIGATORY,
                p_bwart  TYPE bwart OBLIGATORY.
  SELECTION-SCREEN END OF BLOCK c1.
  SELECTION-SCREEN BEGIN OF BLOCK c2 WITH FRAME TITLE TEXT-302.
    PARAMETERS: p_filnr1 TYPE zsd_grp1_fsnu OBLIGATORY VALUE CHECK,
                p_meng1  TYPE menge_d OBLIGATORY VALUE CHECK.
  SELECTION-SCREEN END OF BLOCK c2.
  SELECTION-SCREEN BEGIN OF BLOCK c3 WITH FRAME TITLE TEXT-303.
    PARAMETERS: p_filnr2 TYPE zsd_grp1_fsnu,
                p_meng2  TYPE menge_d.
  SELECTION-SCREEN END OF BLOCK c3.
SELECTION-SCREEN END OF SCREEN 1300.


**********************************************************************

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    CASE sy-tcode.

      WHEN 'ZSD_GRP1_NEUPREIS'.

        IF screen-name = 'P_ARTGR' OR screen-name = '%_P_ARTGR_%_APP_%-TEXT'.
          screen-active = 0.
          screen-invisible = 1.
        ENDIF.
        MODIFY SCREEN.

      WHEN 'ZSD_GRP1_BESTAND'.

        IF screen-name = 'P_ARTNR' OR screen-name = '%_P_ARTNR_%_APP_%-TEXT'
          OR screen-name = 'P_NEUPR' OR screen-name = '%_P_NEUPR_%_APP_%-TEXT'.

          screen-active = 0.
          screen-invisible = 1.
        ENDIF.
        MODIFY SCREEN.

      WHEN 'ZSD_GRP1_AUSLISTEN'.

        IF screen-name = 'P_NEUPR' OR screen-name = '%_P_NEUPR_%_APP_%-TEXT'
          OR screen-name = 'P_ARTGR' OR screen-name = '%_P_ARTGR_%_APP_%-TEXT'.

          screen-active = 0.
          screen-invisible = 1.
        ENDIF.
        MODIFY SCREEN.

      WHEN 'ZSD_GRP1_FILNEU'.

        IF screen-name = 'P_FILNR' OR screen-name = '%_P_FILNR_%_APP_%-TEXT'.

          screen-active = 0.
          screen-invisible = 1.
        ENDIF.


        MODIFY SCREEN.

      WHEN 'ZSD_GRP1_UMLAGERUNG'.
        MODIFY SCREEN.

      WHEN OTHERS.

    ENDCASE.

  ENDLOOP.


**********************************************************************


AT SELECTION-SCREEN.

  DATA(lo_sweets) = NEW lcl_mp1_grp1( ).
  DATA(lo_filiale) = NEW lcl_filiale( ).
  DATA(lo_umlagern) = NEW lcl_umlagerung( ).

  CASE  sy-tcode.

    WHEN 'ZSD_GRP1_NEUPREIS'.
      lo_sweets->neupreis( EXPORTING im_artnr = p_artnr im_neupr = p_neupr ).

    WHEN 'ZSD_GRP1_BESTAND'.

      lo_sweets->warenbestand( EXPORTING im_artgr = p_artgr ).

    WHEN 'ZSD_GRP1_AUSLISTEN'.
      lo_sweets->auslisten( im_artnr = p_artnr ).

    WHEN 'ZSD_GRP1_FILNEU'.

      lo_filiale->new_filiale(
        EXPORTING
          im_filname = p_filna
        IMPORTING
          ex_filnr   = p_filnr
          ex_ort     = p_ort
          ex_strasse = p_stras
          ex_plz     = p_plz
          ex_tel     = p_tel
  EXCEPTIONS
    invalid_telnr = 1
*    error         = 2
    OTHERS        = 3
).
      CASE sy-subrc.
        WHEN 1.
          MESSAGE e017.
        WHEN 3.
          MESSAGE e008.
      ENDCASE.

      .

      CALL FUNCTION 'ADDR_POSTAL_CODE_CHECK'
        EXPORTING
          country                        = 'DE'
          postal_code_city               = p_plz
*         POSTAL_CODE_PO_BOX             = ' '
*         POSTAL_CODE_COMPANY            = ' '
*         PO_BOX                         = ' '
*         REGION                         = ' '
*         POSTAL_ADDRESS                  = 'p_stras' + 'p_ort' + 'lv_land'
*       IMPORTING
*         T005_WA                        =
*         T005_WA_PO_BOX                 =
        EXCEPTIONS
          country_not_valid              = 1
          region_not_valid               = 2
*         POSTAL_CODE_CITY_NOT_VALID     = 3
          postal_code_po_box_not_valid   = 4
          postal_code_company_not_valid  = 5
          po_box_missing                 = 6
          postal_code_po_box_missing     = 7
          postal_code_missing            = 8
          postal_code_pobox_comp_missing = 9
          po_box_region_not_valid        = 10
          po_box_country_not_valid       = 11
          pobox_and_poboxnum_filled      = 12
          OTHERS                         = 13.
      IF sy-subrc <> 0.
        MESSAGE e018 display like 'I'.
      ENDIF.



      CASE sy-subrc.
        WHEN 0.
          COMMIT WORK.
          MESSAGE s016.
        WHEN 1.
          MESSAGE e008.
        WHEN 2.
          MESSAGE e012.

        WHEN OTHERS.
          MESSAGE e012.
      ENDCASE.

    WHEN 'ZSD_GRP1_UMLAGERUNG'.
      lo_umlagern->uml_tab_bef(
        EXPORTING
          i_fil_a       = p_fil_a
          i_artnr1      = p_artnr1
          i_mengea      = p_mengea
          i_bwart       = p_bwart
          i_filnr1      = p_filnr1
          i_meng1       = p_meng1
          i_filnr2      = p_filnr2
          i_meng2       = p_meng2 ).

      CASE sy-subrc.
        WHEN 4.
          message |Warenmengen nicht übereinstimmend!| type 'E'.

        WHEN OTHERS.
      ENDCASE.
      IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*   WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.
    WHEN OTHERS.
  ENDCASE.


**********************************************************************
*Dynpros für Filiale ändern

MODULE user_command_1201 INPUT.
  DATA(lo_filiale) = NEW lcl_filiale( ).
  CASE sy-ucomm.

    WHEN 'SHOW'.
      lo_filiale->filial_suche(
        EXPORTING
          im_filnr = p_filnr
        IMPORTING
          ls_num   = zsd_grp1_fs ).

      IF zsd_grp1_fs IS INITIAL.
        CALL SCREEN 1205
        STARTING AT 10 5.
      ELSE.
        SET SCREEN 1202.
      ENDIF.

    WHEN 'BACK'.
      LEAVE PROGRAM.

  ENDCASE.
ENDMODULE.

MODULE status_1201 OUTPUT.
  SET PF-STATUS 'S1201'.
  SET TITLEBAR 'FILSEARCH'.
ENDMODULE.

MODULE status_1205 OUTPUT.
  SET PF-STATUS 'S1205'.
  SET TITLEBAR 'T1205'.
ENDMODULE.

MODULE user_command_1202 INPUT.
  CASE sy-ucomm.

    WHEN 'RETURN'.
      SET SCREEN 1201.

    WHEN 'CHANGE'.
      lo_filiale->filiale_pflegen(
        EXPORTING
          im_filnr   = p_filnr
          im_filname = p_filna
          im_ort     = p_ort
          im_strasse = p_stras
          im_plz     = p_plz
          im_tel     = p_tel
          im_user    = sy-uname
          im_datum   = sy-datum ).

    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

MODULE status_1202 OUTPUT.
  SET PF-STATUS 'S1202'.
  SET TITLEBAR 'FILCHANGE'.
ENDMODULE.
