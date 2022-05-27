*&---------------------------------------------------------------------*
*& Report ZSD_GRP1_UMLAGERN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsd_grp1_umlagern_db.


TABLES: zsd_GRP1_uml.
TABLES: zsd_GRP1_bes.
TYPES: lt TYPE zsd_grp1_uml.
DATA: lt_uml TYPE TABLE OF zsd_grp1_uml.
DATA: ls_uml  TYPE zsd_grp1_uml,
*      lt_uml  TYPE table of lt,
      lv_fila TYPE zsd_grp1_bes,
      lv_fil1 TYPE zsd_grp1_bes,
      lv_fil2 TYPE zsd_grp1_bes,
      Filnr_a TYPE zsd_grp1_bes-filnr,
      Filnr_1 TYPE zsd_grp1_bes-filnr,
      Filnr_2 TYPE zsd_grp1_bes-filnr,
      Menge_a TYPE zsd_grp1_bes-akbes,
      Menge_1 TYPE zsd_grp1_bes-akbes,
      Menge_2 TYPE zsd_grp1_bes-akbes,
      akbes_a TYPE zsd_grp1_bes-akbes,
      akbes_1 TYPE zsd_grp1_bes-akbes,
      akbes_2 TYPE zsd_grp1_bes-akbes.

CLASS lcl_umlagerung DEFINITION.
  PUBLIC SECTION.
    EVENTS:
      uml_succ.
*      exporting value(artnr) type lt-filialnr
*                value(filnr1) type lt-artnr
*                value(besa)  type lt-menge
*                value(flnr1) type lt-filialnr
*                value(bes1)  type lt-menge
*                value(flnr2) type lt-filialnr
*                value(bes2)  type lt-menge.

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
        ex_sollhaben TYPE lt-sollhaben
      EXCEPTIONS
        min_best
        max_best
        general_error
        menge_incons,
      relocc_succ FOR EVENT uml_succ OF lcl_umlagerung.
*    TABLES: zsd_GRP1_uml.
*    TABLES: zsd_GRP1_bes.
*    TYPES: lt TYPE zsd_grp1_uml.
*    DATA: ls_uml  TYPE lt,
*          lt_uml  TYPE TABLE OF lt,
*          lv_fila TYPE zsd_grp1_bes,
*          lv_fil1 TYPE zsd_grp1_bes,
*          lv_fil2 TYPE zsd_grp1_bes.
  PRIVATE SECTION.
ENDCLASS.



CLASS lcl_umlagerung IMPLEMENTATION.
  METHOD relocc_succ.
*select bes~filnr, bes~artnr, bes~akbes
*  from zsd_grp1_bes as bes
*  left join  zsd_grp1_uml as uml
*  on bes~artnr = uml~artnr AND bes~filnr = uml~filialnr into @data(umlagerung).
*    ENDSELECT.

*    SELECT SINGLE FOR UPDATE artnr, activeflag, akbes, mdbes FROM zsd_grp1_sw WHERE artnr = @im_artnr INTO @DATA(ls_artnr).

*    IF sy-subrc = 0.

*    SELECT SINGLE menge FROM lt_uml INTO @mengea WHERE menge = i_mengea.

    UPDATE zsd_grp1_bes SET akbes = @akbes_a
    WHERE artnr = @ls_uml-artnr AND filnr = @Filnr_a.

    UPDATE zsd_grp1_bes SET akbes = @akbes_1
    WHERE artnr = @ls_uml-artnr AND filnr = @Filnr_1.

    UPDATE zsd_grp1_bes SET akbes = @akbes_2
    WHERE artnr = @ls_uml-artnr AND filnr = @Filnr_2.
    IF sy-subrc = 0.
      MESSAGE |Die Umlagerung des Artikels mit der Artikelnummer { ls_uml-artnr } wurde für die Filialen { Filnr_a }, { Filnr_1 } und { Filnr_2 } erfolgreich verbucht!| TYPE 'S'.
    ELSE.
      MESSAGE 'Ein Fehler ist aufgetreten, die Aktion musste abgebrochen werden!' TYPE 'A'.
    ENDIF.
  ENDMETHOD.

  METHOD uml_tab_bef.
    ls_uml-filialnr = i_fil_a.
    ls_uml-artnr = i_artnr1.
    ls_uml-menge  = i_mengea.
    ls_uml-bwart = i_bwart.
    ls_uml-verbuchungszeit = sy-uzeit.
    ex_sollhaben = ls_uml-sollhaben.


