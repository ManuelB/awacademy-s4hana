*&---------------------------------------------------------------------*
*& Include          ZMP_GRP_3_KUNDEDATEN_F01
*&---------------------------------------------------------------------*
*
*
*CLASS lcl_kundedaten IMPLEMENTATION.
*  METHOD data_save.
*    DATA: ls_neukunde TYPE zs05_kunde_demo,
*      kunnrprobe  TYPE zgrp3_kunde-kunnr.
*    DATA: nr type n length 10.
*    ls_neukunde-vorname =  im_vorname.
*         ls_neukunde-anrede = im_anrede.
*         ls_neukunde-geburtsdatum = im_geburtsdatum.
*         ls_neukunde-strasse = im_strasse .
*         ls_neukunde-hausnr = im_hausnr.
*         ls_neukunde-plz = im_plz .
*         ls_neukunde-ort = im_ort   .
*         ls_neukunde-pers_haushalt = im_pers_haushalt.
*         ls_neukunde-akt_anbieter = im_akt_anbieter.
*         ls_neukunde-anbietertarif = im_anbietertarif.
*         ls_neukunde-neue_swm_tarife = im_swmtarif.
*         ls_neukunde-status = 'NEW'.
*    ls_neukunde-e_mail = zgrp3_kunde-e_mail.
*    ls_neukunde-name = zgrp3_kunde-name.
*
*    select MAX( kunnr ) FROM zs05_kunde_demo INTO ls_neukunde-kunnr.
*     nr = ls_neukunde-kunnr + 1.
*     write nr to ls_neukunde-kunnr.
**    ls_neukunde-kunnr = ls_neukunde-kunnr + 1.
**    ex_nummr = ls_neukunde-kunnr.
**    CONCATENATE '00000' kunnrprobe INTO ls_neukunde-kunnr.
*
**    ex_artnum = ls_neuart-artikelnummer.
*
*    INSERT INTO zs05_kunde_demo VALUES ls_neukunde.
*    if sy-subrc = 0.
*      Message: |Tarifwechsel erfolgreich beantragt| type 'I'.
*      endif.
*  ENDMETHOD.
*  METHOD data_update.
*
*SELECT SINGLE FOR UPDATE * FROM zgrp3_kunde INTO @DATA(ls_data)
*        WHERE kunnr = @im_nummr.
*
*  IF SY-SUBRC = 0.
*
*        UPDATE zs05_kunde_demo
*      SET
* neue_swm_tarife = @im_swmtarif,
* pers_haushalt = @im_pers_haushalt,
* status = 'NEW'
*    WHERE kunnr = @im_nummr.
*        ELSE.
*          MESSAGE |Kunde nicht da!| TYPE 'E'.
*        endif.
*   endmethod.
*ENDCLASS.
