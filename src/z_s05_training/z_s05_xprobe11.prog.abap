*&---------------------------------------------------------------------*
*& Report Z_S05_XPROBE11
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_XPROBE11.
class lcl_etwas definition.
  public section.
  methods:
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

 endclass.


 class lcl_etwas IMPLEMENTATION.
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



*ex_artnum = 0021.
*ex_artnam  = 'etwas'.
*ex_artgr = 1.
*ex_ekneto = 5.
*ex_mvp_bruto = 6.
*ex_vpbruto = 7.
*ex_active = 'X'.

    DATA: ls_neuart TYPE zsd_grp2_arst,
          lt_neuart TYPE TABLE OF zsd_grp2_arst.


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

START-OF-SELECTION.


parameters:
       im_artn TYPE z_artnr_grp2,
       im_artna TYPE Z_ART_NM_GRP2,
       im_artgr type Z_ARTGRP_GRP2,
       im_ekne TYPE Z_BETRAG_GRP2,
       im_mvp TYPE Z_NVP_BR_GRP2,
       im_vpbr TYPE Z_VP_BRUTTO_GRP2,
       im_act TYPE BOOLEAN,
       im_dat TYPE SDEMO_CREA_DATUM,
       im_user TYPE MSSSAPUSER.




  DATA lo_etwas TYPE REF TO lcl_etwas.

  CREATE OBJECT lo_etwas.

  lo_etwas->neuartikel(
    IMPORTING
      ex_artnum    = im_artn
     ex_artnam    =  im_artna
      ex_artgr     = im_artgr
      ex_ekneto    = im_ekne
      ex_mvp_bruto = im_mvp
      ex_vpbruto   = im_vpbr
      ex_active    = im_act
      ex_datum     = im_dat
      ex_user      = im_user
  ).
