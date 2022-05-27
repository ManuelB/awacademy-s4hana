*&---------------------------------------------------------------------*
*& Report ZSD_GRP1_NEWFILIALE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsd_grp1_newfiliale.

CLASS lcl_filiale DEFINITION.
PUBLIC SECTION.
    CLASS-EVENTS:
      general_error,
*        EXPORTING
*          VALUE(error) type string,
      general_erfolg.
*        EXPORTING
*          VALUE(erfolg) TYPE string.

    METHODS:
      error FOR EVENT general_error OF lcl_filiale,
*        IMPORTING
*          error,
      erfolg FOR EVENT general_erfolg OF lcl_filiale,
*        IMPORTING
*          erfolg,
      new_filiale
        IMPORTING
          im_filname TYPE zsd_grp1_fsna
        EXPORTING
          ex_filnr   TYPE zsd_grp1_fsnu
          ex_ort     TYPE ad_city1
          ex_strasse TYPE ad_street
          ex_plz     TYPE ad_pstcd1
          ex_tel     TYPE ad_tlnmbr1

        EXCEPTIONS
          gen_succ.

  PRIVATE SECTION.

ENDCLASS.



CLASS lcl_filiale IMPLEMENTATION.
  METHOD error.
    message 'Ein Fehler ist aufgetreten. Mögliche Fehlerursachen sind: Falsche Filialnummer oder Warenbezeichnung' type 'E'.
  ENDMETHOD.
  METHOD erfolg.
    message 'Das neue Objekt wurde erfolgreich angelegt!' type 'S'.
  ENDMETHOD.
  METHOD new_filiale.
    DATA: ls_newfiliale TYPE zsd_grp1_fs.
*          lt_newfiliale TYPE TABLE OF zsd_grp1_fs.
    ls_newfiliale-filname = im_filname.
    ls_newfiliale-Ort = ex_ort.
    ls_newfiliale-Strasse = ex_strasse.
    ls_newfiliale-Plz = ex_plz.
    ls_newfiliale-tel = ex_tel.
*    ls_newfiliale-userid =  ex_userid.
*    ls_newfiliale-datum = ex_datum.

    SELECT MAX( filnr ) FROM zsd_grp1_fs INTO ls_newfiliale-filnr.
    ls_newfiliale-filnr = ls_newfiliale-filnr + 5.
    ex_filnr = ls_newfiliale-filnr.

    INSERT INTO zsd_grp1_fs VALUES ls_newfiliale.
    CLEAR ls_newfiliale.
    UPDATE zsd_grp1_fs SET
            datum = @sy-datum,
            userid = @sy-uname.
    IF sy-subrc = 0.
      RAISE EVENT general_erfolg.
*      EXPORTING
*        erfolg = 'Das neue Objekt wurde erfolgreich angelegt!'.
    ELSE.
      RAISE EVENT general_error.
*      EXPORTING
*      error = 'Ein Fehler ist aufgetreten. Mögliche Fehlerursachen sind: Falsche Filialnummer oder Warenbezeichnung'.
    ENDIF.
message 'bla bla bla' type 'i'.

  ENDMETHOD.

*  METHOD filiale_pflegen.
*
**    CASE sy-ucomm.*
**      WHEN 'CRET'.
*    SELECT SINGLE FOR UPDATE filnr, filname, ort, strasse, plz, tel FROM zsd_grp1_fs INTO @DATA(ls_fil) WHERE filnr = @im_filnr.
*
*    IF sy-subrc <> 0.
*      WRITE 'Filiale nicht gefunden!'.
*    ELSE.
*      SET SCREEN 1200.
**      IF screen-name = 'P_FILNA' OR screen-name = '%_P_FILNA_%_APP_%-TEXT'
**      OR screen-name = 'P_ORT' OR screen-name = '%_P_ORT_%_APP_%-TEXT'
**      OR screen-name = 'P_STRAS' OR screen-name = '%_P_STRAS_%_APP_%-TEXT'
**      OR screen-name = 'P_PLZ' OR screen-name = '%_P_PLZ_%_APP_%-TEXT'
**      OR screen-name = 'P_TEL' OR screen-name = '%_P_TEL_%_APP_%-TEXT'.
**
**          screen-active = 0.
**        screen-input = 1.
**      ENDIF.
*    ENDIF.
*    MODIFY SCREEN.
**    ENDCASE.
*
*  ENDMETHOD.

*  METHOD bestandsliste.
*
*
*  ENDMETHOD.
ENDCLASS.
