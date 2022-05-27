*&---------------------------------------------------------------------*
*& Include          ZSD_GRP2_DEALINGSWEETSF01
*&---------------------------------------------------------------------*

CLASS lcl_miniprojekt IMPLEMENTATION.

*  METHOD such_methode.
**    im_artnr = p_artnr.  "such Parameter"
*    SELECT SINGLE * INTO  ex_stam
*      FROM zsd_grp2_arst
*      WHERE artikelnummer = im_artnr.
*
*  ENDMETHOD.



  METHOD auslisten.

*   CASE 'X'.
*  WHEN p_aus.
    SELECT SINGLE FOR UPDATE artikelnummer, activeflag, akt_lagerbestand, mindestbestand FROM zsd_grp2_arst
      WHERE artikelnummer = @im_artnr
      INTO @DATA(ls_artnr).
    IF sy-subrc = 0.
*
      IF ls_artnr-akt_lagerbestand > ls_artnr-mindestbestand.
        MESSAGE e002.
      ELSE.
        UPDATE zsd_grp2_arst SET activeflag = '-' WHERE artikelnummer = @im_artnr.
        MESSAGE s007 WITH ls_artnr-artikelnummer.
      ENDIF.
    ELSE.
      MESSAGE e008.
    ENDIF.
*
*    WHEN p_ein.
*    SELECT SINGLE FOR UPDATE artikelnummer, activeflag FROM zsd_grp2_arst
*    WHERE artikelnummer = @p_artnr
*    INTO @DATA(ls_artnr1).
*    if sy-subrc = 0.
*    UPDATE zsd_grp2_arst SET activeflag = 'X' WHERE artikelnummer = p_artnr.
*    MESSAGE |Der Artikel ist erfolgreich eingelistet!| TYPE 'S'.
*    else.
*
*  MESSAGE |Der Artikel ist nicht vorhanden!| TYPE 'E'.
*
*    ENDIF.
*    ENDCASE.


  ENDMETHOD.

*  METHOD vkchange.
**    im_artnr_v = p_artnr.  "Suchparameter Artikelnummer
**    im_vkcha = p_neupr.  "Eingabeparameter neuer Verkaufspreis
*
*    SELECT SINGLE FOR UPDATE artikelnummer, vp_brutto, mvp_brutto FROM zsd_grp2_arst
*    WHERE artikelnummer = @im_anr_v
*    INTO @DATA(preisaenderung).
*
*    IF im_vkcha <= preisaenderung-vp_brutto * '1.25'.
*      UPDATE zsd_grp2_arst SET vp_brutto = im_vkcha WHERE artikelnummer = im_anr_v.
*
*      IF sy-subrc = 0.
*        COMMIT WORK.
*        MESSAGE s005 WITH preisaenderung-artikelnummer im_vkcha.
*      ELSE.
*        ROLLBACK WORK.
*        MESSAGE e001 WITH preisaenderung-artikelnummer im_vkcha.
*    endif.
*     "MESSAGE |Der Artikel ist nicht vorhanden!| TYPE 'E'.
*
*    ENDIF.
*
*  ENDMETHOD.

  METHOD vkchange.
*    im_artnr_v = p_artnr.  "Suchparameter Artikelnummer
*    im_vkcha = p_neupr.  "Eingabeparameter neuer Verkaufspreis


*hier nochmal drüber schauen.
    SELECT SINGLE FOR UPDATE artikelnummer, vp_brutto, mvp_brutto FROM zsd_grp2_arst
    WHERE artikelnummer = @im_anr_v
    INTO @DATA(preisaenderung).
    IF sy-subrc = 0.
      IF im_vkcha <= preisaenderung-vp_brutto * '1.25'.
        UPDATE zsd_grp2_arst SET vp_brutto = im_vkcha WHERE artikelnummer = im_anr_v.

        IF sy-subrc = 0.
          COMMIT WORK.
          MESSAGE s005 WITH preisaenderung-artikelnummer im_vkcha.
        ELSE.
          ROLLBACK WORK.
          MESSAGE e001 WITH preisaenderung-artikelnummer im_vkcha.
        ENDIF.
      ENDIF.

    ELSE.
      MESSAGE e008.
*    MESSAGE |Der Artikel ist nicht vorhanden!| TYPE 'E'.
    ENDIF.

  ENDMETHOD.


  METHOD waren_bst_liste.

    SELECT Artikelgruppe, Artikelnummer, akt_lagerbestand , vp_brutto FROM zsd_grp2_arst
      WHERE artikelgruppe = @im_artgruppe
      ORDER BY  artikelgruppe, artikelnummer, akt_lagerbestand, vp_brutto
    INTO TABLE @DATA(ex_stam2).

    IF sy-subrc <> 0.
      MESSAGE e006.
    ELSE.
      cl_demo_output=>display( ex_stam2 ).
    ENDIF.







  ENDMETHOD.
  METHOD neuartikel.

*     EXPORTING
*       ex_artnum TYPE z_artnr_grp2
*       ex_artnam TYPE Z_ART_NM_GRP2
*       ex_artgr type Z_ARTGRP_GRP2
*       ex_ekneto TYPE Z_BETRAG_GRP2
*       ex_mvp_bruto TYPE Z_NVP_BR_GRP2
*       ex_vpbruto TYPE Z_VP_BRUTTO_GRP2
*       ex_active TYPE BOOLEAN
*       ex_datum TYPE SDEMO_CREA_DATUM
*       ex_user TYPE MSSSAPUSER.

    DATA: ls_neuart TYPE zsd_grp2_arst,
          lt_neuart TYPE TABLE OF zsd_grp2_arst.

ex_artnum = 0021.
ex_artnam  = 'etwas'.
ex_artgr = 1.
ex_ekneto = 5.
ex_mvp_bruto = 6.
ex_vpbruto = 7.
ex_active = 'X'.


    ls_neuart-artikelnummer = ex_artnum.
    ls_neuart-artikelname = ex_artnam.
    ls_neuart-artikelgruppe = ex_artgr.
    ls_neuart-ek_netto = ex_ekneto.
    ls_neuart-mvp_brutto = ex_mvp_bruto.
    ls_neuart-vp_brutto = ex_vpbruto.
    ls_neuart-activeflag = ex_active.
    ls_neuart-dat_anlage = ex_datum.
    ls_neuart-user_name_anlage = ex_user.

    APPEND ls_neuart TO lt_neuart.

    cl_demo_output=>display( lt_neuart ).

endmethod.

endclass.