******    Bewegung A
    IF i_bwart = '105'.
      ls_uml-sollhaben = '+'.
    ELSE.
      ls_uml-sollhaben = '-'.
    ENDIF.
    ls_uml-verbuchender = sy-uname.
    ls_uml-verbuchungsdatum = sy-datum.
    ls_uml-verbuchungszeit = sy-uzeit.
    ls_uml-menge = i_mengea.
    Menge_a = i_mengea.
    Filnr_a = i_fil_a.
    APPEND ls_uml TO lt_uml.
    INSERT zsd_grp1_uml FROM TABLE lt_uml ACCEPTING DUPLICATE KEYS.
    COMMIT WORK.


******    Bewegung 1
    ls_uml-filialnr = i_filnr1.
    IF i_bwart = '105'.
      ls_uml-bwart = '106'.
      ls_uml-sollhaben = '-'.
    ELSE.
      ls_uml-bwart = '105'.
      ls_uml-sollhaben = '+'.
    ENDIF.
    ls_uml-menge = i_meng1.
    Menge_1 = i_meng1.
    Filnr_1 = i_filnr1.
    APPEND ls_uml TO lt_uml.
    INSERT zsd_grp1_uml FROM TABLE lt_uml ACCEPTING DUPLICATE KEYS.
    COMMIT WORK.


******    Bewegung 2
    IF i_filnr2 IS NOT INITIAL AND i_meng2 IS NOT INITIAL.
      ls_uml-filialnr = i_filnr2.
      IF i_bwart = '105'.
        ls_uml-bwart = '106'.
        ls_uml-sollhaben = '-'.
      ELSE.
        ls_uml-bwart = '105'.
        ls_uml-sollhaben = '+'.
      ENDIF.
      ls_uml-menge = i_meng2.
      Menge_2 = i_meng2.
      Filnr_2 = i_filnr2.
      APPEND ls_uml TO lt_uml.
      INSERT zsd_grp1_uml FROM TABLE lt_uml ACCEPTING DUPLICATE KEYS.
    ELSE.
*      MESSAGE 'Inkonsistente Eingabe. Bitte prüfen Sie Ihre Einagbe!' TYPE 'I'.
      RAISE general_error.
    ENDIF.
    COMMIT WORK.




    IF i_mengea <> i_meng1 + i_meng2.
*      MESSAGE 'Die Verteilung der Artikelmengen stimmt nicht überein! Bitte prüfen Sie Ihre Einagbe!' TYPE 'I'.
      RAISE menge_incons.
      LEAVE TO CURRENT TRANSACTION. " Leave to screen 1300.
    ELSE.
      COMMIT WORK.
    ENDIF.

    SELECT SINGLE *
      FROM zsd_grp1_bes INTO @lv_fila
       WHERE artnr = @i_artnr1
        AND filnr = @i_fil_a.
    IF sy-subrc = 0.
      COMMIT WORK.
    ELSE.
      MESSAGE |Der Artikel mit der Artikelnummer { i_artnr1 } ist in der Filiale { i_fil_a } nicht in den Bestandsdaten aufgeführt, bitte wählen Sie einen anderen Artikel aus!| TYPE 'I' DISPLAY LIKE 'E'.
    ENDIF.

    SELECT SINGLE *
FROM zsd_grp1_bes INTO @lv_fil1
 WHERE artnr = @i_artnr1
  AND filnr = @i_filnr1.
    IF sy-subrc = 0.
      COMMIT WORK.
    ELSE.
      MESSAGE |Der Artikel mit der Artikelnummer { i_artnr1 } ist in der Filiale { i_filnr1 } nicht in den Bestandsdaten aufgeführt, bitte wählen Sie einen anderen Artikel aus!| TYPE 'I' DISPLAY LIKE 'E'.
    ENDIF.

    SELECT SINGLE *
