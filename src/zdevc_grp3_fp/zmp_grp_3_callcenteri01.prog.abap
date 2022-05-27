*&---------------------------------------------------------------------*
*& Include          ZMP_GRP_3_CALLCENTERI01
*&---------------------------------------------------------------------*

MODULE user_command_0500 INPUT.
  CASE sy-ucomm.
    WHEN 'CHECK'.
      SELECT * INTO TABLE lt_kunde
                       FROM zgrp3_kunde
                       WHERE kunnr = zgrp3_kunde-kunnr
                       AND geburtsdatum = zgrp3_kunde-geburtsdatum.
    WHEN 'CLEAR'.
      CLEAR zgrp3_kunde-kunnr.
      CLEAR zgrp3_kunde-geburtsdatum.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

MODULE user_command_0600 INPUT.
  CASE sy-ucomm.
    WHEN 'CLEAR'.
      CLEAR zgrp3_kunde-name.
      CLEAR zgrp3_kunde-vorname.
      CLEAR zgrp3_kunde-strasse.
      CLEAR zgrp3_kunde-hausnr.
      CLEAR zgrp3_kunde-plz.
      CLEAR zgrp3_kunde-ort.
      CLEAR zgrp3_kunde-pers_haushalt.
      CLEAR zgrp3_kunde-akt_anbieter.
      CLEAR zgrp3_kunde-anbietertarif.
      CLEAR zgrp3_kunde-status.
  ENDCASE.
ENDMODULE.
