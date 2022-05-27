*&---------------------------------------------------------------------*
*& Report Z_S05_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_ALV_DEMO.
*
TABLES:
  spfli.
*
call screen 100.
*
MODULE user_command_0100 INPUT.
CASE SY-UCOMM. "user command
  when 'SHOW'.
    select SINGLE * FROM SPFLI
      WHERE CARRID = SPFLI-CARRID
      AND CONNID = SPFLI-CONNID.
      if sy-subrc <> 0.
        MESSAGE: 'NICHT DA' TYPE 'E'.
        "spfli-cityfrom = 'nicht da'.
        CLEAR SPFLI.
        endif.
    WHEN 'BACK'.
      LEAVE PROGRAM. " GO OUT FROM THE PROGRAM
      ENDCASE.
ENDMODULE.
