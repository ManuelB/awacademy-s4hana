*&---------------------------------------------------------------------*
*& Report ZSD_GRP1_UML_CG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsd_grp1_uml_cg.

TABLES: zsd_GRP1_uml.
TABLES: zsd_GRP1_bes.
TYPES: lt TYPE zsd_grp1_uml.
DATA: ls_uml  TYPE lt,
      lt_uml  TYPE TABLE OF lt,
      lv_fila TYPE zsd_grp1_bes,
      lv_fil1 TYPE zsd_grp1_bes,
      lv_fil2 TYPE zsd_grp1_bes.

CLASS lcl_umlagerung DEFINITION.
  PUBLIC SECTION.
    METHODS: uml_tab_bef
      IMPORTING
        i_fil_a      TYPE     lt-filialnr
        i_artnr1     TYPE     lt-artnr
        i_mengea     TYPE     lt-menge
        i_bwart      TYPE     lt-bwart
        i_filnr1     TYPE     lt-filialnr
        i_meng1      TYPE     lt-menge
        i_filnr2     TYPE     lt-filialnr
        i_meng2      TYPE     lt-menge
      EXPORTING
        ex_sollhaben TYPE lt-sollhaben.

ENDCLASS.

CLASS lcl_umlagerung IMPLEMENTATION.

  METHOD uml_tab_bef.




******    Bewegung A
    ls_uml-filialnr = i_fil_a.
    ls_uml-artnr = i_artnr1.
    ls_uml-menge  = i_mengea.
    ls_uml-bwart = i_bwart.
    IF i_bwart = '105'.
      ls_uml-sollhaben = '+'.
    ELSE.
      ls_uml-sollhaben = '-'.
    ENDIF.
    ls_uml-verbuchender = sy-uname.
    ls_uml-verbuchungsdatum = sy-datum.
    ls_uml-verbuchungszeit = sy-uzeit.
    ls_uml-mengeneinheit = 'ST'.
    APPEND ls_uml TO lt_uml.
    CLEAR ls_uml.
*    INSERT zsd_grp1_uml FROM ls_uml.
    COMMIT WORK.


******    Bewegung 1
    ls_uml-filialnr = i_filnr1.
    ls_uml-artnr = i_artnr1.
    ls_uml-menge  = i_meng1.
    IF i_bwart = '105'.
      ls_uml-bwart = '106'.
      ls_uml-sollhaben = '-'.
    ELSE.
      ls_uml-bwart = '105'.
      ls_uml-sollhaben = '+'.
    ENDIF.
    ls_uml-verbuchender = sy-uname.
    ls_uml-verbuchungsdatum = sy-datum.
    ls_uml-verbuchungszeit = sy-uzeit.
    ls_uml-mengeneinheit = 'ST'.
    APPEND ls_uml TO lt_uml.
    CLEAR ls_uml.
*    INSERT zsd_grp1_uml FROM ls_uml.
    COMMIT WORK.


******    Bewegung 2
*    IF i_filnr2 IS NOT INITIAL AND i_meng2 IS NOT INITIAL.
    ls_uml-filialnr = i_filnr2.
    ls_uml-artnr = i_artnr1.
    ls_uml-menge  = i_meng2.
    IF i_bwart = '105'.
      ls_uml-bwart = '106'.
      ls_uml-sollhaben = '-'.
    ELSE.
      ls_uml-bwart = '105'.
      ls_uml-sollhaben = '+'.
    ENDIF.
    ls_uml-verbuchender = sy-uname.
    ls_uml-verbuchungsdatum = sy-datum.
    ls_uml-verbuchungszeit = sy-uzeit.
    ls_uml-mengeneinheit = 'ST'.
    APPEND ls_uml TO lt_uml.
    CLEAR ls_uml.
*    ELSE.
*      MESSAGE 'Inkonsistente Eingabe. Bitte prüfen Sie Ihre Einagbe!' TYPE 'I'.
*    ENDIF.
    COMMIT WORK.


*    IF i_filnr2 IS INITIAL AND i_mengea = i_meng1.
*      DELETE FROM zsd_grp1_uml.
*      INSERT zsd_GRP1_uml FROM TABLE lt_uml.
*    ELSEIF i_filnr2 IS NOT INITIAL AND i_mengea = i_meng1 + i_meng2.
*      DELETE FROM zsd_grp1_uml.
*      INSERT zsd_GRP1_uml FROM TABLE lt_uml.
*    ELSE.
*       Eingabefehler
*    ENDIF.
*
*    COMMIT WORK.
*#################################################################################

    IF i_mengea <> i_meng1 + i_meng2.
      MESSAGE 'Die Verteilung der Artikelmengen stimmt nicht überein! Bitte prüfen Sie Ihre Einagbe!' TYPE 'I'.
      LEAVE TO CURRENT TRANSACTION. " Leave to screen 1300.
    ELSE.
      COMMIT WORK.
    ENDIF.
    SELECT SINGLE *
      FROM zsd_grp1_bes INTO @lv_fila
       WHERE artnr = @i_artnr1
        AND filnr = @i_fil_a.

    SELECT SINGLE *
  FROM zsd_grp1_bes INTO @lv_fil1
  WHERE artnr = @i_artnr1
  AND filnr = @i_filnr1.

    SELECT SINGLE *
FROM zsd_grp1_bes INTO @lv_fil2
WHERE artnr = @i_artnr1
AND filnr = @i_filnr2.

