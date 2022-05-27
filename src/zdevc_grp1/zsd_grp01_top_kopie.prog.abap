*&---------------------------------------------------------------------*
*& Include ZSD_GRP1_DEALINGSWEETSTOP                - Modulpool        ZSD_GRP1_DEALINGSWEETS
*&---------------------------------------------------------------------*
PROGRAM zsd_grp1_dealingsweets MESSAGE-ID zmsg_grp1.

TABLES zsd_grp1_sw.

DATA: artnr     TYPE artnr,
      neupr     TYPE zsd_grp1_vkpreis,
      mnvkpreis TYPE ZSD_GRP1_mnVKPREIS.


CLASS lcl_mp1_grp1 DEFINITION.

  PUBLIC SECTION.
    METHODS:

      neuart,

      neupreis
        IMPORTING
          im_artnr TYPE artnr
          im_neupr TYPE zsd_grp1_vkpreis,

      warenbestand
        IMPORTING im_artgr TYPE cfartgr
        EXPORTING ex_bes   TYPE zsd_grp1_sw,

      auslisten
        IMPORTING im_artnr TYPE artnr.

    DATA: bestandsliste TYPE zsd_grp1_sw.



ENDCLASS.
