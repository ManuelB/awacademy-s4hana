*&---------------------------------------------------------------------*
*& Include ZMP_GRP_3_KUNDEDATEN_TOP                 - Modulpool        ZMP_GRP_3_KUNDEDATEN
*&---------------------------------------------------------------------*
PROGRAM zmp_grp_3_kundedaten MESSAGE-ID ZMSG_GRP3_FP.

TABLES:
 zgrp3_kunde, zs05_kunde_demo.
*
*CLASS lcl_kundedaten DEFINITION.
*  PUBLIC SECTION.
*    METHODS:
*      data_save IMPORTING
*                  im_vorname       TYPE zgrp3_kunde-vorname
*                  im_nachname      TYPE zgrp3_kunde-name
*                  im_anrede        TYPE zgrp3_kunde-anrede
*                  im_geburtsdatum  TYPE gbdat
*                  im_strasse       TYPE zgrp3_kunde-strasse
*                  im_hausnr        TYPE zgrp3_kunde-hausnr
*                  im_plz           TYPE zgrp3_kunde-plz
*                  im_ort           TYPE zgrp3_kunde-ort
*                  im_pers_haushalt TYPE zgrp3_kunde-pers_haushalt
*                  im_akt_anbieter  TYPE zgrp3_kunde-akt_anbieter
*                  im_anbietertarif TYPE zgrp3_kunde-anbietertarif
*                  im_swmtarif      TYPE zs05_kunde_demo-neue_swm_tarife
*                  im_status        TYPE zgrp3_status
*                  im_e_mail        TYPE zgrp3_kunde-e_mail
*                EXPORTING
*                  ex_nummr         TYPE zgrp3_kunnr,
*      data_update IMPORTING
*                    im_nummr         TYPE zgrp3_kunnr
*                    im_swmtarif      TYPE zs05_kunde_demo-neue_swm_tarife
*                    im_pers_haushalt TYPE zgrp3_kunde-pers_haushalt.
*                    endclass.
