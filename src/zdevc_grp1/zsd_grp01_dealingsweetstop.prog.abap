*&---------------------------------------------------------------------*
*& Include ZSD_GRP1_DEALINGSWEETSTOP                - Modulpool        ZSD_GRP1_DEALINGSWEETS
*&---------------------------------------------------------------------*
PROGRAM zsd_grp1_dealingsweets MESSAGE-ID zmsg_grp1.

TABLES: t005,
        zsd_grp1_fs,
        zsd_GRP1_uml,
        zsd_GRP1_bes.
TYPES: lt TYPE zsd_grp1_uml.

DATA: artnr   TYPE artnr,
      grp1_fs TYPE TABLE OF zsd_grp1_fs.


**********************************************************************

CLASS lcl_mp1_grp1 DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS:
      neupreis
        IMPORTING
          im_artnr TYPE zsd_grp1_artnr
          im_neupr TYPE zsd_grp1_vkpreis,

      warenbestand
        IMPORTING im_artgr TYPE cfartgr,

      auslisten
        IMPORTING im_artnr TYPE artnr.

  PRIVATE SECTION.
ENDCLASS.


**********************************************************************

CLASS lcl_filiale DEFINITION.
  PUBLIC SECTION.
    METHODS:
      new_filiale
        IMPORTING
          im_filname TYPE zsd_grp1_fsna
        EXPORTING
          ex_filnr   TYPE zsd_grp1_fsnu
          ex_ort     TYPE ad_city1
          ex_strasse TYPE ad_street
          ex_plz     TYPE ad_pstcd1
          ex_tel     TYPE ad_tlnmbr1
        EXCEPTIONS
          invalid_telnr
          error,

      filial_suche
        IMPORTING
          im_filnr TYPE zsd_grp1_fsnu
        EXPORTING
          ls_num   TYPE zsd_grp1_fs,

      filiale_pflegen
        IMPORTING
          im_filnr   TYPE zsd_grp1_fsnu
          im_filname TYPE zsd_grp1_fsna
          im_ort     TYPE ad_city1
          im_strasse TYPE ad_street
          im_plz     TYPE ad_pstcd1
          im_tel     TYPE ad_tlnmbr1
          im_user    TYPE sy-uname
          im_datum   TYPE sy-datum
        EXCEPTIONS
          invalid_telnr,

      bestandsliste
        IMPORTING
          im_filnr TYPE zsd_grp1_fsnu
          im_artnr TYPE zsd_grp1_artnr
        EXCEPTIONS
          bestand_succ.

    DATA: wa TYPE TABLE OF zsd_grp1_fs.
  PRIVATE SECTION.
ENDCLASS.


**********************************************************************



CLASS lcl_umlagerung DEFINITION.
  PUBLIC SECTION.
    EVENTS:
      uml_succ.

    METHODS: uml_tab_bef
      IMPORTING
        i_fil_a      TYPE     lt-filialnr
        i_artnr1     TYPE     lt-artnr
        i_mengea     TYPE     lt-menge
        i_bwart      TYPE     lt-bwart
        i_filnr1     TYPE     lt-filialnr
        i_meng1      TYPE     lt-menge
        i_filnr2     TYPE     lt-filialnr
        i_meng2      TYPE     lt-menge
      EXPORTING
        ex_sollhaben TYPE lt-sollhaben
      EXCEPTIONS
        min_best
        max_best
        general_error
        menge_incons,
      relocc_succ FOR EVENT uml_succ OF lcl_umlagerung.

    DATA: lt_uml TYPE TABLE OF zsd_grp1_uml.
    DATA: ls_uml  TYPE zsd_grp1_uml,
          lv_fila TYPE zsd_grp1_bes,
          lv_fil1 TYPE zsd_grp1_bes,
          lv_fil2 TYPE zsd_grp1_bes,
          Filnr_a TYPE zsd_grp1_bes-filnr,
          Filnr_1 TYPE zsd_grp1_bes-filnr,
          Filnr_2 TYPE zsd_grp1_bes-filnr,
          Menge_a TYPE zsd_grp1_bes-akbes,
          Menge_1 TYPE zsd_grp1_bes-akbes,
          Menge_2 TYPE zsd_grp1_bes-akbes,
          akbes_a TYPE zsd_grp1_bes-akbes,
          akbes_1 TYPE zsd_grp1_bes-akbes,
          akbes_2 TYPE zsd_grp1_bes-akbes.
  PRIVATE SECTION.
ENDCLASS.
