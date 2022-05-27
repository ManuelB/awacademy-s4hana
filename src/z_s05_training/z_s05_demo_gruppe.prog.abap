*&---------------------------------------------------------------------*
*& Report Z_S05_DEMO_GRUPPE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_DEMO_GRUPPE.


call screen 100.




*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0122  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0122 INPUT.




  CASE SY-UCOMM. "user command
  when 'NEU'.
call transaction 'Z_GRP03_SWEETS' without AUTHORITY-CHECK.
  WHEN 'AND'.
    call transaction 'Z_S05_GRDEMO5' without AUTHORITY-CHECK.
    WHEN 'AUS'.
 call transaction 'Z_S05_GRDEMO3' without AUTHORITY-CHECK.
    WHEN 'WAR'.
    call transaction 'Z_S05_GRDEMO4' without AUTHORITY-CHECK.
    WHEN 'BACK'.

      LEAVE PROGRAM.
      ENDCASE.

ENDMODULE.
