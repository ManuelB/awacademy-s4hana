*&---------------------------------------------------------------------*
*& Include ZSD_GRP2_DEALINGSWEETSTOP                - Modulpool        ZSD_DEALINGSWEETS
*&---------------------------------------------------------------------*
PROGRAM zsd_dealingsweets MESSAGE-ID zmsg_grp2.
*auslisten eines Artikel = aus dem Sortiment nehmen - über Eingabeparameter zum auslessen - über ARTNR
*selection über die datenbank tabele - selectierten zeilen die variáble aktive flag auf X(bedeuten ja) geben
*es gebe noch abap_true und abap_false (daten aus tabele in die interne tabele legen)

DATA: gs_artikel           TYPE zsd_grp2_arst,
      g_warenbestandsliste TYPE zsd_grp2_arst,
      artikelnummer        TYPE zsd_grp1_artnr.



CLASS lcl_miniprojekt DEFINITION.
  PUBLIC SECTION.

*    METHODS: such_methode
*      IMPORTING
*        im_artnr TYPE z_artnr_grp2
*      EXPORTING
*        ex_stam  TYPE zsd_grp2_arst.


    METHODS: auslisten
      IMPORTING
        im_artnr TYPE z_artnr_grp2,
*        im_artnr1 TYPE z_artnr_grp2.


     waren_bst_liste
      IMPORTING
       im_artgruppe TYPE z_artgrp_grp2,

     vkchange
      IMPORTING
*        ex_stam TYPE zsd_grp2_arst.
        im_anr_v TYPE z_artnr_grp2
        im_vkcha TYPE z_vp_brutto_grp2,

     neuartikel
     EXPORTING
       ex_artnum TYPE z_artnr_grp2
       ex_artnam TYPE Z_ART_NM_GRP2
       ex_artgr type Z_ARTGRP_GRP2
       ex_ekneto TYPE Z_BETRAG_GRP2
       ex_mvp_bruto TYPE Z_NVP_BR_GRP2
       ex_vpbruto TYPE Z_VP_BRUTTO_GRP2
       ex_active TYPE BOOLEAN
       ex_datum TYPE SDEMO_CREA_DATUM
       ex_user TYPE MSSSAPUSER.




ENDCLASS.
