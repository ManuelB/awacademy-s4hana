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
TABLES: zsd_grp2_arst,

        zsd_grp2_umlag, zsd_grp2_bes.
TYPES : tl TYPE zsd_grp2_umlag,
        bs TYPE zsd_grp2_bes.


CLASS lcl_miniprojekt DEFINITION.
  PUBLIC SECTION.


*    METHODS: such_methode
*      IMPORTING
*        im_artnr TYPE z_artnr_grp2
*      EXPORTING
*        ex_stam  TYPE zsd_grp2_arst.


    METHODS: auslisten
      IMPORTING
        im_artnr TYPE z_artnr_grp2.
*        im_artnr1 TYPE z_artnr_grp2.


    METHODS: waren_bst_liste
      IMPORTING
        im_artgruppe TYPE z_artgrp_grp2.

    METHODS: vkchange
      IMPORTING
*        ex_stam TYPE zsd_grp2_arst.
        im_anr_v TYPE z_artnr_grp2
        im_vkcha TYPE z_vp_brutto_grp2,

      neuartikel

        IMPORTING

          im_artnam    TYPE z_art_nm_grp2
          im_artgr     TYPE z_artgrp_grp2
          im_ekneto    TYPE z_betrag_grp2
          im_mvp_bruto TYPE z_nvp_br_grp2
          im_vpbruto   TYPE z_vp_brutto_grp2
          im_active    TYPE boolean
          im_wae       TYPE s_currcode
          im_datum     TYPE sdemo_crea_datum
          im_user      TYPE msssapuser
          im_fili      TYPE z_filnum
          im_mind      TYPE z_bestand_grp2
          im_max       TYPE z_maxbest_grp2
          im_lag       TYPE z_aktu_best_grp2
          im_meng      TYPE unit
        EXPORTING
          ex_artnum    TYPE z_artnr_grp2
          ex_artnum2   TYPE z_artnr_grp2.



ENDCLASS.

CLASS lcl_filiale DEFINITION.
  PUBLIC SECTION.
    METHODS:
    neuanlage
    IMPORTING
*   im_filnum type Z_FILNUM
     im_filbez TYPE z_filbez_grp2
     im_ort TYPE ad_city1
     im_str TYPE ad_street
     im_plz TYPE ad_pstcd1
     im_tel TYPE ad_tlnmbr1
     im_user TYPE syst_uname
     im_datum TYPE dats
     EXPORTING
     ex_filnum TYPE z_filnum,

    pflege
    IMPORTING
     im_filnum TYPE z_filnum
     im_filbez TYPE z_filbez_grp2
     im_ort TYPE ad_city1
     im_str TYPE ad_street
     im_plz TYPE ad_pstcd1
     im_tel TYPE ad_tlnmbr1
     im_user TYPE syst_uname
     im_datum TYPE dats.

*    clear_parameters
*    exporting
*  ex_filnu2 type z_filnum
*  ex_filbe2 type z_filbez_grp2
*  ex_ort2 type ad_city1
*  ex_str2 type ad_street
*  ex_plz2 type ad_pstcd1
*  ex_tel2 type ad_tlnmbr1.
  ENDCLASS.


*************************************class definition für Warenbewegung und Aktueller Lagerbestand Funktionalität




    CLASS lcl_umlagerung DEFINITION.
  PUBLIC SECTION.

    EVENTS : reloc_succ
      EXPORTING VALUE(art_nr) TYPE tl-artikel_nr
                VALUE(flnr1)  TYPE tl-filial_nr
                VALUE(bes1)   TYPE tl-menge
                VALUE(flnr2)  TYPE tl-filial_nr
                VALUE(bes2)   TYPE tl-menge
                VALUE(flnr3)  TYPE tl-filial_nr
                VALUE(bes3)   TYPE tl-menge.




    METHODS : fill_umlagerung_tbl
      IMPORTING im_flnr1  TYPE tl-filial_nr
                im_arl_nr TYPE tl-artikel_nr
                im_menge1 TYPE tl-menge
                im_bwgng  TYPE tl-bewegungsart
                im_flnr2  TYPE tl-filial_nr
                im_menge2 TYPE tl-menge
                im_flnr3  TYPE tl-filial_nr
                im_menge3 TYPE tl-menge,

      pruefen_menge
        IMPORTING
                  im_men1       TYPE tl-menge
                  im_men2       TYPE tl-menge
        RETURNING VALUE(re_men) TYPE tl-menge,

      update_bestand_tbl FOR EVENT reloc_succ OF  lcl_umlagerung
        IMPORTING art_nr
                  flnr1
                  bes1
                  flnr2
                  bes2
                  flnr3
                  bes3 .

ENDCLASS.
