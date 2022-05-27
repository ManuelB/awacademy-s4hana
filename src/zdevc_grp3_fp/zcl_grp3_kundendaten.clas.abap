class ZCL_GRP3_KUNDENDATEN definition
  public
  final
  create public .

public section.

  methods SAVE_DATA
    importing
      value(IM_VORNAME) type ZGRP3_KUNDE-VORNAME
      value(IM_NACHNAME) type ZGRP3_KUNDE-NAME
      value(IM_ANREDE) type ZGRP3_KUNDE-ANREDE
      value(IM_GEBURTSDATUM) type ZGRP3_KUNDE-GEBURTSDATUM
      value(IM_STRASSE) type ZGRP3_KUNDE-STRASSE
      value(IM_HAUSNR) type ZGRP3_KUNDE-HAUSNR
      value(IM_PLZ) type ZGRP3_KUNDE-PLZ
      value(IM_ORT) type ZGRP3_KUNDE-ORT
      value(IM_PERS_HAUSHALT) type ZGRP3_KUNDE-PERS_HAUSHALT
      value(IM_AKT_ANBIETER) type ZGRP3_KUNDE-AKT_ANBIETER
      value(IM_ANBIETERTARIF) type ZGRP3_KUNDE-ANBIETERTARIF
      value(IM_E_MAIL) type ZGRP3_KUNDE-E_MAIL
      value(IM_SWMTARIF) type ZGRP3_KUNDE-NEUE_SWM_TARIFE
    exporting
      value(EX_NUMMR) type ZGRP3_KUNNR
    exceptions
      VORNAME_NG
      VORNAME_NR
      NACHNAME_NG
      NACHNAME_NR
      GEBDATUM_NG
      EMAIL_NG
      EMAIL_NR
      STR_NG
      STR_NR
      HAUSNUM_NG
      HAUSNUM_NR
      ORT_NG
      ORT_NR
      PLZ_NG
      PLZ_NR
      HAUSHALT_NG
      AKT_ANBIETER_NG .
  methods DATA_UPDATE
    importing
      !IM_SWMTARIF type ZGRP3_KUNDE-NEUE_SWM_TARIFE
      !IM_NUMMR type ZGRP3_KUNNR .
protected section.
private section.
ENDCLASS.



CLASS ZCL_GRP3_KUNDENDATEN IMPLEMENTATION.


  METHOD data_update.
    SELECT SINGLE FOR UPDATE * FROM zgrp3_kunde INTO @DATA(ls_data)
        WHERE kunnr = @im_nummr.

    UPDATE zgrp3_kunde
  SET
neue_swm_tarife = @im_swmtarif,
status = 'NEW'
WHERE kunnr = @im_nummr.

  ENDMETHOD.


  METHOD save_data.

    DATA: ls_neukunde TYPE zgrp3_kunde,
*          kunnrprobe  TYPE zgrp3_kunde-kunnr,
          lv_wort     TYPE c LENGTH 100,
          lv_zahl     TYPE c LENGTH 100,
          lv_email    TYPE c LENGTH 100.

    lv_wort = ' QWERTZUIOPÜASDFGHJKLÖÄYXCVBNMqwertzuiopüasdfghjklöäyxcvbnm-.'.
    lv_zahl = ' 0123456789'.
    lv_email = ' QWERTZUIOPÜASDFGHJKLÖÄYXCVBNMqwertzuiopüasdfghjklöäyxcvbnm-.@_'.

    DATA: nr TYPE n LENGTH 10.
    ls_neukunde-vorname =  im_vorname.
    ls_neukunde-anrede = im_anrede.
    ls_neukunde-geburtsdatum = im_geburtsdatum.
    ls_neukunde-strasse = im_strasse .
    ls_neukunde-hausnr = im_hausnr.
    ls_neukunde-plz = im_plz .
    ls_neukunde-ort = im_ort   .
    ls_neukunde-pers_haushalt = im_pers_haushalt.
    ls_neukunde-akt_anbieter = im_akt_anbieter.
    ls_neukunde-anbietertarif = im_anbietertarif.
    ls_neukunde-neue_swm_tarife = im_swmtarif.
    ls_neukunde-status = 'NEW'.
    ls_neukunde-e_mail = im_e_mail.
    ls_neukunde-name = im_nachname.

    SELECT MAX( kunnr ) FROM zgrp3_kunde INTO ls_neukunde-kunnr.
    nr = ls_neukunde-kunnr + 1.
    WRITE nr TO ls_neukunde-kunnr.

*****************Vorname****************************
    IF im_vorname IS INITIAL.
      RAISE vorname_ng.
    ELSE.

      IF im_vorname CN lv_wort.
        RAISE vorname_nr.
      ELSE.
*****************Nachname****************************
        IF im_nachname IS INITIAL.
          RAISE nachname_ng.
        ELSE.

          IF im_nachname CN lv_wort.
            RAISE nachname_nr.
          ELSE.
*****************Geburtsdatum****************************
            IF im_geburtsdatum IS INITIAL.
              RAISE gebdatum_ng.
            ELSE.
*****************E-mail****************************
              IF im_e_mail IS INITIAL.
                RAISE email_ng.
              ELSE.

                IF im_e_mail CN lv_email
                  AND im_e_mail NA '@'.
                  RAISE email_nr.
                ELSE.
*****************E-mail****************************
                  IF im_strasse IS INITIAL.
                    RAISE str_ng.
                  ELSE.
                    IF im_strasse CN lv_wort.
                      RAISE str_nr.
                    ELSE.
****************Hausnummer****************************
                      IF im_hausnr IS INITIAL.
                        RAISE hausnum_ng.
                      ELSE.
                        IF im_hausnr CN lv_zahl.
                          RAISE hausnum_nr.
                        ELSE.
****************Ort****************************
                          IF im_ort IS INITIAL.
                            RAISE ort_ng.
                          ELSE.
                            IF im_ort CN lv_wort.
                              RAISE ort_nr.
                            ELSE.
****************PLZ****************************
                              IF im_plz IS INITIAL.
                                RAISE plz_ng.
                              ELSE.
                                IF im_plz CN lv_zahl
                                  AND im_plz > 100000 AND im_plz < 10000.
                                  RAISE plz_nr.
                                ELSE.
****************Haushalt****************************
                                  IF im_pers_haushalt IS INITIAL.
                                    RAISE haushalt_ng.
                                  ELSE.
****************Anbieter****************************
                                    IF im_akt_anbieter IS INITIAL or im_anbietertarif IS INITIAL.
                                      RAISE akt_anbieter_ng.
                                    ELSE.

                                      INSERT INTO zgrp3_kunde VALUES ls_neukunde.

                                    ENDIF.
                                  ENDIF.
                                ENDIF.
                              ENDIF.
                            ENDIF.
                          ENDIF.
                        ENDIF.
                      ENDIF.
                    ENDIF.
                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
      ENDIF.
      CLEAR ls_neukunde.

    ENDMETHOD.
ENDCLASS.
