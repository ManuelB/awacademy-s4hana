*&---------------------------------------------------------------------*
*& Report ZS03_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs03_dynpro_demo_status.
TABLES:
  spfli.

CALL SCREEN 100.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      SELECT SINGLE * FROM spfli
        WHERE carrid = spfli-carrid
        and connid = spfli-connid.
        if sy-subrc <> 0.
*          clear spfli.
          MESSAGE e001(38) WITH 'zu' spfli-carrid spfli-connid 'keine Daten gefunden'.
* & & & &

          ENDIF.
          SET SCREEN 200.
    WHEN 'BACK'.
      LEAVE PROGRAM.
      ENDCASE.
ENDMODULE.

MODULE user_command_0200 INPUT.
   CASE sy-ucomm.
   WHEN 'GOTO100'.
      SET SCREEN 100.
    WHEN 'BACK'.
      LEAVE PROGRAM.
ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
 SET PF-STATUS 'STATUS200'.
 SET TITLEBAR 'T200'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS 'STATUS100'.
 SET TITLEBAR 'T100'.
  if spfli-carrid is initial.
*    Si on veut que la dernière recherche reste en mémoire.
  spfli-carrid = 'LH'.
  spfli-connid = '400'.
  ENDIF.
ENDMODULE.
