*&---------------------------------------------------------------------*
*& Report Z_AW07_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_DYNPRO_DEMO.

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
      when 'BACK'.
      leave PROGRAM.
  ENDCASE.
ENDMODULE.
