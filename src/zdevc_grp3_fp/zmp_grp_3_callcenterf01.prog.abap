*&---------------------------------------------------------------------*
*& Include          ZMP_GRP_3_CALLCENTERF01
*&---------------------------------------------------------------------*

CLASS zgrp3_ca IMPLEMENTATION.

  METHOD status.
    SELECT * INTO TABLE lt_kunde
                        FROM zgrp3_kunde
                        WHERE kunnr = zgrp3_kunde-kunnr
                        AND geburtsdatum = zgrp3_kunde-geburtsdatum.
  ENDMETHOD.
ENDCLASS.
