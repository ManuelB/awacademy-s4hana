*&---------------------------------------------------------------------*
*& Include          ZSD_GRP2_DEALINGSWEETSF01
*&---------------------------------------------------------------------*
CLASS lcl_miniprojekt IMPLEMENTATION.

*  METHOD such_methode.
**    im_artnr = p_artnr.  "such Parameter"
*    SELECT SINGLE * INTO  ex_stam
*      FROM zsd_grp2_arst
*      WHERE artikelnummer = im_artnr.
*
*  ENDMETHOD.



  METHOD auslisten.


    SELECT SINGLE * FROM zsd_grp2_arst INTO @DATA(ls_artnr) WHERE artikelnummer = @im_artnr.
    SELECT SINGLE * FROM zsd_grp2_bes INTO @DATA(ls_bes) WHERE artikelnummer = @im_artnr.
*    IF im_artnr = ls_artnr-artikelnummer.
*   IF ls_bes-mindestbestand > ls_bes-akt_lagerbestand.



    IF sy-subrc = 0.
**
      IF ls_bes-akt_lagerbestand > ls_bes-mindestbestand.
        MESSAGE e002.
      ELSE.
        UPDATE zsd_grp2_arst
               SET activeflag = ' ',
                   dat_anlage = @sy-datum,
                   user_name_anlage = @sy-uname
               WHERE artikelnummer = @im_artnr AND activeflag = 'X'.
      ENDIF.
    ELSE.
      MESSAGE e008.
    ENDIF.



  ENDMETHOD.



  METHOD vkchange.
*    im_artnr_v = p_artnr.  "Suchparameter Artikelnummer
*    im_vkcha = p_neupr.  "Eingabeparameter neuer Verkaufspreis


    SELECT SINGLE * FROM zsd_grp2_arst INTO @DATA(x) WHERE artikelnummer = @im_anr_v.
    IF im_anr_v = x-artikelnummer.
      IF x-vp_brutto * '1.25' >= im_vkcha.
        UPDATE zsd_grp2_arst
              SET vp_brutto = @im_vkcha,
                dat_anlage = @sy-datum,
                user_name_anlage = @sy-uname
              WHERE artikelnummer = @im_anr_v.
        MESSAGE s005 WITH im_anr_v im_vkcha .
*        MESSAGE |Der Artikelpreis wurde erfolgreich auf { im_preis } € geändert!| TYPE 'I'.
      ELSE.
*         MESSAGE e001 WITH im_vkcha.
        MESSAGE e001 WITH im_anr_v im_vkcha.
      ENDIF.
      IF sy-subrc <> 0.
        MESSAGE e001 WITH im_anr_v im_vkcha.
*     MESSAGE e000 WITH im_artnr.
      ELSE.
        COMMIT WORK.
        MESSAGE s005 WITH im_anr_v im_vkcha.
*        sucess
        COMMIT WORK.
      ENDIF.
    ELSE.
      MESSAGE e000 WITH im_anr_v.
    ENDIF.






**hier nochmal drüber schauen.
*    SELECT SINGLE FOR UPDATE artikelnummer, vp_brutto, mvp_brutto FROM zsd_grp2_arst
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
*
*    ELSE.
*      MESSAGE e008.
**    MESSAGE |Der Artikel ist nicht vorhanden!| TYPE 'E'.
*    ENDIF.
*
  ENDMETHOD.

*
  METHOD waren_bst_liste.
*
    SELECT a~Artikelgruppe, a~Artikelnummer, a~artikelname, b~akt_lagerbestand , a~vp_brutto FROM zsd_grp2_arst AS a
      LEFT OUTER JOIN zsd_grp2_bes AS b ON a~Artikelnummer = b~Artikelnummer
      WHERE artikelgruppe = @im_artgruppe
      ORDER BY  a~artikelgruppe, a~artikelnummer, artikelname, akt_lagerbestand, vp_brutto
    INTO TABLE @DATA(ex_stam2).

    IF sy-subrc <> 0.
      MESSAGE e006.
    ELSE.
      cl_demo_output=>display( ex_stam2 ).
    ENDIF.
*
*
*
  ENDMETHOD.

  METHOD neuartikel.
    DATA: ls_neuart TYPE zsd_grp2_arst,
*          lt_neuart TYPE TABLE OF zsd_grp2_arst
          ls_neubes TYPE zsd_grp2_bes.

