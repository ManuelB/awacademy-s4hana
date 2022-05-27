*&---------------------------------------------------------------------*
*& Include ZMP_GRP03_DEALING_SWEETSTOP              - Module Pool      ZMP_GRP03_DEALING_SWEETS
*&---------------------------------------------------------------------*
PROGRAM zmp_grp03_dealing_sweets MESSAGE-ID zmsg_grp03.

CLASS lcl_sweets DEFINITION.
  PUBLIC SECTION.

    METHODS:
      articlelist
        IMPORTING
          im_artnr   TYPE zg03_artikelnummer
          im_artgr   TYPE zg03_artikelgruppe
*        EXPORTING
*          ex_tabelle TYPE zgrp03_sweets
        EXCEPTIONS
          no_group,

      delistarticle
        IMPORTING
          im_artnr TYPE zg03_artikelnummer,

*        EXPORTING
*          ex_delisttab TYPE zgrp03_sweets,


      newarticleprice
        IMPORTING
          im_artnr TYPE zg03_artikelnummer
          im_preis TYPE zg03_vkbrutto.

    DATA waren_bestandlist TYPE zgrp03_sweets.

  PRIVATE SECTION.

    DATA  sweets TYPE zgrp03_sweets.

ENDCLASS.

*allle data deklaration, def und imp lokale klasse
