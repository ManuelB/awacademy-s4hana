*&---------------------------------------------------------------------*
*& Include          ZSD_GRP1_DEALINGSWEETSF01
*&---------------------------------------------------------------------*

CLASS lcl_mp1_grp1 IMPLEMENTATION.

  METHOD neupreis.

    SELECT SINGLE * FROM zsd_grp1_sw INTO @DATA(ls_preis) WHERE artnr = @im_artnr.
    IF sy-subrc = 0.
      IF im_neupr <= ls_preis-vkpreis * '1.25'.
        UPDATE zsd_grp1_sw
        SET vkpreis = @im_neupr,
         datum = @sy-datum,
                  userid = @sy-uname
                  WHERE artnr = @ls_preis-artnr.
        IF sy-subrc = 0.
          COMMIT WORK.
          MESSAGE s006 WITH ls_preis-artnr.
        ENDIF.
      ELSE.
        MESSAGE e004.
      ENDIF.
    ELSE.
      MESSAGE e001.
    ENDIF.

  ENDMETHOD.

**********************************************************************

  METHOD warenbestand.

    SELECT sw~artnr, sw~artname, sw~artgr,
           bes~akbes
      FROM zsd_grp1_sw AS sw
      LEFT JOIN zsd_grp1_bes AS bes ON sw~artnr = bes~artnr
      WHERE sw~artgr = @im_artgr
      ORDER BY artgr
      INTO TABLE @DATA(bestand).

    IF sy-subrc <> 0.
      MESSAGE e002.
    ELSE.
      cl_demo_output=>display( bestand ).
    ENDIF.

  ENDMETHOD.

**********************************************************************

  METHOD auslisten.

    SELECT sw~artnr, sw~activeflag, bes~akbes, bes~mdbes
      FROM zsd_grp1_sw AS sw
      LEFT JOIN zsd_dd_grp1_bes AS bes ON sw~artnr = bes~artnr
      WHERE sw~artnr = @im_artnr
      INTO @DATA(ls_artnr).
    ENDSELECT.

    IF sy-subrc = 0.
      IF ls_artnr-akbes > ls_artnr-mdbes.
        MESSAGE e007 WITH ls_artnr-artnr ls_artnr-akbes ls_artnr-mdbes.
      ELSE.
        UPDATE zsd_grp1_sw SET activeflag = ' ' WHERE artnr = @im_artnr.
        MESSAGE: s005 WITH artnr.
      ENDIF.
    ELSE.
      MESSAGE e001.
    ENDIF.

  ENDMETHOD.

ENDCLASS.


**********************************************************************
**********************************************************************

CLASS lcl_filiale IMPLEMENTATION.
  METHOD new_filiale.
    DATA: ls_newfiliale TYPE zsd_grp1_fs.
    ls_newfiliale-filname = im_filname.
    ls_newfiliale-Ort = ex_ort.
    ls_newfiliale-Strasse = ex_strasse.
    ls_newfiliale-Plz = ex_plz.
    ls_newfiliale-tel = ex_tel.
*case ex_tel.
*  when length = 7.
*  Message 'Toll!' Type 'S'.
*  when others.
*    message 'Nicht so toll!' Type 'E'.
*    endcase.
if ex_tel co '+#/ 0123456789'.
  commit work.
  else.
    message e017 raising invalid_telnr.
    endif.
    SELECT MAX( filnr ) FROM zsd_grp1_fs INTO ls_newfiliale-filnr.
    ls_newfiliale-filnr = ls_newfiliale-filnr + 5.
    ex_filnr = ls_newfiliale-filnr.

    INSERT INTO zsd_grp1_fs VALUES ls_newfiliale.
    CLEAR ls_newfiliale.
    UPDATE zsd_grp1_fs SET
            datum = @sy-datum,
            userid = @sy-uname.

  ENDMETHOD.

**********************************************************************

  METHOD filial_suche.
    SELECT SINGLE * FROM zsd_grp1_fs
            WHERE filnr =  @zsd_grp1_fs-filnr INTO @ls_num.
    IF sy-subrc <> 0.
      CLEAR zsd_grp1_fs.
    ENDIF.
  ENDMETHOD.

**********************************************************************

  METHOD filiale_pflegen.
    SELECT SINGLE FOR UPDATE filname, strasse, plz, ort, tel FROM zsd_grp1_fs
      WHERE filnr =  @im_filnr INTO @DATA(ls_fil).
    IF sy-subrc = 0.
      UPDATE zsd_grp1_fs SET
    filname = @zsd_grp1_fs-filname,
    strasse = @zsd_grp1_fs-strasse,
    plz = @zsd_grp1_fs-plz,
    ort = @zsd_grp1_fs-ort,
    tel = @zsd_grp1_fs-tel,
    userid = @sy-uname,
    datum = @sy-datum
    WHERE filnr = @zsd_grp1_fs-filnr.
      MESSAGE s010.
