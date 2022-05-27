REPORT zs11_dynpro_demo_status.
*
TABLES:
  spfli.
*
CALL SCREEN 100.
*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      SELECT SINGLE * FROM spfli
        WHERE carrid = spfli-carrid
        AND   connid = spfli-connid.
      IF sy-subrc <> 0.
        CLEAR spfli.
      ENDIF.
*      SET SCREEN 200.
      CALL SCREEN 200.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*
MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN 'GOTO100'.
      SET SCREEN 100.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*
MODULE status_0200 OUTPUT.
 SET PF-STATUS 'STATUS200'.
  SET TITLEBAR 'T200'.
  LOOP AT SCREEN.
    IF screen-name = 'SPFLI-CITYFROM'.
      "IF screen-input = 0.
      screen-input = 1.  "Making the textbox cityfrom eingabebereit dynamically when under element list it is not eingabebereit
      "ELSE.
      "  screen-input = 0.
      "ENDIF.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.
ENDMODULE.
*
MODULE status_0100 OUTPUT.
 SET PF-STATUS 'STATUS100'.
  SET TITLEBAR 'T100'.
  IF spfli-carrid IS INITIAL.
    spfli-carrid = 'LH'.
    spfli-connid = '400'.
  ENDIF.

ENDMODULE.
