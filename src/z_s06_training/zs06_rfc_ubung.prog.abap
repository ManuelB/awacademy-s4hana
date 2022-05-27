*&---------------------------------------------------------------------*
*& Report ZBC_INTERFACE_1_RFC_SYNC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs06_rfc_ubung.

DATA: fil_line  TYPE zgrp3_filstamm,
      fil_table TYPE TABLE OF zgrp3_filstamm,
      t_result  TYPE bapiret2_t.

SELECT FILIALNUMMER, FILIALBEZEICHNUNG, PLZ, ORT, STRASSE, TELEFON
FROM zgrp3_filstamm
INTO CORRESPONDING FIELDS OF TABLE @fil_table.

DATA i_FILIALNUMMER           TYPE zgrp3_filstamm-filialnummer.
DATA i_FILIALBEZEICHNUNG      TYPE zgrp3_filstamm-filialbezeichnung.
DATA i_PLZ                    TYPE zgrp3_filstamm-plz.
DATA i_ORT                    TYPE zgrp3_filstamm-ort.
DATA i_STRASSE                TYPE zgrp3_filstamm-strasse.
DATA i_TELEFON                TYPE zgrp3_filstamm-telefon.

DATA: new_task TYPE char10.

LOOP AT fil_table INTO fil_line.
  CALL FUNCTION 'ZS06_FB_CREATE_FIL'
    EXPORTING
      i_FILIALNUMMER      = zgrp3_filstamm-filialnummer
      i_FILIALBEZEICHNUNG = zgrp3_filstamm-filialbezeichnung
      i_PLZ               = zgrp3_filstamm-plz
      i_ORT               = zgrp3_filstamm-ort
      i_STRASSE           = zgrp3_filstamm-strasse
      i_TELEFON           = zgrp3_filstamm-telefon
    TABLES
      t_return            = t_result.

ENDLOOP.

BREAK-POINT.
