*&---------------------------------------------------------------------*
*& Report ZGRP3_KUNDEDATEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zgrp3_kundedaten.

CALL SCREEN 600.
TABLES zgrp3_kunde.

DATA: ls_neukunde TYPE zs05_kunde_demo,
      kunnrprobe  TYPE zgrp3_kunde-kunnr.
*          lt_neuart TYPE TABLE OF zsd_grp2_arst
*          ls_ TYPE ZS05_KUNDE_DEMO.
*      ls_neukunde-kunnr = ZGRP3_KUNDE-KUNNR.




MODULE status_0600 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
ENDMODULE.

MODULE user_command_0600 INPUT.
  CASE sy-ucomm. "user command
    WHEN 'GO'.

      ls_neukunde-vorname = zgrp3_kunde-vorname.
      ls_neukunde-anrede = zgrp3_kunde-anrede.
      ls_neukunde-geburtsdatum = zgrp3_kunde-geburtsdatum.
      ls_neukunde-strasse = zgrp3_kunde-strasse.
      ls_neukunde-hausnr = zgrp3_kunde-hausnr.
      ls_neukunde-plz = zgrp3_kunde-plz.
      ls_neukunde-ort = zgrp3_kunde-ort.
      ls_neukunde-pers_haushalt = zgrp3_kunde-pers_haushalt.
      ls_neukunde-akt_anbieter = zgrp3_kunde-akt_anbieter.
      ls_neukunde-anbietertarif = zgrp3_kunde-anbietertarif.
      ls_neukunde-status = 'NEW'.
      ls_neukunde-e_mail = zgrp3_kunde-e_mail.
      ls_neukunde-name = zgrp3_kunde-name.

      SELECT MAX( kunnr ) FROM zs05_kunde_demo INTO ls_neukunde-kunnr.
      ls_neukunde-kunnr = ls_neukunde-kunnr + 1.
      CONCATENATE '00000' kunnrprobe INTO ls_neukunde-kunnr.

*    ex_artnum = ls_neuart-artikelnummer.

      INSERT INTO zs05_kunde_demo VALUES ls_neukunde.

    WHEN 'END'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
