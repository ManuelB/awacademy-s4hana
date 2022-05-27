*&---------------------------------------------------------------------*
*& Report ZSD_G2_AUSLISTEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_aw07_auslisten.

SELECTION-SCREEN BEGIN OF BLOCK 9000.
PARAMETERS: p_artnr TYPE artnr.

PARAMETERS p_aus RADIOBUTTON GROUP rb_1.

PARAMETERS p_ein RADIOBUTTON GROUP rb_1.

SELECTION-SCREEN END OF BLOCK 9000.

START-OF-SELECTION.

CASE 'X'.
  WHEN p_aus.
  SELECT SINGLE FOR UPDATE artikelnummer, activeflag, akt_lagerbestand, mindestbestand FROM zsd_grp2_arst
    WHERE artikelnummer = @p_artnr
    INTO @DATA(ls_artnr).
    if sy-subrc = 0.

    if ls_artnr-akt_lagerbestand > ls_artnr-mindestbestand.
        MESSAGE |Artikel kann nicht ausgelistet werden da der akt.Bestand über den min.Best liegt!| TYPE 'E'.
      ELSE.
    UPDATE zsd_grp2_arst SET activeflag = '-' WHERE artikelnummer = p_artnr.
    MESSAGE |Der Artikel ist erfolgreich ausgelistet!| TYPE 'S'.
   endif.
   ELSE.
  MESSAGE |Der Artikel ist nicht vorhanden!| TYPE 'E'.
ENDIF.

    WHEN p_ein.
    SELECT SINGLE FOR UPDATE artikelnummer, activeflag FROM zsd_grp2_arst
    WHERE artikelnummer = @p_artnr
    INTO @DATA(ls_artnr1).
    if sy-subrc = 0.
    UPDATE zsd_grp2_arst SET activeflag = 'X' WHERE artikelnummer = p_artnr.
    MESSAGE |Der Artikel ist erfolgreich eingelistet!| TYPE 'S'.
    else.

  MESSAGE |Der Artikel ist nicht vorhanden!| TYPE 'E'.

    ENDIF.
    ENDCASE.


*    UPDATE zsd_grp2_arst set activeflag = 'X' WHERE artikelnummer = p_artnr.


*select option, radiobutton, return code, fehlerhandling fehlt
