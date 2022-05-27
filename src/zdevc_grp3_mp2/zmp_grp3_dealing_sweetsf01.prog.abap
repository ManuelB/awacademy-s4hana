*&---------------------------------------------------------------------*
*& Include          ZMP_GRP3_DEALING_SWEETSF01
*&---------------------------------------------------------------------*


CLASS lcl_sweets IMPLEMENTATION.

  METHOD articlelist. " to get the warenbestandlist


    SELECT  sw~artikelnummer, sw~artikelname, sw~artikelgruppe,
               bes~aktueller_lagerbestand
          FROM zgrp3_sweets AS sw
          LEFT JOIN ZGRP3_Bestand AS bes ON sw~artikelnummer = bes~artikelnummer
          WHERE sw~artikelgruppe = @im_artgr
          ORDER BY artikelgruppe
          INTO TABLE @DATA(ex_list).


    IF sy-subrc <> 0.
      MESSAGE e012.
    ELSE.

      cl_demo_output=>display( ex_list ).
    ENDIF.
*
  ENDMETHOD.


  METHOD delistarticle. "to deactivate the article for selection

    SELECT sw~artikelnummer, sw~activeflag, bes~min_bestand, bes~aktueller_lagerbestand
      FROM  zgrp3_sweets AS sw
      LEFT JOIN zgrp3_bestand AS bes ON sw~artikelnummer = bes~artikelnummer
       WHERE sw~artikelnummer = @im_artnr
      INTO @DATA(x).
    ENDSELECT.

    IF im_artnr = x-artikelnummer.
      IF x-min_bestand > x-aktueller_lagerbestand.
        UPDATE zgrp3_sweets
            SET activeflag = ' ',
                datum = @sy-datum,
                uname = @sy-uname
            WHERE artikelnummer = @im_artnr AND activeflag = 'X'.
        MESSAGE |Der Artikel { im_artnr } wurde erfolgreich ausgelistet!| TYPE 'I'.
      ELSE.
        MESSAGE |Der Artikel { im_artnr } konnte nicht ausgelistet werden, da der aktuelle Lagerbestand von { x-aktueller_lagerbestand } höher ist als der erforderliche Mindestbestand von { x-min_bestand }!| TYPE 'E'.
        EXIT.
      ENDIF.
    ELSE.
      MESSAGE e000 WITH im_artnr.
      IF sy-subrc <> 0.
        MESSAGE e005 WITH im_artnr.
      ELSE.
        COMMIT WORK.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD newarticleprice. "to change the price
* import artikelnummer aus selection screen.

    SELECT SINGLE * FROM zgrp3_sweets INTO @DATA(x) WHERE artikelnummer = @im_artnr.
    IF im_artnr = x-artikelnummer.
      IF x-vk_brutto * '1.25' >= im_preis.
        UPDATE zgrp3_sweets
              SET vk_brutto = @im_preis,
                datum = @sy-datum,
                uname = @sy-uname
              WHERE artikelnummer = @im_artnr.
        MESSAGE |Der Artikelpreis wurde erfolgreich auf { im_preis } € geändert!| TYPE 'I'.
      ELSE.
        MESSAGE e002 WITH im_preis.
      ENDIF.
      IF sy-subrc <> 0.

      ELSE.
