*&---------------------------------------------------------------------*
*& Report ZS12_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs12_dynpro_demo.
TABLES:
  spfli.
CALL SCREEN 100.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm. "Usercommand wird abgefragt "Welcher button gedrückt wird, wird hierhin verschoben
    WHEN 'SHOW'. "Show Button fkt.code - case sensitive
      SELECT SINGLE * FROM spfli
        WHERE carrid = spfli-carrid
        AND   connid = spfli-connid.
*      CASE spfli-carrid.
*        WHEN sy-subrc NE 0.
*          MESSAGE 'Keine gültige Fluggesellschaft eingegeben' TYPE 'E'.
*
*      ENDCASE.
*      CASE spfli-connid.
*        WHEN sy-subrc <> 0.
*          MESSAGE 'Keine gültige Flugverbindung eingegeben' TYPE 'E'.
*
*      ENDCASE.
      IF sy-subrc <> 0.
        CLEAR spfli.
    ENDIF.
    WHEN 'BACK'. "back button fkt.code - case sensitive
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
