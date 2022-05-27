*&---------------------------------------------------------------------*
*& Include          ZCS_GRP1_FP_WECHSEL_I01
*&---------------------------------------------------------------------*

MODULE user_command_3000 INPUT.

  CASE sy-ucomm.
    WHEN 'SHOW'.
      IF zisu_fp_tarife-anbietername IS INITIAL.
        SELECT * FROM zisu_fp_tarife INTO TABLE lt_tarife.
      ELSE.
        SELECT * FROM zisu_fp_tarife INTO TABLE lt_tarife WHERE anbietername = zisu_fp_tarife-anbietername.
      ENDIF.

      IF sy-subrc <> 0.
        CLEAR zisu_fp_tarife.
        MESSAGE 'Keinen Tarif gefunden!' TYPE 'I'.
      ENDIF.

    WHEN 'BACK'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.

MODULE user_command_3100 INPUT.

  CASE sy-ucomm.
    WHEN 'GO'.
      CALL METHOD zcl_sd_grp1_neukunde=>anbieter_wechseln
        EXPORTING
          im_anrede       = zsd_grp1_fp_ks-anrede
          im_vorname      = zsd_grp1_fp_ks-vorname
          im_nachname     = zsd_grp1_fp_ks-nachname
          im_geburtsdatum = zsd_grp1_fp_ks-geburtsdatum
          im_strasse      = zsd_grp1_fp_ks-strasse
          im_hausnr       = zsd_grp1_fp_ks-hsnum
          im_plz          = zsd_grp1_fp_ks-plz
          im_ort          = zsd_grp1_fp_ks-ort
          im_wechseldatum = zsd_grp1_fp_ks-wechseldatum
          im_zahlernr     = zsd_grp1_fp_ks-zaehlernr
          im_zaehlerstd   = zsd_grp1_fp_ks-zaehlerstand
          im_altanbieter  = zsd_grp1_fp_ks-altanb
          im_neuanbieter  = felda
          im_neutarif     = feldt
        IMPORTING
          ex_aufnr        = zsd_grp1_fp_ks-kdnr.

      IF sy-subrc = 0.
        MESSAGE 'Tarifwechsel wurde erfolgreich beantragt!' TYPE 'I'.

        LEAVE TO CURRENT TRANSACTION.
      ELSE.
        MESSAGE 'Wechselantrag fehlgeschlagen!' TYPE 'I' DISPLAY LIKE 'E'.
      ENDIF.

    WHEN 'CLOSE'.
*      SET SCREEN 3000.
      LEAVE TO CURRENT TRANSACTION.
  ENDCASE.

ENDMODULE.