*        sucess
        COMMIT WORK.
      ENDIF.
    ELSE.
      MESSAGE e000 WITH im_artnr.
    ENDIF.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_filiale IMPLEMENTATION.

  METHOD new_branch. " implementing a new branch
    DATA: ls_newfil TYPE zgrp3_filstamm,
          lt_newfil TYPE TABLE OF zgrp3_filstamm.

    ls_newfil-filialbezeichnung = im_filname.
    ls_newfil-Ort = ex_ort.
    ls_newfil-Strasse = ex_strasse.
    ls_newfil-Plz = ex_plz.
    ls_newfil-telefon = ex_tel.
    ls_newfil-filialnummer = ex_filnr.


    SELECT MAX( filialnummer ) FROM zgrp3_filstamm INTO ls_newfil-filialnummer.
    ls_newfil-filialnummer = ls_newfil-filialnummer + 5.
    ex_filnr = ls_newfil-filialnummer.




    APPEND ls_newfil TO lt_newfil.
    INSERT zgrp3_filstamm FROM TABLE lt_newfil.


    UPDATE zgrp3_filstamm SET
            datum_anlage_aenderung = @sy-datum,
            name_anlage_aenderung = @sy-uname
            WHERE filialnummer = @ex_filnr .
    IF sy-subrc = 0.
      COMMIT WORK.
    ELSE.
      MESSAGE e016.
    ENDIF.



  ENDMETHOD.


  METHOD branch_maintenance. "maintening a existing branch
    SELECT SINGLE filialnummer INTO @DATA(filiale)
      FROM zgrp3_filstamm
      WHERE filialnummer = @im_filnr.

    IF sy-subrc = 0.
      CALL FUNCTION 'ENQUEUE_EY_EQ_BRANCH_3'
        EXPORTING
          mode_zgrp3_filstamm = 'E'
          mandant             = sy-mandt
          filialnummer        = im_filnr
          _scope              = '2'
          _wait               = 'X'
          _collect            = ' '
        EXCEPTIONS
          foreign_lock        = 1
          system_failure      = 2
          OTHERS              = 3.

      IF sy-subrc <> 0.
MESSAGE : |Die Filialdaten werden schon bearbeitet.| TYPE 'I'.
      ELSE.

        UPDATE zgrp3_filstamm SET
      Filialbezeichnung = @zgrp3_filstamm-Filialbezeichnung,
      strasse = @zgrp3_filstamm-strasse,
      plz = @zgrp3_filstamm-plz,
      ort = @zgrp3_filstamm-ort,
      telefon = @zgrp3_filstamm-telefon,
      name_anlage_aenderung = @sy-uname,
      datum_anlage_aenderung = @sy-datum
      WHERE filialnummer = @zgrp3_filstamm-filialnummer.
        IF sy-subrc = 0.
          COMMIT WORK.
          MESSAGE 'Die Filialdaten wurden erfolgreich geändert!' TYPE 'I'.
          CALL FUNCTION 'DEQUEUE_EY_EQ_BRANCH_3'
            EXPORTING
              mode_zgrp3_filstamm = 'E'
              mandant             = sy-mandt
              filialnummer        = im_filnr
              x_filialnummer      = ' '
              _scope              = '3'
              _synchron           = ' '
              _collect            = ' '.

        ELSE.
          MESSAGE e015.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.


ENDCLASS.