*Für Tabelle zsd_grp2_arst.

    " ls_neuart-artikelnummer = ex_artnum.
    ls_neuart-artikelname = IM_artnam.
    ls_neuart-artikelgruppe = im_artgr.
    ls_neuart-ek_netto = im_ekneto.
    ls_neuart-mvp_brutto = im_mvp_bruto.
    ls_neuart-vp_brutto = im_vpbruto.
    ls_neuart-activeflag = im_active.
    ls_neuart-waehrung = im_wae.
    ls_neuart-dat_anlage = im_datum.
    ls_neuart-user_name_anlage = im_user.


* Für Tabelle zsd_grp2_bes.
    "  ls_neubes-artikelnummer = ex_artnum2.
    ls_neubes-filialnummer = im_fili.
    ls_neubes-mindestbestand = im_mind.
    ls_neubes-maximalbestand = im_max.
    ls_neubes-akt_lagerbestand = im_lag.
    ls_neubes-menge_einheit = im_meng.





********next free number *************




    SELECT MAX( artikelnummer ) FROM zsd_grp2_arst INTO ls_neuart-artikelnummer.
    ls_neuart-artikelnummer = ls_neuart-artikelnummer + 1.
    ex_artnum = ls_neuart-artikelnummer.

    SELECT MAX( artikelnummer ) FROM zsd_grp2_arst INTO ls_neubes-artikelnummer.
    ls_neubes-artikelnummer = ls_neubes-artikelnummer + 1.
    ex_artnum2 = ls_neubes-artikelnummer.


******** insert values into table********
* SELECT * FROM zsd_grp2_filbest
*    INTO @DATA(x).
*   endselect.

* if im_fili NE x-filialnummer.
*   MESSAGE e009 with im_fili.
*  else.

    IF ls_neubes-mindestbestand GE ls_neubes-maximalbestand. "if #1
      MESSAGE e019 WITH im_max im_mind.
    ELSE.
      IF ls_neubes-akt_lagerbestand LE ls_neubes-mindestbestand.
        MESSAGE w022 WITH im_lag im_mind.
      ELSE.

        IF ls_neubes-akt_lagerbestand GE ls_neubes-maximalbestand.
          MESSAGE w023 WITH im_lag im_max.
        ELSE.

          IF ls_neuart-mvp_brutto GE ls_neuart-vp_brutto. "if #2
            MESSAGE e020 WITH im_vpbruto im_mvp_bruto.
          ELSE.


            INSERT INTO zsd_grp2_bes VALUES ls_neubes.
*    CLEAR ls_neubes.

            INSERT INTO zsd_grp2_arst VALUES ls_neuart.
*    CLEAR ls_neuart.
*
            MESSAGE i003 WITH ex_artnum.

          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
*endif.




  ENDMETHOD.

ENDCLASS.


CLASS lcl_filiale IMPLEMENTATION.
  METHOD neuanlage.
    DATA: ls_neufil TYPE zsd_grp2_filbest,
          lt_neufil TYPE TABLE OF zsd_grp2_filbest,
          lv_zahl   TYPE string.


    ls_neufil-filialbezeichnung = im_filbez.
    ls_neufil-ort = im_ort.
    ls_neufil-strasse = im_str.
    ls_neufil-plz = im_plz.
    ls_neufil-telefon = im_tel.
    ls_neufil-benutzer =  im_user.
    ls_neufil-datum = im_datum.

********next free number *************


    SELECT MAX( filialnummer ) FROM zsd_grp2_filbest INTO ls_neufil-filialnummer.
    ls_neufil-filialnummer = ls_neufil-filialnummer + 5.
    ex_filnum = ls_neufil-filialnummer.



******** insert values into table********

    IF im_tel CO '+ 0123456789'.

      INSERT INTO zsd_grp2_filbest VALUES ls_neufil.
      CLEAR ls_neufil.

      MESSAGE i011 WITH ex_filnum.

    ELSE.
      MESSAGE e024.
    ENDIF.

  ENDMETHOD.

  METHOD pflege.

    DATA: ls_neufil TYPE zsd_grp2_filbest,
          lt_neufil TYPE TABLE OF zsd_grp2_filbest.


    SELECT SINGLE * FROM zsd_grp2_filbest INTO @DATA(ls_data)
        WHERE filialnummer = @im_filnum.



