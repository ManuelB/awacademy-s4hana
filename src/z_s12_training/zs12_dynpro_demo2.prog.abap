*&---------------------------------------------------------------------*
*& Report ZS12_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs12_dynpro_demo2.
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
      SET SCREEN 200. "ruft DYNPRO 200 auf
    WHEN 'BACK'. "back button fkt.code - case sensitive
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

MODULE user_command_0200 INPUT.
  CASE sy-ucomm. "Usercommand wird abgefragt "Welcher button gedrückt wird, wird hierhin verschoben
    WHEN 'GOTO100'. "Show Button fkt.code - case sensitive
      SET SCREEN 100. "ruft DYNPRO 100 auf
      IF sy-subrc <> 0.
        CLEAR spfli.
      ENDIF.
    WHEN 'BACK'. "back button fkt.code - case sensitive
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
  SET TITLEBAR 'T200'.
  LOOP AT SCREEN.
    IF screen-name = 'SPFLI-CITYFROM'.
      screen.input = 1.
    ENDIF.
    ENDLOOP.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS 'STATUS100'.
  SET TITLEBAR 'T100'.
  IF spfli-carrid IS INITIAL.
    spfli-carrid = 'LH'.
    spfli-connid = 400.
  ENDIF.
ENDMODULE.