*    LOOP AT lt_uml INTO ls_uml. " WHERE filialnr = i_fil_a.
*      IF ls_uml-sollhaben = '+'. " Fall ZUGANG
*        IF lv_fila-mxbes < ( lv_fila-akbes + ls_uml-menge ).
*          MESSAGE ' Der Maximalbestand in der aufnehmenden Filiale würde bei dieser Menge überschritten werden! Bitte ändern Sie Ihre Einagbe!' TYPE 'I'.
*        ELSEIF lv_fil1-mxbes < ( lv_fil1-akbes + ls_uml-menge ).
*          MESSAGE ' Der Maximalbestand in der aufnehmenden Filiale 1 würde bei dieser Menge überschritten werden! Bitte ändern Sie Ihre Einagbe!' TYPE 'I'.
*        ELSEIF lv_fil2-mxbes < ( lv_fil2-akbes + ls_uml-menge ).
*          MESSAGE ' Der Maximalbestand in der aufnehmenden Filiale 2 würde bei dieser Menge überschritten werden! Bitte ändern Sie Ihre Einagbe!' TYPE 'I'.
*        ELSE.
*          " Prüfung erfolgreich
*        ENDIF.
**     ENDIF.
*      ELSEIF ls_uml-sollhaben = '-'. " Fal ABGANG
*        IF lv_fila-mdbes < ( lv_fila-akbes - ls_uml-menge ).
*          MESSAGE ' Der Minimalbestand in der abgebenden Filiale würde bei dieser Menge unterschritten werden! Bitte ändern Sie Ihre Einagbe!' TYPE 'I'.
*        ELSEIF lv_fil1-mdbes < ( lv_fil1-akbes - ls_uml-menge ).
*          MESSAGE ' Der Minimalbestand in der abgebenden Filiale 1 würde bei dieser Menge unterschritten werden! Bitte ändern Sie Ihre Einagbe!' TYPE 'I'.
*        ELSEIF lv_fil2-mdbes < ( lv_fil2-akbes - ls_uml-menge ).
*          MESSAGE ' Der Minimalbestand in der abgebenden Filiale 2 würde bei dieser Menge unterschritten werden! Bitte ändern Sie Ihre Einagbe!' TYPE 'I'.
*        ELSE.
*          " Prüfung erfolgreich
*        ENDIF.
*      ELSE.
*        UPDATE zsd_GRP1_uml FROM TABLE lt_uml.
*        MESSAGE 'Daten erfolgreich übertragen.' TYPE 'S'.
*      ENDIF.
*    ENDLOOP.

    INSERT zsd_GRP1_uml FROM TABLE lt_uml ACCEPTING DUPLICATE KEYS.


  ENDMETHOD.
ENDCLASS.

*SELECTION-SCREEN BEGIN OF SCREEN 1300 TITLE TEXT-300. "Umlagerung
SELECTION-SCREEN BEGIN OF BLOCK c1 WITH FRAME TITLE TEXT-301.
  PARAMETERS: p_fil_a  TYPE zsd_grp1_fsnu OBLIGATORY VALUE CHECK,
              p_artnr1 TYPE zsd_grp1_sw-artnr OBLIGATORY VALUE CHECK,
              p_mengea TYPE menge_d OBLIGATORY VALUE CHECK,
              p_bwart  TYPE bwart OBLIGATORY VALUE CHECK.
SELECTION-SCREEN END OF BLOCK c1.
SELECTION-SCREEN BEGIN OF BLOCK c2 WITH FRAME TITLE TEXT-302.
  PARAMETERS: p_filnr1 TYPE zsd_grp1_fsnu OBLIGATORY VALUE CHECK,
              p_meng1  TYPE menge_d OBLIGATORY VALUE CHECK.
SELECTION-SCREEN END OF BLOCK c2.
SELECTION-SCREEN BEGIN OF BLOCK c3 WITH FRAME TITLE TEXT-303.
  PARAMETERS: p_filnr2 TYPE zsd_grp1_fsnu OBLIGATORY VALUE CHECK,
              p_meng2  TYPE menge_d OBLIGATORY VALUE CHECK.
SELECTION-SCREEN END OF BLOCK c3.
*SELECTION-SCREEN END OF SCREEN 1300.

START-OF-SELECTION.

  DATA lo_umlagerung TYPE REF TO lcl_umlagerung.
  CREATE OBJECT lo_umlagerung.

  lo_umlagerung->uml_tab_bef(
  EXPORTING
       i_fil_a  =   p_fil_a
       i_artnr1 =   p_artnr1
       i_mengea =   p_mengea
       i_bwart  =   p_bwart
       i_filnr1 =   p_filnr1
       i_meng1  =   p_meng1
       i_filnr2 =   p_filnr2
       i_meng2  =   p_meng2

        ).




*  IF sy-subrc = 0.
** Wenn Lock gesetzt, dann
**  UPDATE sflight SET ...
*    IF sy-subrc = 0.
*      COMMIT WORK.
*    ELSE.
*      ROLLBACK WORK.
*    ENDIF.
*  ELSE.
*    WRITE: / 'Lock konnte nicht gesetzt werden.'.
*  ENDIF.




*IF (ls_uml-menge ls_uml-menge .
*
*ENDIF.
*
*    SELECT SINGLE FOR UPDATE artikelnummer, vp_brutto, mvp_brutto FROM zsd_grp1_arst
*    WHERE artikelnummer = @im_anr_v
*    INTO @DATA(preisaenderung).
*    IF sy-subrc = 0.
*      IF im_vkcha <= preisaenderung-vp_brutto * '1.25'.
*        UPDATE zsd_grp2_arst SET vp_brutto = im_vkcha WHERE artikelnummer = im_anr_v.
*
*        IF sy-subrc = 0.
*          COMMIT WORK.
*          MESSAGE s005 WITH preisaenderung-artikelnummer im_vkcha.
*        ELSE.
*          ROLLBACK WORK.
*          MESSAGE e001 WITH preisaenderung-artikelnummer im_vkcha.
*        ENDIF.
*      ENDIF.
