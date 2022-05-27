*&---------------------------------------------------------------------*
*& Report ZS11_DEMO_DYNPRO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs11_demo_dynpro_2.

TABLES:
  spfli.

CALL SCREEN 100.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      SELECT SINGLE * FROM spfli
        WHERE carrid = spfli-carrid
        AND connid = spfli-connid.
        if sy-subrc <> 0.
          clear spfli.
          endif.
          set screen 200.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
    CASE sy-ucomm.
    WHEN 'GOTO100'.
   set screen 100.
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
 SET TITLEBAR 'T100'.
IF spfli-carrid is initial.
  spfli-carrid = 'LH'.
  spfli-connid = '400'.
  endif.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
 SET TITLEBAR 'T200'.
ENDMODULE.
