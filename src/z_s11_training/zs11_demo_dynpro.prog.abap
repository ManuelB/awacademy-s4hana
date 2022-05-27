*&---------------------------------------------------------------------*
*& Report ZS11_DEMO_DYNPRO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs11_demo_dynpro.

TABLES:
  spfli.

CALL SCREEN 100.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      SELECT SINGLE * FROM spfli
        WHERE carrid = spfli-carrid
        AND connid = spfli-connid.
        if sy-subrc <> 0.    "when select query is successful sy-subrc=0.
          clear spfli.
          endif.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
