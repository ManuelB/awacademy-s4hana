*&---------------------------------------------------------------------*
*& Report ZSD_GRP1_NEUART
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsd_grp1_rep_neupreis MESSAGE-ID zmsg_grp1.


SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME TITLE TEXT-100.

  PARAMETERS: p_artnr TYPE artnr,
              p_neupr TYPE zsd_grp1_vkpreis.

SELECTION-SCREEN END OF BLOCK a.

DATA mnvkpreis TYPE ZSD_GRP1_mnVKPREIS.

START-OF-SELECTION.

  SELECT SINGLE FOR UPDATE artnr, vkpreis, mnvkpreis FROM zsd_grp1_sw
    WHERE artnr = @p_artnr
    AND vkpreis = @p_neupr
    INTO @DATA(ls_neupreis).


  IF p_neupr >= ls_neupreis-mnvkpreis.
    UPDATE zsd_grp1_sw SET vkpreis = @p_neupr WHERE artnr = @p_artnr.
  ELSE.
    MESSAGE e003.
ENDIF.

  IF p_neupr <= ls_neupreis-vkpreis * '1.25'.
    UPDATE zsd_grp1_sw SET vkpreis = @p_neupr WHERE artnr = @p_artnr.
  ELSE.
    MESSAGE e004.
  ENDIF.