*ex_filbez = ls_exporting-filialbezeichnung.
*ex_ort = ls_exporting-ort.
*ex_str = ls_exporting-strasse.
*ex_plz = ls_exporting-plz.
*ex_tel = ls_exporting-telefon.
*ex_user = ls_exporting-benutzer.
*ex_datum = ls_exporting-datum.


    IF im_tel CO '+ 0123456789'.
      IF im_filnum = ls_data-filialnummer.

        UPDATE zsd_grp2_filbest
      SET
    filialbezeichnung = @im_filbez,
    ort = @im_ort,
    strasse = @im_str,
    plz = @im_plz,
    telefon = @im_tel,
    benutzer =  @im_user
*DATUM = ex_datum
    WHERE filialnummer = @im_filnum.

        MESSAGE i010 WITH im_filnum.
*
      ELSE.
*
        MESSAGE e009 WITH im_filnum.

*    ls_neufil-filialbezeichnung = im_filbez.
      ENDIF.
    ELSE.
      MESSAGE e024.
    ENDIF.
    CLEAR ls_data.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_umlagerung IMPLEMENTATION.

  METHOD pruefen_menge.
    re_men = im_men1 + im_men2.
  ENDMETHOD .

  METHOD update_bestand_tbl.

    SELECT SINGLE FOR UPDATE * INTO @DATA(x)
  FROM zsd_grp2_bes
WHERE artikelnummer = @art_nr AND filialnummer = @flnr1.   "datenbanksperre ist gesetzt

    IF sy-subrc = 0.
      UPDATE zsd_grp2_bes SET akt_lagerbestand = @bes1
    WHERE artikelnummer = @art_nr AND filialnummer = @flnr1.
      IF sy-subrc = 0.
        WRITE: / 'LagerBestand für filiale:', flnr1, 'ist aktualisiert'.
      ENDIF.
    ENDIF.








    UPDATE zsd_grp2_bes SET akt_lagerbestand = @bes2
    WHERE artikelnummer = @art_nr AND filialnummer = @flnr2.
    IF sy-subrc = 0.
      WRITE: / 'LagerBestand für filiale:', flnr2, 'ist aktualisiert'.
    ENDIF.



    UPDATE zsd_grp2_bes SET akt_lagerbestand = @bes3
    WHERE artikelnummer = @art_nr AND filialnummer = @flnr3.
    IF sy-subrc = 0.
      WRITE: / 'LagerBestand für filiale:', flnr3, 'ist aktualisiert'.
    ENDIF.

  ENDMETHOD.


  METHOD fill_umlagerung_tbl.

    DATA : ls_umlagerung TYPE zsd_grp2_umlag,
           lt_umlagerung TYPE TABLE OF zsd_grp2_umlag,

           bs1           TYPE zsd_grp2_umlag-menge,
           bs2           TYPE zsd_grp2_umlag-menge,
           bs3           TYPE zsd_grp2_umlag-menge.
    DATA(utc) = utclong_current( ).



    IF im_bwgng = '105'. "Zugang

      SELECT SINGLE mindestbestand, maximalbestand , akt_lagerbestand FROM zsd_grp2_bes
       WHERE artikelnummer = @im_arl_nr
       AND filialnummer = @im_flnr1
       INTO @DATA(ls1_bestand).
      IF sy-subrc = 0.
        IF ls1_bestand-maximalbestand < im_menge1 + ls1_bestand-akt_lagerbestand.
*          WRITE : 'Die Filiale:' , im_flnr1, 'kann diese Menge nicht annehmen, da sonst der Maximalbestand überschritten wird'.
          MESSAGE e013 WITH im_flnr1.
          EXIT.
        ENDIF.
      ELSE.
*        WRITE : 'Die filiale : ', im_flnr1, ' verfügt über kein Inventar für diesen Artikel'.
        MESSAGE e015 WITH im_flnr1.
        EXIT.
      ENDIF.


      SELECT SINGLE mindestbestand, maximalbestand , akt_lagerbestand FROM zsd_grp2_bes
      WHERE artikelnummer = @im_arl_nr
      AND filialnummer = @im_flnr2
      INTO @DATA(ls2_bestand).
      IF sy-subrc = 0.
        IF ls2_bestand-mindestbestand > ls2_bestand-akt_lagerbestand - im_menge2.
*          WRITE : 'Die Filiale:', im_flnr2,' kann diese Menge nicht abgeben, da sonst der Minimalbestand nicht eingehalten wird'.
          MESSAGE e014 WITH im_flnr2.
          EXIT.
        ENDIF.
      ELSE.
