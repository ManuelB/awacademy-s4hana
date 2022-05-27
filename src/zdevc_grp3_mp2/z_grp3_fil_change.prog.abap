*&---------------------------------------------------------------------*
*& Report Z_GRP3_FIL_CHANGE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_grp3_fil_change.

DATA grp3_fs TYPE TABLE OF  zgrp3_filstamm.
DATA: lt_filiale TYPE zgrp3_filstamm.
DATA p_filnr TYPE zg03_filialnummer.


PARAMETERS:
  p_filna TYPE zg03_filialbezeichnung OBLIGATORY,
  p_ort   TYPE ad_city1 OBLIGATORY,
  p_stras TYPE ad_street OBLIGATORY,
  p_plz   TYPE ad_pstcd1 OBLIGATORY VALUE CHECK,
  p_tel   TYPE ad_tlnmbr1 OBLIGATORY VALUE CHECK.

TABLES zgrp3_filstamm.



CLASS lcl_sweets DEFINITION.
  PUBLIC SECTION.




ENDCLASS.

CLASS lcl_filiale DEFINITION INHERITING FROM lcl_sweets.



  PUBLIC SECTION.
    METHODS:


      filial_suche
        IMPORTING
          im_filnr TYPE zg03_filialnummer,

      branch_maintenance
        IMPORTING
          im_filnr   TYPE zg03_filialnummer
          im_filname TYPE zg03_filialbezeichnung
          im_ort     TYPE ad_city1
          im_strasse TYPE ad_street
          im_plz     TYPE ad_pstcd1
          im_tel     TYPE ad_tlnmbr1
          im_user    TYPE syst_uname
          im_datum   TYPE dats.
*        EXCEPTIONS
*          pflegen_succ,



          endclass.



    CLASS lcl_filiale IMPLEMENTATION.

    METHOD filial_suche.

      SELECT SINGLE * FROM zgrp3_filstamm
              WHERE Filialnummer =  @zgrp3_filstamm-filialnummer INTO @lt_filiale.

        IF sy-subrc <> 0.
          CLEAR zgrp3_filstamm.
          MESSAGE 'Filialnummer nicht gefunden!' TYPE 'I' DISPLAY LIKE 'W'.
          SET SCREEN 1201.
        ELSE.
          SET SCREEN 1202.
        ENDIF.

      ENDMETHOD.

      METHOD branch_maintenance.



        SELECT SINGLE FOR UPDATE filialbezeichnung, strasse, plz, ort, telefon
         FROM  zgrp3_filstamm
         WHERE filialnummer = @im_filnr
         INTO @DATA(ls_fil).


          IF sy-subrc = 0.

            UPDATE zgrp3_filstamm SET
          Filialbezeichnung = @zgrp3_filstamm-Filialbezeichnung,
          strasse = @zgrp3_filstamm-strasse,
          plz = @zgrp3_filstamm-plz,
          ort = @zgrp3_filstamm-ort,
          telefon = @zgrp3_filstamm-telefon,
          name_anlage_aenderung = @zgrp3_filstamm-name_anlage_aenderung,
          datum_anlage_aenderung = @zgrp3_filstamm-datum_anlage_aenderung





          WHERE filialnummer = @zgrp3_filstamm-filialnummer.

            MESSAGE 'Die Filialdaten wurden erfolgreich geändert!' TYPE 'I'.

          ENDIF.

          SET SCREEN 1201.

        ENDMETHOD.

ENDCLASS.

AT SELECTION-SCREEN.


MODULE user_command_1201 INPUT.

  DATA(lo_filiale) = NEW lcl_filiale( ).

  CASE sy-ucomm.

    WHEN 'SHOW'.
      lo_filiale->filial_suche( im_filnr = p_filnr ).


      IF sy-subrc <> 0.
        CLEAR zgrp3_filstamm.
        MESSAGE 'Filialnummer nicht gefunden!' TYPE 'I' DISPLAY LIKE 'W'.
        SET SCREEN 1201.
      ELSE.
        SET SCREEN 1202.
      ENDIF.

    WHEN 'BACK'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.

MODULE user_command_1202 INPUT.

*  DATA lt_filiale TYPE zsd_grp1_fs.

  CASE sy-ucomm.
    WHEN 'RETURN'.
      SET SCREEN 1201.

    WHEN 'CHANGE'.

      lo_filiale->branch_maintenance(
        EXPORTING
          im_filnr   = p_filnr
          im_filname = p_filna
          im_ort     = p_ort
          im_strasse = p_stras
          im_plz     = p_plz
          im_tel     = p_tel
          im_user    = sy-uname
          im_datum   = sy-datum
      ).

      p_filnr = lt_filiale-filialnummer.
      p_filna = lt_filiale-filialbezeichnung.

    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.
