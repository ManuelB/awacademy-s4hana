*----------------------------------------------------------------------*
***INCLUDE ZS06_CALLCENTER_STATUS_0501O01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0501 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0501 OUTPUT.
*  SET PF-STATUS 'STATUS 0501'.
*  SET TITLEBAR 'T0501'.
*  LOOP AT SCREEN.
*    IF
*      screen-name = 'ZGRP3_kunde-kunnr'.
*      SELECT SINGLE * FROM zgrp3_kunde
*        WHERE kunnr = wa-kunnr
* AND geburtsdatum = wa-geburtsdatum.
*      screen-input = 1.
*      ENDIF.
*      MODIFY SCREEN.
*      ENDLOOP.
ENDMODULE.
