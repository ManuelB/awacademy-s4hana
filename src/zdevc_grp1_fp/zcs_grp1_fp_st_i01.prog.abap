*&---------------------------------------------------------------------*
*& Include          ZCS_GRP1_FP_WL_I01
*&---------------------------------------------------------------------*

MODULE user_command_2000 INPUT.
  CASE sy-ucomm.
*Anzeige der Kundendaten des gewählten Auftrags
    WHEN 'SHOW'.
      SELECT SINGLE * FROM zsd_grp1_fp_wt
        WHERE auftnr = zsd_grp1_fp_wt-auftnr
        AND vorname = zsd_grp1_fp_wt-vorname
        AND nachname = zsd_grp1_fp_wt-nachname
        AND geburtsdatum = zsd_grp1_fp_wt-geburtsdatum.
      SET SCREEN 2100.

*Programm beenden
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

MODULE user_command_2100 INPUT.

  CASE sy-ucomm.
*Vorgang abbrechen und zum Ausgangsscreen zurückkehren
    WHEN 'BACK'.
      SET SCREEN 2000.
      CLEAR zsd_grp1_fp_wt.
*Programm beenden
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.



MODULE user_command_2500 INPUT.

  CASE sy-ucomm.
*Anzeige aller oder eines Auftrags im ALV
    WHEN 'SHOW'.
      IF zsd_grp1_fp_wt-auftnr IS INITIAL.
        SELECT * FROM zsd_grp1_fp_wt INTO TABLE lt_wt.
      ELSE.
        SELECT * FROM zsd_grp1_fp_wt INTO TABLE lt_wt WHERE auftnr = zsd_grp1_fp_wt-auftnr.
      ENDIF.
      IF sy-subrc <> 0.
        CLEAR zsd_grp1_fp_wt.
        MESSAGE e005 DISPLAY LIKE 'I'.
      ENDIF.

*Wechsel in Änderungsmodus für gewählten Auftrag
    WHEN 'GO'.
      SELECT SINGLE * FROM zsd_grp1_fp_wt
        WHERE auftnr = zsd_grp1_fp_wt-auftnr.
      IF zsd_grp1_fp_wt-auftnr IS INITIAL.
        MESSAGE e004 DISPLAY LIKE 'I'.
      ELSE.
        IF sy-subrc = 0.
          CALL SCREEN 2600.
        ENDIF.
      ENDIF.

*Programm beenden
    WHEN 'BACK'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.


MODULE user_command_2600 INPUT.

  CASE sy-ucomm.
*Status des gewählten Auftrags ändern
    WHEN 'CHANGE'.
      SELECT SINGLE FOR UPDATE auftnr, status FROM zsd_grp1_fp_wt
        WHERE auftnr = @zsd_grp1_fp_wt-auftnr INTO @DATA(ls_edi).
      IF sy-subrc = 0.
        IF zsd_grp1_fp_wt-status = 4.
          CALL SCREEN 2650 STARTING AT 10 5.

        ELSE.
          UPDATE zsd_grp1_fp_wt
                  SET status = @zsd_grp1_fp_wt-status
                  WHERE auftnr = @zsd_grp1_fp_wt-auftnr.
          MESSAGE 'Status erfolgreich geändert' TYPE 'I'.
          CALL SCREEN 2500.
        ENDIF.
      ENDIF.

*Vorgang abbrechen und zum Ausgangsscreen zurückkehren
    WHEN 'RETURN'.
      CALL SCREEN 2500.

*Programm beenden
    WHEN 'BACK'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.



MODULE user_command_2650 INPUT.

  CASE sy-ucomm.
*Abschicken der EDI-Message und damit Änderung des Status auf 4
    WHEN 'SEND'.
      SELECT SINGLE FOR UPDATE auftnr, status FROM zsd_grp1_fp_wt
        WHERE auftnr = @zsd_grp1_fp_wt-auftnr INTO @DATA(ls_edi2).
      IF sy-subrc = 0.
        UPDATE zsd_grp1_fp_wt
        SET status = @zsd_grp1_fp_wt-status
        WHERE auftnr = @zsd_grp1_fp_wt-auftnr.
      ENDIF.
      MESSAGE 'Nachricht wurde erfolgreich verschickt' TYPE 'I'.
      MESSAGE 'Status erfolgreich geändert' TYPE 'I'.
      CALL SCREEN 2500.


*Vorgang abbrechen und zum Ausgangsscreen zurückkehren
    WHEN 'CANCEL'.
      CLEAR zsd_grp1_fp_wt.
      LEAVE TO CURRENT TRANSACTION.
  ENDCASE.

ENDMODULE.
