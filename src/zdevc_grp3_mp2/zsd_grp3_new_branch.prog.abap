*&---------------------------------------------------------------------*
*& Report ZSD_GRP3_NEW_BRANCH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsd_grp3_new_branch.

TABLES : zgrp3_sweets, zgrp3_bestand,zgrp3_bewegungen, zgrp3_filstamm.


CLASS lcl_filiale DEFINITION.
  PUBLIC SECTION.
    METHODS:
      new_Branch
        IMPORTING
          im_filname TYPE zg03_filialbezeichnung
        EXPORTING
          ex_filnr   TYPE zg03_filialnummer
          ex_ort     TYPE ad_city1
          ex_strasse TYPE ad_street
          ex_plz     TYPE ad_pstcd1
          ex_tel     TYPE ad_tlnmbr1
        EXCEPTIONS
          error.

ENDCLASS.


CLASS lcl_filiale IMPLEMENTATION.



  METHOD new_branch.
    DATA: ls_newfil TYPE zgrp3_filstamm.
*          lt_newfil TYPE TABLE OF ZGRP3_FILSTAMM.
    ls_newfil-filialbezeichnung = im_filname.
    ls_newfil-Ort = ex_ort.
    ls_newfil-Strasse = ex_strasse.
    ls_newfil-Plz = ex_plz.
    ls_newfil-telefon = ex_tel.


    SELECT MAX( filnr ) FROM zgrp3_filstamm INTO ls_newfil-filnr.
    ls_newfil-filnr = ls_newfil-filnr + 5.
    ex_filnr = ls_newfil-filnr.

    INSERT INTO zgrp3_filstamm VALUES ls_newfil.
    CLEAR ls_newfil.
    UPDATE zgrp3_filstamm SET
            datum = @sy-datum,
            userid = @sy-uname.
    IF sy-subrc = 0.

    ELSE.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