*        WRITE : 'Die filiale : ', im_flnr2, ' verfügt über kein Inventar für diesen Artikel'.
        MESSAGE e015 WITH im_flnr2.
        EXIT.
      ENDIF.

      IF im_flnr3 IS NOT INITIAL.
        SELECT SINGLE mindestbestand, maximalbestand , akt_lagerbestand FROM zsd_grp2_bes
       WHERE artikelnummer = @im_arl_nr
       AND filialnummer = @im_flnr3
       INTO @DATA(ls3_bestand).
        IF sy-subrc = 0.
          IF ls3_bestand-mindestbestand > ls3_bestand-akt_lagerbestand - im_menge3.
*            WRITE : 'Die Filiale:', im_flnr3,' kann diese Menge nicht abgeben, da sonst der Minimalbestand nicht eingehalten wird'.
            MESSAGE e014 WITH im_flnr3.
            EXIT.
          ENDIF.
        ELSE.
*          WRITE : 'Die filiale : ', im_flnr3, ' verfügt über kein Inventar für diesen Artikel'.
          MESSAGE e015 WITH im_flnr3.
          EXIT.
        ENDIF.
      ENDIF.




      ls_umlagerung-filial_nr = im_flnr1.
      ls_umlagerung-artikel_nr = im_arl_nr.
      ls_umlagerung-menge = im_menge1.
      ls_umlagerung-mengeneinheit = 'ST'.
      ls_umlagerung-bewegungsart = im_bwgng. " bewegungsart = 105 ausgeliefert
      ls_umlagerung-soll_haben = '+'.
      ls_umlagerung-verbuchende = sy-uname.
      ls_umlagerung-verbuchungsdatum = sy-datum.
      ls_umlagerung-verbuchungszeit = sy-uzeit.
      ls_umlagerung-beleg_zeit = utc.
*    INSERT zsd_grp2_umlag FROM ls_umlagerung.
*    COMMIT WORK.
      APPEND ls_umlagerung TO lt_umlagerung.


* *********************Werte ausfüllen für 2 Warenbewegung

      ls_umlagerung-filial_nr = im_flnr2.
      ls_umlagerung-bewegungsart = '106'. "Bewegungsart = abgang(outflow)
      ls_umlagerung-soll_haben = '-'.
      ls_umlagerung-menge = im_menge2.
      ls_umlagerung-beleg_zeit = utc.
      APPEND ls_umlagerung TO lt_umlagerung.
*    INSERT zsd_grp2_umlag FROM ls_umlagerung.
*    COMMIT WORK.

*********************  Werte ausfüllen für 3 Warenbewegung

      IF im_flnr3 IS NOT INITIAL.
        ls_umlagerung-filial_nr = im_flnr3.
        ls_umlagerung-bewegungsart = '106'.
        ls_umlagerung-soll_haben = '-'.
        ls_umlagerung-menge = im_menge3.
        ls_umlagerung-beleg_zeit = utc.
      ENDIF.
      APPEND ls_umlagerung TO lt_umlagerung.

*      MODIFY zsd_grp2_umlag FROM TABLE lt_umlagerung.
      INSERT zsd_grp2_umlag FROM TABLE lt_umlagerung.    "ACCEPTING DUPLICATE KEYS.

      IF sy-subrc = 0.
        COMMIT WORK.

        RAISE EVENT reloc_succ
        EXPORTING art_nr = im_arl_nr
          flnr1 = im_flnr1
          bes1 = im_menge1 + ls1_bestand-akt_lagerbestand
          flnr2 =  im_flnr2
          bes2 = ls2_bestand-akt_lagerbestand - im_menge2
             flnr3 =  im_flnr3
          bes3 = ls3_bestand-akt_lagerbestand - im_menge3.



      ENDIF.


*******************************    when the selected value is 106*********************
    ELSE.

      SELECT SINGLE mindestbestand, maximalbestand , akt_lagerbestand FROM zsd_grp2_bes
         WHERE artikelnummer = @im_arl_nr
         AND filialnummer = @im_flnr1
         INTO @DATA(ls4_bestand).
      IF sy-subrc = 0.
        IF ls4_bestand-mindestbestand > ls4_bestand-akt_lagerbestand - im_menge1.
*          WRITE : 'Die Filiale:', im_flnr1,' kann diese Menge nicht abgeben, da sonst der Minimalbestand nicht eingehalten wird'.
          MESSAGE e014 WITH im_flnr1.
          EXIT.
        ENDIF.
      ELSE.
