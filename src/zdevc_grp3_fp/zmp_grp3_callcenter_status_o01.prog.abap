*----------------------------------------------------------------------*
***INCLUDE ZMP_GRP3_CALLCENTER_STATUS_O01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0510 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0510 OUTPUT.
 SET PF-STATUS '0510'.
  SELECT * INTO TABLE lt_zgrp3_status
      FROM zgrp3_kunde
      WHERE kunnr = zgrp3_kunde-kunnr
      AND geburtsdatum = zgrp3_kunde-geburtsdatum.
* SET TITLEBAR 'xxx'.
ENDMODULE.
