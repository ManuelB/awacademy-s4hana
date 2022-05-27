*&---------------------------------------------------------------------*
*& Report Z_S06_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_dynpro_demo.
TABLES:
  spfli.
CALL SCREEN 100.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN'SHOW'."ALWAYS CAPITAL LETTERS!
      SELECT SINGLE * FROM spfli
        WHERE carrid = spfli-carrid
        AND connid = spfli-connid.
      IF sy-subrc <> 0.
        CLEAR spfli." better would be spfli-cityto, cityfrom,etc. In order to clear only the necessary fields.
      ENDIF.
    WHEN 'BACK'."ALWAYS CAPITAL LETTERS!
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
