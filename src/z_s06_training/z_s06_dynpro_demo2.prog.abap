*&---------------------------------------------------------------------*
*& Report Z_S06_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_dynpro_demo2.
TABLES:
  spfli.
CALL SCREEN 100."abap code to call dynpro100

MODULE user_command_0100 INPUT."DYNPRO for screen 1
  CASE sy-ucomm.
    WHEN'SHOW'."ALWAYS CAPITAL LETTERS!
      SELECT SINGLE * FROM spfli
        WHERE carrid = spfli-carrid        "all code inbetween the "module" is abap code
        AND connid = spfli-connid.
      IF sy-subrc <> 0.
        CLEAR spfli." better would be spfli-cityto, cityfrom,etc
      ENDIF.
      SET SCREEN 200."takes you to screen 200
    WHEN 'BACK'."ALWAYS CAPITAL LETTERS!
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
**********************************************************************
MODULE user_command_0200 INPUT."DYNPRO for screen 2
  CASE sy-ucomm.
    WHEN'GOTO100'."ALWAYS CAPITAL LETTERS!
      SET SCREEN 100.
    WHEN 'BACK'."ALWAYS CAPITAL LETTERS!
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

MODULE status_0100 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
 SET TITLEBAR 'T100'.
  IF spfli-carrid IS INITIAL.
  spfli-carrid = 'LH'. "like default value
  spfli-connid = '400'. "like default value
  ENDIF.
ENDMODULE.

MODULE status_0200 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
 SET TITLEBAR 'T200'.
ENDMODULE.