CLASS lcl_umlagerung IMPLEMENTATION." moving goods between branches

  METHOD   get_unit_for_article.

    SELECT SINGLE mengen_einheit FROM zgrp3_bestand INTO @re_unit
      WHERE artikelnummer = @im_artnr.
    IF sy-subrc <> 0.
      re_unit = 'ST'.
    ENDIF.

  ENDMETHOD.


  METHOD umlagern_zugang." the receiving branch receives the goods from at least one other branch
    DATA lv_filnr1_bestand TYPE zgrp3_bestand.
    DATA lv_filnr2_bestand TYPE zgrp3_bestand.
    DATA lv_filnr3_bestand TYPE zgrp3_bestand.
    DATA: ls_goodsmove TYPE zgrp3_bewegungen,
          lt_goodsmove TYPE TABLE OF zgrp3_bewegungen.
    DATA(utc) = utclong_current( ).


    IF im_filnr1 = im_filnr2 OR im_filnr1 = im_filnr3.
      MESSAGE e023.
    ENDIF.

    IF im_menge2 + im_menge3 <> im_menge1.
      RAISE EXCEPTION TYPE cx_falsche_menge.
    ENDIF.

    IF im_filnr3 = 0 AND im_menge3 <> 0.
      RAISE EXCEPTION TYPE cx_falsche_menge.
    ENDIF.

    SELECT SINGLE *
      FROM zgrp3_bestand INTO @lv_filnr2_bestand
       WHERE artikelnummer = @im_artnr
        AND filialnummer = @im_filnr2.

    IF ( lv_filnr2_bestand-aktueller_lagerbestand - im_menge2 ) < lv_filnr2_bestand-min_bestand.
      RAISE EXCEPTION TYPE cx_min_best.
    ENDIF.
    IF NOT im_filnr3 = ''.
      SELECT SINGLE *
        FROM zgrp3_bestand INTO @lv_filnr3_bestand
         WHERE artikelnummer = @im_artnr
          AND filialnummer = @im_filnr3.

      IF ( lv_filnr3_bestand-aktueller_lagerbestand - im_menge3 ) < lv_filnr3_bestand-min_bestand.
        RAISE EXCEPTION TYPE cx_min_best.
      ENDIF.
    ENDIF.

    SELECT SINGLE *
       FROM zgrp3_bestand INTO @lv_filnr1_bestand
        WHERE artikelnummer = @im_artnr
         AND filialnummer = @im_filnr1.

    IF ( lv_filnr1_bestand-aktueller_lagerbestand + im_menge1 ) > lv_filnr1_bestand-max_bestand.
      RAISE EXCEPTION TYPE cx_max_best.
    ENDIF.

    ls_goodsmove-mandant = sy-mandt.
    ls_goodsmove-artikelnummer = im_artnr.
    ls_goodsmove-filialnummer = im_filnr1.
    ls_goodsmove-bewegungsart = '105'.
    ls_goodsmove-soll_haben = '+'.
    ls_goodsmove-menge = im_menge1.
    ls_goodsmove-mengeneinheit =  get_unit_for_article( im_artnr ).
    ls_goodsmove-verbuchende = sy-uname.
    ls_goodsmove-verbuchungsdatum = sy-datum.
    ls_goodsmove-verbuchungszeit = sy-uzeit.
    ls_goodsmove-beleg_zeit = utc.
    APPEND ls_goodsmove TO lt_goodsmove.

    CLEAR ls_goodsmove.
    ls_goodsmove-mandant = sy-mandt.
    ls_goodsmove-artikelnummer = im_artnr.
    ls_goodsmove-filialnummer = im_filnr2.
    ls_goodsmove-bewegungsart = '106'.
    ls_goodsmove-soll_haben = '-'.
    ls_goodsmove-menge = im_menge2.
    ls_goodsmove-mengeneinheit =  get_unit_for_article( im_artnr ).
    ls_goodsmove-verbuchende = sy-uname.
    ls_goodsmove-verbuchungsdatum = sy-datum.
    ls_goodsmove-verbuchungszeit = sy-uzeit.
    ls_goodsmove-beleg_zeit = utclong_add(
    val = utc
    seconds = 1 ).

    APPEND ls_goodsmove TO lt_goodsmove.

    IF  im_filnr3 <> 0 AND im_menge3 <> 0.
      CLEAR ls_goodsmove.
      ls_goodsmove-mandant = sy-mandt.
      ls_goodsmove-artikelnummer = im_artnr.
      ls_goodsmove-filialnummer = im_filnr3.
      ls_goodsmove-bewegungsart = '106'.
      ls_goodsmove-soll_haben = '-'.
      ls_goodsmove-menge = im_menge3.
      ls_goodsmove-mengeneinheit =  get_unit_for_article( im_artnr ).
      ls_goodsmove-verbuchende = sy-uname.
      ls_goodsmove-verbuchungsdatum = sy-datum.
      ls_goodsmove-verbuchungszeit = sy-uzeit.
      ls_goodsmove-beleg_zeit = utclong_add(
          val = utc
          seconds = 2 ).
      APPEND ls_goodsmove TO lt_goodsmove.
    ENDIF.

    INSERT zgrp3_bewegungen FROM TABLE lt_goodsmove.

    IF sy-subrc = 0.
      COMMIT WORK.
      RAISE EVENT reloc_succ
        EXPORTING
          artnr = im_artnr
          filnr1 = im_filnr1
          lager_b1 = lv_filnr1_bestand-aktueller_lagerbestand + im_menge1
          filnr2 = im_filnr2
          lager_b2 = lv_filnr2_bestand-aktueller_lagerbestand - im_menge2
          filnr3 = im_filnr3
          lager_b3 = lv_filnr3_bestand-aktueller_lagerbestand - im_menge3.
      IF sy-subrc = 0.
        MESSAGE s024."|Der Artikel{ im_artnr } wurde erfolgreich auf Filiale { im_filnr2 } und Filiale { im_filnr3 } umgelagert!| TYPE 'S'.
      ELSE.
        MESSAGE e021.
      ENDIF.
    ELSE.
      MESSAGE e020.
    ENDIF.
  ENDMETHOD.


  METHOD umlagern_abgang. "the source branch distributes the goods to at least one other branch
    DATA lv_filnr1_bestand TYPE zgrp3_bestand.
    DATA lv_filnr2_bestand TYPE zgrp3_bestand.
    DATA lv_filnr3_bestand TYPE zgrp3_bestand.
    DATA: ls_goodsmove TYPE zgrp3_bewegungen,
          lt_goodsmove TYPE TABLE OF zgrp3_bewegungen.
    DATA(utc) = utclong_current( ).

    IF im_filnr1 = im_filnr2 OR im_filnr1 = im_filnr3.
      MESSAGE e023.
    ENDIF.

    IF im_menge2 + im_menge3 <> im_menge1.
      RAISE EXCEPTION TYPE cx_falsche_menge.
    ENDIF.

    IF im_filnr3 = 0 AND im_menge3 <> 0.
      RAISE EXCEPTION TYPE cx_falsche_menge.
    ENDIF.

    SELECT SINGLE *
      FROM zgrp3_bestand INTO @lv_filnr2_bestand
       WHERE artikelnummer = @im_artnr
        AND filialnummer = @im_filnr2.

    IF ( lv_filnr2_bestand-aktueller_lagerbestand + im_menge2 ) > lv_filnr2_bestand-max_bestand.
      RAISE EXCEPTION TYPE cx_max_best.
    ENDIF.

    IF NOT im_filnr3 = ''.
      SELECT SINGLE *
        FROM zgrp3_bestand INTO @lv_filnr3_bestand
         WHERE artikelnummer = @im_artnr
          AND filialnummer = @im_filnr3.

      IF ( lv_filnr3_bestand-aktueller_lagerbestand + im_menge3 ) > lv_filnr3_bestand-max_bestand.
        RAISE EXCEPTION TYPE cx_max_best.
      ENDIF.
    ENDIF.

    SELECT SINGLE *
       FROM zgrp3_bestand INTO @lv_filnr1_bestand
        WHERE artikelnummer = @im_artnr
         AND filialnummer = @im_filnr1.

    IF ( lv_filnr1_bestand-aktueller_lagerbestand - im_menge1 ) < lv_filnr1_bestand-min_bestand.
      RAISE EXCEPTION TYPE cx_min_best.
    ENDIF.

    ls_goodsmove-mandant = sy-mandt.
    ls_goodsmove-artikelnummer = im_artnr.
    ls_goodsmove-filialnummer = im_filnr1.
    ls_goodsmove-bewegungsart = '106'.
    ls_goodsmove-soll_haben = '-'.
    ls_goodsmove-menge = im_menge1.
    ls_goodsmove-mengeneinheit =  get_unit_for_article( im_artnr ).
    ls_goodsmove-verbuchende = sy-uname.
    ls_goodsmove-verbuchungsdatum = sy-datum.
    ls_goodsmove-verbuchungszeit = sy-uzeit.
    ls_goodsmove-beleg_zeit = utc.
    APPEND ls_goodsmove TO lt_goodsmove.

    CLEAR ls_goodsmove.
    ls_goodsmove-mandant = sy-mandt.
    ls_goodsmove-artikelnummer = im_artnr.
    ls_goodsmove-filialnummer = im_filnr2.
    ls_goodsmove-bewegungsart = '105'.
    ls_goodsmove-soll_haben = '+'.
    ls_goodsmove-menge = im_menge2.
    ls_goodsmove-mengeneinheit =  get_unit_for_article( im_artnr ).
    ls_goodsmove-verbuchende = sy-uname.
    ls_goodsmove-verbuchungsdatum = sy-datum.
    ls_goodsmove-verbuchungszeit = sy-uzeit.
    ls_goodsmove-beleg_zeit = utclong_add(
        val = utc
        seconds = 1 ).
    APPEND ls_goodsmove TO lt_goodsmove.

    IF  im_filnr3 <> 0 AND im_menge3 <> 0.
      CLEAR ls_goodsmove.
      ls_goodsmove-mandant = sy-mandt.
      ls_goodsmove-artikelnummer = im_artnr.
      ls_goodsmove-filialnummer = im_filnr3.
      ls_goodsmove-bewegungsart = '105'.
      ls_goodsmove-soll_haben = '+'.
      ls_goodsmove-menge = im_menge3.
      ls_goodsmove-mengeneinheit =  get_unit_for_article( im_artnr ).
      ls_goodsmove-verbuchende = sy-uname.
      ls_goodsmove-verbuchungsdatum = sy-datum.
      ls_goodsmove-verbuchungszeit = sy-uzeit.
      ls_goodsmove-beleg_zeit = utclong_add(
        val = utc
        seconds = 2 ).
      APPEND ls_goodsmove TO lt_goodsmove.
    ENDIF.

    INSERT zgrp3_bewegungen FROM TABLE lt_goodsmove.

    IF sy-subrc = 0.
      RAISE EVENT reloc_succ
        EXPORTING
          artnr = im_artnr
          filnr1 = im_filnr1
          lager_b1 = lv_filnr1_bestand-aktueller_lagerbestand - im_menge1
          filnr2 = im_filnr2
          lager_b2 = lv_filnr2_bestand-aktueller_lagerbestand + im_menge2
          filnr3 = im_filnr3
          lager_b3 = lv_filnr3_bestand-aktueller_lagerbestand + im_menge3.
      IF sy-subrc = 0.
        MESSAGE s024."|Der Artikel{ im_artnr } wurde erfolgreich auf Filiale { im_filnr2 } und Filiale { im_filnr3 } umgelagert!| TYPE 'S'.
      ELSE.
        MESSAGE e021.
      ENDIF.
    ELSE.
      MESSAGE e020.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_reloc_succ_handler IMPLEMENTATION.

  METHOD on_reloc_succ.

    UPDATE zgrp3_bestand
               SET aktueller_lagerbestand = @lager_b1
               WHERE artikelnummer = @artnr
               AND filialnummer = @filnr1.
    IF sy-subrc = 0.
      MESSAGE |Der Artikel { artnr } wurde erfolgreich in die Filiale { filnr1 } umgelagert!| TYPE 'I'.
    ELSE.
      MESSAGE e021.
      EXIT.
    ENDIF.

    UPDATE zgrp3_bestand
               SET aktueller_lagerbestand = @lager_b2
               WHERE artikelnummer = @artnr
               AND filialnummer = @filnr2.
    IF sy-subrc = 0.
      MESSAGE |Der Artikel { artnr } wurde erfolgreich in die Filiale { filnr2 } umgelagert!| TYPE 'I'.
    ELSE.
      MESSAGE e021.
      EXIT.
    ENDIF.

    IF  filnr3 <> 0 .
      UPDATE zgrp3_bestand
             SET aktueller_lagerbestand = @lager_b3
             WHERE artikelnummer = @artnr
             AND filialnummer = @filnr3.
      IF sy-subrc = 0.
        MESSAGE |Der Artikel { artnr } wurde erfolgreich in die Filiale { filnr3 } umgelagert!| TYPE 'I'.
      ELSE.
        MESSAGE e021.
        EXIT.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

CLASS cx_falsche_menge IMPLEMENTATION.
ENDCLASS.

CLASS cx_max_best IMPLEMENTATION.
ENDCLASS.

CLASS cx_min_best IMPLEMENTATION.
ENDCLASS.
