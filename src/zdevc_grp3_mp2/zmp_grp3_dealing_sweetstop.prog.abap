*&---------------------------------------------------------------------*
*& Include ZMP_GRP3_DEALING_SWEETSTOP              - Module Pool      ZMP_GRP3_DEALING_SWEETS
*&---------------------------------------------------------------------*
PROGRAM zmp_grp3_dealing_sweets MESSAGE-ID zmsg_grp3.

TABLES : zgrp3_sweets, zgrp3_bestand,zgrp3_bewegungen, zgrp3_filstamm.

DATA grp3_fs TYPE TABLE OF  zgrp3_filstamm.
DATA: lt_filiale TYPE zgrp3_filstamm.


**********************************************************************
CLASS lcl_sweets DEFINITION.
  PUBLIC SECTION.

    METHODS:
      articlelist
        IMPORTING
          im_artnr TYPE zg03_artikelnummer
          im_artgr TYPE zg03_artikelgruppe,

*        EXCEPTIONS
*          no_group,

      delistarticle
        IMPORTING
          im_artnr TYPE zg03_artikelnummer,

      newarticleprice
        IMPORTING
          im_artnr TYPE zg03_artikelnummer
          im_preis TYPE zg03_vkbrutto.

    DATA waren_bestandlist TYPE zgrp3_sweets.

  PRIVATE SECTION.

    DATA  sweets TYPE zgrp3_sweets.

ENDCLASS.

CLASS lcl_filiale DEFINITION.
  PUBLIC SECTION.

    METHODS:
      new_Branch
        IMPORTING
          im_filname TYPE zg03_filialbezeichnung
        EXPORTING
          ex_filnr   TYPE zg03_filialnummer
          ex_ort     TYPE ad_city1
          ex_strasse TYPE ad_street
          ex_plz     TYPE ad_pstcd1
          ex_tel     TYPE ad_tlnmbr1


        EXCEPTIONS
          error,


      branch_maintenance
        IMPORTING
          im_filnr   TYPE zg03_filialnummer
          im_filname TYPE zg03_filialbezeichnung
          im_ort     TYPE ad_city1
          im_strasse TYPE ad_street
          im_plz     TYPE ad_pstcd1
          im_tel     TYPE ad_tlnmbr1
          im_user    TYPE syst_uname
          im_datum   TYPE dats.

*
*      BESTANDSLISTE
*        IMPORTING
*          im_filnr TYPE ZG03_FILIALNUMMER
*          im_artnr TYPE ZG03_ARTIKELNUMMER.
**        EXCEPTIONS
**          bestand_succ.
*
*DATA: wa TYPE TABLE of ZGRP3_Filstamm.

ENDCLASS.

CLASS cx_falsche_menge DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.

CLASS cx_min_best DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.

CLASS cx_max_best DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.

CLASS lcl_umlagerung DEFINITION.
  PUBLIC SECTION.
    EVENTS:
      reloc_succ
        EXPORTING
          VALUE(artnr)    TYPE zg03_artikelnummer
          VALUE(filnr1)   TYPE zg03_filialnummer
          VALUE(lager_b1) TYPE menge_d
          VALUE(filnr2)   TYPE zg03_filialnummer
          VALUE(lager_b2) TYPE menge_d
          VALUE(filnr3)   TYPE zg03_filialnummer
          VALUE(lager_b3) TYPE menge_d.

    METHODS:
      umlagern_zugang
        IMPORTING
          im_artnr  TYPE zg03_artikelnummer
          im_filnr1 TYPE zg03_filialnummer
          im_menge1 TYPE menge_d
          im_filnr2 TYPE zg03_filialnummer
          im_menge2 TYPE menge_d
          im_filnr3 TYPE zg03_filialnummer
          im_menge3 TYPE menge_d

        RAISING
          cx_min_best
          cx_max_best
          cx_falsche_menge,

      umlagern_abgang
        IMPORTING
          im_artnr  TYPE zg03_artikelnummer
          im_filnr1 TYPE zg03_filialnummer
          im_menge1 TYPE menge_d
          im_filnr2 TYPE zg03_filialnummer
          im_menge2 TYPE menge_d
          im_filnr3 TYPE zg03_filialnummer
          im_menge3 TYPE menge_d

        RAISING
          cx_min_best
          cx_max_best
          cx_falsche_menge.

  PRIVATE SECTION.
    METHODS:
      get_unit_for_article
        IMPORTING
                  im_artnr       TYPE zg03_artikelnummer
        RETURNING VALUE(re_unit) TYPE  meins.

ENDCLASS.

CLASS lcl_reloc_succ_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: on_reloc_succ FOR EVENT reloc_succ OF lcl_umlagerung
      IMPORTING
        artnr
        filnr1
        lager_b1
        filnr2
        lager_b2
        filnr3
        lager_b3
        sender.

ENDCLASS.
