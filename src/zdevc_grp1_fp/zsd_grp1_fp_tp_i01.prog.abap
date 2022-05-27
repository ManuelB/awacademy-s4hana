*&---------------------------------------------------------------------*
*& Include          ZSD_GRP1_FP_TP_I01
*&---------------------------------------------------------------------*

MODULE user_command_1000 INPUT.

  CASE sy-ucomm.
*Anzeige der Tarife
    WHEN 'SHOW'.
      IF zisu_fp_tarife-anbietername IS INITIAL.
        SELECT * FROM zisu_fp_tarife INTO TABLE lt_tarife.
      ELSE.
        SELECT * FROM zisu_fp_tarife INTO TABLE lt_tarife WHERE anbietername = zisu_fp_tarife-anbietername.
      ENDIF.

*Wahl eines Tarifs zum ändern
    WHEN 'GO'.
      IF zisu_fp_tarife-anbietername IS INITIAL.
        MESSAGE e007 DISPLAY LIKE 'I'.
      ELSEIF zisu_fp_tarife-anbietertarif IS INITIAL.
        MESSAGE e007 DISPLAY LIKE 'I'.
      ELSE.
        SELECT * FROM zisu_fp_tarife
  WHERE anbietername = zisu_fp_tarife-anbietername
  AND anbietertarif = zisu_fp_tarife-anbietertarif.
        ENDSELECT.
      ENDIF.
      IF sy-subrc <> 0.
        CLEAR zisu_fp_tarife.
        MESSAGE 'Keinen Tarif gefunden!' TYPE 'I'.
      ELSE.
        CALL SCREEN 1100.
      ENDIF.

*Programm beenden
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.


MODULE user_command_1100 INPUT.

  CASE sy-ucomm.
*Gewählten Tarif ändern
    WHEN 'CHANGE'.
      SELECT SINGLE FOR UPDATE anbietername, anbietertarif, mon_pauschale, arbeitspreis, abschlag, bonus, empfehlungsrate, preisgarantie, laufzeit, oeko_anteil, co2_anteil, radioaktiver_abfall FROM zisu_fp_tarife
        WHERE anbietername = @zisu_fp_tarife-anbietername
          AND anbietertarif = @zisu_fp_tarife-anbietertarif
        INTO @DATA(ls_tarif).
      IF sy-subrc = 0.
        UPDATE zisu_fp_tarife
        SET mon_pauschale = @zisu_fp_tarife-mon_pauschale,
            arbeitspreis = @zisu_fp_tarife-arbeitspreis,
            abschlag = @zisu_fp_tarife-abschlag,    "Sofortbonus in EUR
            bonus = @zisu_fp_tarife-bonus, "Prozentbonus auf ersten Abschlag
            empfehlungsrate = @zisu_fp_tarife-empfehlungsrate,
            preisgarantie = @zisu_fp_tarife-preisgarantie,
            laufzeit = @zisu_fp_tarife-laufzeit,
            oeko_anteil = @zisu_fp_tarife-oeko_anteil,
            co2_anteil = @zisu_fp_tarife-co2_anteil,
            radioaktiver_abfall = @zisu_fp_tarife-radioaktiver_abfall,
            creauser = @sy-uname,
            creadat = @sy-datum
            WHERE anbietername = @zisu_fp_tarife-anbietername
            AND anbietertarif = @zisu_fp_tarife-anbietertarif.
      ENDIF.
      MESSAGE 'Tarif erfolgreich geändert!' TYPE 'I'.
      SET SCREEN 1100.

*Programm beenden
    WHEN 'BACK'.
      LEAVE PROGRAM.

*Vorgang abbrechen und zum Ausgangsscreen zurückkehren
    WHEN 'RETURN'.
      SET SCREEN 1000.
  ENDCASE.

ENDMODULE.
