*&---------------------------------------------------------------------*
*& Report Z_S02_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_dynpro_demo.

TABLES:
  spfli.



CALL SCREEN 100.



*PROCESS AFTER INPUT.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT. "bein Drücken auf einen Button gibt es code aus in sy-ucomm
  CASE sy-ucomm.
    WHEN 'SHOW'.                "Achtung, SHOW muss gross geschrieben sein.
      SELECT SINGLE * FROM spfli
        WHERE carrid = spfli-carrid
        AND connid = spfli-connid.
        IF sy-subrc <> 0.           "Inhalte löschen.
          clear spfli.
        ENDIF.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.