FROM zsd_grp1_bes INTO @lv_fil2
WHERE artnr = @i_artnr1
AND filnr = @i_filnr2.
    IF sy-subrc = 0.
      COMMIT WORK.
    ELSE.
      MESSAGE |Der Artikel mit der Artikelnummer { i_artnr1 } ist in der Filiale { i_filnr2 } nicht in den Bestandsdaten aufgeführt, bitte wählen Sie einen anderen Artikel aus!| TYPE 'I' DISPLAY LIKE 'E'.
    ENDIF.

*    LOOP AT lt_uml INTO ls_uml WHERE zsd_grp1_bes-filnr = i_fila or filnr = i_filn1 or filnr = i_filnr2 and artnr = i_artnr1.
*      IF sy-subrc = 0.
*        COMMIT WORK.
*      ELSE.
*        MESSAGE 'Der zu umlagernde Artikel ist in einer der Filialen nicht vorhanden!' TYPE 'I' DISPLAY LIKE 'E'.
*      ENDIF.
*    ENDLOOP.

    SELECT SINGLE mdbes, mxbes , akbes FROM zsd_grp1_bes
     WHERE artnr = @i_artnr1
     AND filnr = @i_fil_a
     INTO @DATA(ls_bes_a).

    SELECT SINGLE mdbes, mxbes , akbes FROM zsd_grp1_bes
           WHERE artnr = @i_artnr1
           AND filnr = @i_filnr1
           INTO @DATA(ls_bes_1).

    SELECT SINGLE mdbes, mxbes , akbes FROM zsd_grp1_bes
         WHERE artnr = @i_artnr1
         AND filnr = @i_filnr1
         INTO @DATA(ls_bes_2).



    IF i_bwart = 105.
      akbes_a = ls_bes_a-akbes + Menge_1 + Menge_2.
      akbes_1 = ls_bes_1-akbes - Menge_1.
      akbes_2 = ls_bes_2-akbes - Menge_2.
    ELSEIF i_bwart = 106.
      akbes_a = ls_bes_a-akbes - ( Menge_1 + Menge_2 ).
      akbes_1 = ls_bes_1-akbes + Menge_1.
      akbes_2 = ls_bes_2-akbes + Menge_2.
    ELSE.
      MESSAGE |Fehler!| TYPE 'E'.
    ENDIF.


    LOOP AT lt_uml INTO ls_uml WHERE filialnr = i_fil_a.
      IF ls_uml-sollhaben = '+'.
        IF akbes_a > lv_fila-mxbes.
          MESSAGE |Der Maximalbestand in der aufnehmenden Filiale { i_fil_a } würde bei dieser Menge überschritten werden! Bitte ändern Sie Ihre Einagbe!| TYPE 'I'.
        ELSEIF lv_fil1-mdbes > akbes_1.
          MESSAGE |Der Minimalbestand in einer der Filialen würde { i_filnr1 } bei dieser Artikelbewegung unterschritten werden| TYPE 'I'.
        ELSEIF lv_fil2-mdbes > akbes_2.
          MESSAGE |Der Minimalbestand in einer der Filialen würde { i_filnr2 } bei dieser Artikelbewegung unterschritten werden| TYPE 'I'.
        ELSE.
          CALL METHOD relocc_succ.
          DATA lo_umlagerung TYPE REF TO lcl_umlagerung.
          CREATE OBJECT lo_umlagerung.
          lo_umlagerung->relocc_succ( ).
        ENDIF.

      ELSEIF ls_uml-sollhaben = '-'.
        IF akbes_a < lv_fila-mdbes.
          MESSAGE |Der Minimalbestand in der abgebenden Filiale { i_fil_a } würde bei dieser Warenbewegung unterschritten werden! Bitte ändern Sie Ihre Einagbe!| TYPE 'I'.
        ELSEIF  akbes_1 > lv_fil1-mxbes.
          MESSAGE |Der Maximalbestand in der aufnehmenden Filiale { i_filnr1 }würde bei dieser Menge überschritten werden! Bitte ändern Sie Ihre Einagbe!| TYPE 'I'.
        ELSEIF akbes_2 > lv_fil2-mxbes.
          MESSAGE |Der Maximalbestand in der aufnehmenden Filiale { i_filnr2 }würde bei dieser Menge überschritten werden! Bitte ändern Sie Ihre Einagbe!| TYPE 'I'.
        ELSE.
          CALL METHOD relocc_succ.
        ENDIF.
      ENDIF.
    ENDLOOP.



