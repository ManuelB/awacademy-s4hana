*&---------------------------------------------------------------------*
*& Include          MZ_SWEETSI01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  tables : ZGRP03_SWEETS.

  CASE sy-ucomm.
    WHEN 'get_list'.
      SELECT  * FROM ZGRP03_SWEETS
        WHERE artikelnummer = @ZGRP03_SWEETS-artikelnummer
        AND artikelgruppe = @ZGRP03_SWEETS-artikelgruppe into table @DATA(lt_sweets).
*        if sy-subrc <> 0.    "when select query is successful sy-subrc=0.
*          clear spfli.
*          endif.
*        cl_demo_ouput=>display(lt_sweets).
    WHEN 'BACK'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.