*        WRITE : 'Die filiale : ', im_flnr1, ' verfügt über kein Inventar für diesen Artikel'.
        MESSAGE e015 WITH im_flnr1.
        EXIT.
      ENDIF.

      SELECT SINGLE mindestbestand, maximalbestand , akt_lagerbestand FROM zsd_grp2_bes
      WHERE artikelnummer = @im_arl_nr
      AND filialnummer = @im_flnr2
      INTO @DATA(ls5_bestand).
      IF sy-subrc = 0.
        IF ls5_bestand-maximalbestand < im_menge2 + ls5_bestand-akt_lagerbestand.
*          WRITE : 'Die Filiale:' , im_flnr2, 'kann diese Menge nicht annehmen, da sonst der Maximalbestand überschritten wird'.
          MESSAGE e013 WITH im_flnr2.
          EXIT.
        ENDIF.
      ELSE.
*        WRITE : 'Die filiale : ', im_flnr2, ' verfügt über kein Inventar für diesen Artikel'.
        MESSAGE e015 WITH im_flnr2.
        EXIT.
      ENDIF.


      IF im_flnr3 IS NOT INITIAL.
        SELECT SINGLE mindestbestand, maximalbestand , akt_lagerbestand FROM zsd_grp2_bes
       WHERE artikelnummer = @im_arl_nr
       AND filialnummer = @im_flnr3
       INTO @DATA(ls6_bestand).
        IF sy-subrc = 0.
          IF ls6_bestand-maximalbestand < im_menge3 + ls6_bestand-akt_lagerbestand.
*            WRITE : 'Die Filiale:', im_flnr3,' kann diese Menge nicht annehmen, da sonst der Minimalbestand nicht eingehalten wird'.
            MESSAGE e013 WITH im_flnr3.
            EXIT.
          ENDIF.
        ELSE.
*          WRITE : 'Die filiale : ', im_flnr3, ' verfügt über kein Inventar für diesen Artikel'.
          MESSAGE e015 WITH im_flnr3.
          EXIT.
        ENDIF.
      ENDIF.





      ls_umlagerung-filial_nr = im_flnr1.
      ls_umlagerung-artikel_nr = im_arl_nr.
      ls_umlagerung-menge = im_menge1.
      ls_umlagerung-mengeneinheit = 'ST'.
      ls_umlagerung-bewegungsart = im_bwgng. " bewegungsart = 106 ausgeliefert
      ls_umlagerung-soll_haben = '-'.
      ls_umlagerung-verbuchende = sy-uname.
      ls_umlagerung-verbuchungsdatum = sy-datum.
      ls_umlagerung-verbuchungszeit = sy-uzeit.
      ls_umlagerung-beleg_zeit = utc.
      APPEND ls_umlagerung TO lt_umlagerung.

* *********************Werte ausfüllen für 2 Warenbewegung

      ls_umlagerung-filial_nr = im_flnr2.
      ls_umlagerung-bewegungsart = '105'. "Bewegungsart = abgang(outflow)
      ls_umlagerung-soll_haben = '+'.
      ls_umlagerung-menge = im_menge2.
      ls_umlagerung-beleg_zeit = utc.
      APPEND ls_umlagerung TO lt_umlagerung.

*********************  Werte ausfüllen für 3 Warenbewegung

      IF im_flnr3 IS NOT INITIAL.
        ls_umlagerung-filial_nr = im_flnr3.
        ls_umlagerung-bewegungsart = '105'.
        ls_umlagerung-soll_haben = '+'.
        ls_umlagerung-menge = im_menge3.
        ls_umlagerung-beleg_zeit = utc.
      ENDIF.
      APPEND ls_umlagerung TO lt_umlagerung.

      INSERT zsd_grp2_umlag FROM TABLE lt_umlagerung.
      IF sy-subrc = 0.
        COMMIT WORK.

        RAISE EVENT reloc_succ
        EXPORTING art_nr = im_arl_nr
          flnr1 = im_flnr1
          bes1 = ls4_bestand-akt_lagerbestand - im_menge1
          flnr2 =  im_flnr2
          bes2 = ls5_bestand-akt_lagerbestand + im_menge2
             flnr3 =  im_flnr3
          bes3 = ls6_bestand-akt_lagerbestand + im_menge3.
      ELSE.
        MESSAGE e016.
      ENDIF.


    ENDIF.

  ENDMETHOD.
ENDCLASS.
