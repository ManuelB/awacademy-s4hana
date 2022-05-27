*&---------------------------------------------------------------------*
*& Report ZSD_GRP1_AUSLISTEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSD_GRP1_REP_AUSLISTEN MESSAGE-ID ZMSG_GRP1.


SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME TITLE TEXT-101.

  PARAMETERS: p_artnr TYPE artnr.

SELECTION-SCREEN END OF BLOCK a.


START-OF-SELECTION.

  SELECT SINGLE FOR UPDATE artnr, activeflag FROM zsd_grp1_sw
    WHERE artnr = @p_artnr
    INTO @DATA(ls_artnr).

    UPDATE zsd_grp1_sw SET activeflag = ' ' WHERE artnr = p_artnr.

    MESSAGE: e005 WITH p_artnr.