*if p_tel co '+#/ 0123456789'.
*  commit work.
*  else.
*    message e017 raising invalid_telnr.
*    endif.

     ENDIF.
    SET SCREEN 1201.
  ENDMETHOD.

**********************************************************************

  METHOD bestandsliste.
*    DELETE FROM zsd_grp1_uml.
*    INSERT zsd_GRP1_uml FROM TABLE lt_uml.
*    WRITE: / 'Umlagerung erfolgrewich durchgeführt!'.

  ENDMETHOD.
ENDCLASS.

**********************************************************************
**********************************************************************

CLASS lcl_umlagerung IMPLEMENTATION.
  METHOD relocc_succ.
CALL FUNCTION 'ENQUEUE_EZ_SP_UML_GRP1'
 EXPORTING
   MODE_ZSD_GRP1_UML       = 'E'
   MANDT                   = SY-MANDT
   FILIALNR                = 'i_fil_a' + 'i_filnr1' + 'i_filnr2'
*   ARTNR                   =
*   VERBUCHUNGSZEIT         =
*   X_FILIALNR              = ' '
*   X_ARTNR                 = ' '
*   X_VERBUCHUNGSZEIT       = ' '
   _SCOPE                  = '2'
*   _WAIT                   = ' '
*   _COLLECT                = ' '
* EXCEPTIONS
*   FOREIGN_LOCK            = 1
*   SYSTEM_FAILURE          = 2
*   OTHERS                  = 3
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.


    UPDATE zsd_grp1_bes SET akbes = @akbes_a
    WHERE artnr = @ls_uml-artnr AND filnr = @Filnr_a.

    UPDATE zsd_grp1_bes SET akbes = @akbes_1
    WHERE artnr = @ls_uml-artnr AND filnr = @Filnr_1.

    UPDATE zsd_grp1_bes SET akbes = @akbes_2
    WHERE artnr = @ls_uml-artnr AND filnr = @Filnr_2.

    IF sy-subrc = 0.
      MESSAGE s011.
    ELSE.
      MESSAGE e012.
    ENDIF.
 CALL FUNCTION 'DEQUEUE_EZ_SP_UML_GRP1'
  EXPORTING
   MODE_ZSD_GRP1_UML       = 'E'
   MANDT                   = SY-MANDT
   FILIALNR                = 'i_fil_a' + 'i_filnr1' + 'i_filnr2'
*    ARTNR                   =
*    VERBUCHUNGSZEIT         =
*    X_FILIALNR              = ' '
*    X_ARTNR                 = ' '
*    X_VERBUCHUNGSZEIT       = ' '
    _SCOPE                  = '3'
*    _SYNCHRON               = ' '
*    _COLLECT                = ' '
           .


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
    ENDIF.
    COMMIT WORK.




    IF i_mengea <> i_meng1 + i_meng2.

      RAISE menge_incons.
      LEAVE TO CURRENT TRANSACTION.
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
      MESSAGE e013.

    ENDIF.

    SELECT SINGLE *
FROM zsd_grp1_bes INTO @lv_fil1
 WHERE artnr = @i_artnr1
  AND filnr = @i_filnr1.
    IF sy-subrc = 0.
      COMMIT WORK.
    ELSE.
      MESSAGE e013.
    ENDIF.

    SELECT SINGLE *
FROM zsd_grp1_bes INTO @lv_fil2
WHERE artnr = @i_artnr1
AND filnr = @i_filnr2.
    IF sy-subrc = 0.
      COMMIT WORK.
    ELSE.
      MESSAGE e013.
    ENDIF.

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
      MESSAGE e012.
    ENDIF.


    LOOP AT lt_uml INTO ls_uml WHERE filialnr = i_fil_a.
      IF ls_uml-sollhaben = '+'.
        IF akbes_a > lv_fila-mxbes.
          MESSAGE i014 DISPLAY LIKE 'E'.
        ELSEIF lv_fil1-mdbes > akbes_1.
          MESSAGE i015 DISPLAY LIKE 'E'.
        ELSEIF lv_fil2-mdbes > akbes_2.
          MESSAGE i015 DISPLAY LIKE 'E'..
        ELSE.
          CALL METHOD relocc_succ.
          DATA lo_umlagerung TYPE REF TO lcl_umlagerung.
          CREATE OBJECT lo_umlagerung.
          lo_umlagerung->relocc_succ( ).
        ENDIF.

      ELSEIF ls_uml-sollhaben = '-'.
        IF akbes_a < lv_fila-mdbes.
          MESSAGE i015 DISPLAY LIKE 'E'.
        ELSEIF  akbes_1 > lv_fil1-mxbes.
          MESSAGE i014 DISPLAY LIKE 'E'.
        ELSEIF akbes_2 > lv_fil2-mxbes.
          MESSAGE i014 DISPLAY LIKE 'E'.
        ELSE.
          CALL METHOD relocc_succ.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
