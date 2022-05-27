*&---------------------------------------------------------------------*
*& Report Z_AW07_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_DYNPRO_DEMO2.

Tables:
  spfli.

call SCREEN 100.


MODULE user_command_0100 INPUT.
case sy-ucomm.
  when 'SHOW'.
    Select SINGLE * from spfli
      where carrid = spfli-carrid
      and connid = spfli-connid.
      if sy-subrc <> 0.
        clear spfli.
        ENDIF.
        set SCREEN 200.
      when 'BACK'.
      leave PROGRAM.
  ENDCASE.
ENDMODULE.

MODULE user_command_0200 INPUT.
case sy-ucomm.
  when 'GOTO100'.
   SET SCREEN 100.
      when 'BACK'.
      leave PROGRAM.
  ENDCASE.
ENDMODULE.

MODULE status_0200 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
 SET TITLEBAR 'T200'.
ENDMODULE.

MODULE status_0100 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
 SET TITLEBAR 'T100'.
  if spfli-carrid is INITIAL.
  spfli-carrid = 'LH'.
  spfli-connid = '400'.
  ENDIF.
ENDMODULE.
*