*    LOOP AT lt_uml INTO ls_uml WHERE filialnr = i_fil_a.
*
*      CASE ls_uml-sollhaben.
*        WHEN ex_sollhaben.
*          ls_uml-sollhaben = '+'.
*          IF akbes_a > lv_fila-mxbes.
*            MESSAGE |Der Maximalbestand in der aufnehmenden Filiale { i_fil_a } würde bei dieser Menge überschritten werden! Bitte ändern Sie Ihre Einagbe!| TYPE 'I'.
*
*          ELSEIF lv_fil1-mdbes > akbes_1.
*            MESSAGE |Der Minimalbestand in einer der Filialen würde { i_filnr1 } bei dieser Artikelbewegung unterschritten werden| TYPE 'I'.
*          ELSEIF lv_fil2-mdbes > akbes_2.
*            MESSAGE |Der Minimalbestand in einer der Filialen würde { i_filnr2 } bei dieser Artikelbewegung unterschritten werden| TYPE 'I'.
*          ELSE.
*            CALL METHOD relocc_succ.
*            DATA lo_umlagerung TYPE REF TO lcl_umlagerung.
*            CREATE OBJECT lo_umlagerung.
*            lo_umlagerung->relocc_succ( ).
*          ENDIF.
*
*
*        WHEN ex_sollhaben.
*          ls_uml-sollhaben = '-'.
*          IF lv_fila-mdbes < akbes_a.
*            MESSAGE |Der Minimalbestand in der abgebenden Filiale { i_fil_a } würde bei dieser Warenbewegung unterschritten werden! Bitte ändern Sie Ihre Einagbe!| TYPE 'I'.
*
*          ELSEIF lv_fil1-mxbes < akbes_1.
*            MESSAGE |Der Maximalbestand in der aufnehmenden Filiale { i_filnr1 }würde bei dieser Menge überschritten werden! Bitte ändern Sie Ihre Einagbe!| TYPE 'I'.
*
*          ELSEIF lv_fil2-mxbes < akbes_2.
*            MESSAGE |Der Maximalbestand in der aufnehmenden Filiale { i_filnr2 }würde bei dieser Menge überschritten werden! Bitte ändern Sie Ihre Einagbe!| TYPE 'I'.
*          ELSE.
*            CALL METHOD relocc_succ.
*            lo_umlagerung->relocc_succ( ).
*          ENDIF.
*        WHEN OTHERS.
*      ENDCASE.





  ENDMETHOD.

ENDCLASS.

*SELECTION-SCREEN BEGIN OF SCREEN 1300 TITLE TEXT-300. "Umlagerung
SELECTION-SCREEN BEGIN OF BLOCK c1 WITH FRAME TITLE TEXT-301.
  PARAMETERS: p_fil_a  TYPE zsd_grp1_fsnu DEFAULT '10' OBLIGATORY VALUE CHECK,
              p_artnr1 TYPE zsd_grp1_sw-artnr DEFAULT '16' OBLIGATORY VALUE CHECK,
              p_mengea TYPE menge_d OBLIGATORY VALUE CHECK,
              p_bwart  TYPE bwart OBLIGATORY VALUE CHECK.
SELECTION-SCREEN END OF BLOCK c1.
SELECTION-SCREEN BEGIN OF BLOCK c2 WITH FRAME TITLE TEXT-302.
  PARAMETERS: p_filnr1 TYPE zsd_grp1_fsnu DEFAULT '15' OBLIGATORY VALUE CHECK,
              p_meng1  TYPE menge_d OBLIGATORY VALUE CHECK.
SELECTION-SCREEN END OF BLOCK c2.
SELECTION-SCREEN BEGIN OF BLOCK c3 WITH FRAME TITLE TEXT-303.
  PARAMETERS: p_filnr2 TYPE zsd_grp1_fsnu DEFAULT '20' OBLIGATORY VALUE CHECK,
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
   i_meng2  =   p_meng2 ).
