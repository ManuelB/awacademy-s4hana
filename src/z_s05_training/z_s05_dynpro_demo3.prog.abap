*&---------------------------------------------------------------------*
*& Report Z_S05_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_DYNPRO_DEMO3.
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
        set screen 200.
    WHEN 'BACK'.
      LEAVE PROGRAM. " GO OUT FROM THE PROGRAM
      ENDCASE.
ENDMODULE.

MODULE user_command_0200 INPUT.

CASE SY-UCOMM. "user command
  when 'GOTO100'.
     set screen 100.
    WHEN 'BACK'.
      LEAVE PROGRAM. " GO OUT FROM THE PROGRAM
      ENDCASE.

ENDMODULE.

MODULE status_0200 OUTPUT.
 SET PF-STATUS 'STATUS200'.
 SET TITLEBAR 'T200'.
 LOOP AT SCREEN.
   IF SCREEN-NAME = 'SPFLI-CITYFROM'.
    " IF SCREEN-INPUT = 0.
       SCREEN-INPUT = 1.
      " ELSE.
    " SCREEN-INPUT = 0.
     ENDIF.
MODIFY SCREEN.
   ENDLOOP.
ENDMODULE.

MODULE status_0100 OUTPUT.
 SET PF-STATUS 'STATUS100'.
 SET TITLEBAR 'T100'.
  if spfli-carrid is initial.
  spfli-carrid = 'LH'.
  spfli-connid = '400'.
endif.
ENDMODULE.
