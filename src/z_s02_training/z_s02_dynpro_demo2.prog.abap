*&---------------------------------------------------------------------*
*& Report Z_S02_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_dynpro_demo2.

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
      SELECT SINGLE * FROM spfli    "
        WHERE carrid = spfli-carrid
        AND connid = spfli-connid.
        IF sy-subrc <> 0.           "Inhalte löschen.
          clear spfli.
        ENDIF.

        SET SCREEN 200.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.

MODULE user_command_0200 INPUT. "bein Drücken auf einen Button gibt es code aus in sy-ucomm
  CASE sy-ucomm.
    WHEN 'GOTO100'.
      SET SCREEN 100.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
SET TITLEBAR 'TITEL T100'.
  IF spfli-carrid is INITIAL.
  spfli-carrid = 'LH'.
  spfli-connid = '400'.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
  SET TITLEBAR 'TITEL T200'.
ENDMODULE.
