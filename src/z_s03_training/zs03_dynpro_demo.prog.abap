*&---------------------------------------------------------------------*
*& Report ZS03_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs03_dynpro_demo.
TABLES:
  spfli.

CALL SCREEN 100.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      SELECT SINGLE * FROM spfli
        WHERE carrid = spfli-carrid
        and connid = spfli-connid.
        if sy-subrc <> 0.
          clear spfli.
          ENDIF.
    WHEN 'BACK'.
      LEAVE PROGRAM.
      ENDCASE.
ENDMODULE.
