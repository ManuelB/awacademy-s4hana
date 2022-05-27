*&---------------------------------------------------------------------*
*& Modulpool        ZSD_DEALINGSWEETS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*


*Schematische Darstellung für Programmaufbau.
*
*Hauptprogramm (Modulpool)
*      Include *TOP - Datendeklaration / Definition der lokalen Klassen/Methoden
*      Include *F01 - Implementierung der Funktionalität für die definierten Methoden
*Instantiierung der Klassen/Methoden für eigentliche Funktionalität



INCLUDE zsd_grp2_dealingsweetstop.               " Global Data
INCLUDE zsd_grp2_dealingsweetsf01.               " FORM-Routines


DATA : ucomm LIKE sy-ucomm.

*Selection-screen für Mini1
SELECTION-SCREEN BEGIN OF SCREEN 100.

  SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-100.
    PARAMETERS:
      1p_flnr  TYPE zsd_grp2_umlag-filial_nr,
      1arl_nr  TYPE zsd_grp2_umlag-artikel_nr,
      1p_menge TYPE zsd_grp2_umlag-menge,
      1p_bwgng TYPE zsd_grp2_umlag-bewegungsart.
  SELECTION-SCREEN END OF BLOCK a1.

  SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-200.
    PARAMETERS :
      1p_flnr1 TYPE zsd_grp2_umlag-filial_nr,
      1p_men1  TYPE zsd_grp2_umlag-menge.
  SELECTION-SCREEN END OF BLOCK a2.

  SELECTION-SCREEN BEGIN OF BLOCK a3 WITH FRAME TITLE TEXT-300.
    PARAMETERS:
      1p_flnr2 TYPE zsd_grp2_umlag-filial_nr,
      1p_men2  TYPE zsd_grp2_umlag-menge.
  SELECTION-SCREEN END OF BLOCK a3.
SELECTION-SCREEN END OF SCREEN 100.

*Selection-screen für TRX Artikelpreis ändern, Warenbestandliste und Aktiveflag.
SELECTION-SCREEN BEGIN OF SCREEN 9000.
  SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME.

    PARAMETERS:
      p_artnr  TYPE z_artnr_grp2 DEFAULT 001,
      p_neupr  TYPE z_vp_brutto_grp2,
      P_artgrp TYPE z_artgrp_grp2.

  SELECTION-SCREEN END OF BLOCK b0.
SELECTION-SCREEN END OF SCREEN 9000.

SELECTION-SCREEN BEGIN OF SCREEN 200.

  PARAMETERS:
    p_flnr   TYPE zsd_grp2_umlag-filial_nr OBLIGATORY,
    artkl_nr TYPE zsd_grp2_umlag-artikel_nr OBLIGATORY,
    p_menge  TYPE zsd_grp2_umlag-menge,
    p_bwgng  TYPE zsd_grp2_umlag-bewegungsart,
    p_flnr1  TYPE zsd_grp2_umlag-filial_nr,
    p_menge1 TYPE zsd_grp2_umlag-menge,
    p_flnr2  TYPE zsd_grp2_umlag-filial_nr,
    p_menge2 TYPE zsd_grp2_umlag-menge.



SELECTION-SCREEN END OF SCREEN 200.

*Selection-screen für Neuartikel
SELECTION-SCREEN BEGIN OF SCREEN 1200.
  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

    PARAMETERS:
*p_artn2 TYPE z_artnr_grp2,
      p_artna  TYPE zsd_grp2_arst-artikelname OBLIGATORY,
      P_artgr2 TYPE zsd_grp2_arst-artikelgruppe OBLIGATORY VALUE CHECK,
      p_ekne   TYPE zsd_grp2_arst-ek_netto OBLIGATORY,
      p_mvp    TYPE zsd_grp2_arst-mvp_brutto OBLIGATORY,
      p_vpbr   TYPE zsd_grp2_arst-vp_brutto OBLIGATORY,
      p_act    TYPE zsd_grp2_arst-activeflag OBLIGATORY VALUE CHECK,
      p_war    TYPE zsd_grp2_arst-waehrung OBLIGATORY VALUE CHECK,
      p_fili   TYPE  zsd_grp2_filbest-filialnummer OBLIGATORY VALUE CHECK,
      p_mind   TYPE  zsd_grp2_bes-mindestbestand OBLIGATORY,
      p_max    TYPE   zsd_grp2_bes-maximalbestand OBLIGATORY,
      p_lag    TYPE   zsd_grp2_bes-akt_lagerbestand OBLIGATORY,
      p_meng   TYPE  zsd_grp2_bes-menge_einheit OBLIGATORY VALUE CHECK.


  SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN END OF SCREEN 1200.



*Selection-screen für Neufiliale
SELECTION-SCREEN BEGIN OF SCREEN 1300.
  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
    PARAMETERS:
*p_artn2 TYPE z_artnr_grp2,
*p_filnum type Z_ART_NM_GRP2 OBLIGATORY,
      P_filbez TYPE   z_filbez_grp2   OBLIGATORY VALUE CHECK,
      p_ort    TYPE   ad_city1   OBLIGATORY,
      p_str    TYPE   ad_street   OBLIGATORY,
      p_plz    TYPE    ad_pstcd1  OBLIGATORY,
      p_tel    TYPE    ad_tlnmbr1.

  SELECTION-SCREEN END OF BLOCK b2.
SELECTION-SCREEN END OF SCREEN 1300.

*Selection-screen für Filiale pflegen
SELECTION-SCREEN:  BEGIN OF SCREEN 1400.
  SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.
    PARAMETERS:

      p_filnu2 TYPE  zsd_grp2_filbest-filialnummer OBLIGATORY VALUE CHECK,
      p_filbe2 TYPE  zsd_grp2_filbest-filialbezeichnung,
      p_ort2   TYPE   ad_city1,
      p_str2   TYPE   ad_street,
      p_plz2   TYPE    ad_pstcd1,
      p_tel2   TYPE    ad_tlnmbr1.


    SELECTION-SCREEN PUSHBUTTON  /40(15) but1 USER-COMMAND but1.
    SELECTION-SCREEN PUSHBUTTON  /40(15) but2 USER-COMMAND but2.
    SELECTION-SCREEN PUSHBUTTON  /40(15) but3 USER-COMMAND but3.

  SELECTION-SCREEN END OF BLOCK b3.
SELECTION-SCREEN END OF SCREEN 1400.


*********************************************************************************
INITIALIZATION.


*  but1 = 'Show'.
*  but2 = 'Update'.
*  but3 = 'Reset'.


AT SELECTION-SCREEN OUTPUT.


  LOOP AT SCREEN.

    CASE sy-tcode.


      WHEN 'ZSD_G2_VKCHANGE'.
*        IF screen-name = 'P_ARTGRP' OR Screen-name = '%_P_ARTGRP_%_APP_%-TEXT'.
        IF screen-name = 'P_ARTNR' OR Screen-name = '%_P_ARTNR_%_APP_%-TEXT'
          OR screen-name = 'P_NEUPR' OR screen-name = '%_P_NEUPR_%_APP_%-TEXT'.
          screen-active = 1.
          screen-invisible = 0.
        ELSE.
          screen-active = 0.
          screen-invisible = 1.
        ENDIF.
        MODIFY SCREEN.
*
      WHEN 'ZSD_G2_WARENBESTAND'.
        IF screen-name = 'P_ARTNR' OR Screen-name = '%_P_ARTNR_%_APP_%-TEXT'
        OR screen-name = 'P_NEUPR' OR screen-name = '%_P_NEUPR_%_APP_%-TEXT' .
          screen-active = 0.
          screen-invisible = 1.
        ENDIF.
        MODIFY SCREEN.
*
      WHEN 'ZSD_G2_AUSLISTEN'.
        IF screen-name = 'P_ARTNR' OR Screen-name = '%_P_ARTNR_%_APP_%-TEXT'.
          screen-active = 1.
          screen-invisible = 0.
        ELSE.
          screen-active = 0.
          screen-invisible = 1.
        ENDIF.
        MODIFY SCREEN.

      WHEN 'ZSD_G2_PFL_FILIALST'.

*Namen von Pushbottons
        but1 = 'Anzeigen'.
        but2 = 'Aktualisieren'.
        but3 = 'Zurücksetzen'.
*Bei Selection-Screen (vor drück bevor Sie einen Knopf drücken
        IF screen-name = 'P_FILBE2'
          OR screen-name = 'P_ORT2'
          OR screen-name = 'P_STR2'
          OR screen-name = 'P_PLZ2'
          OR screen-name = 'P_TEL2'.
          screen-input = 0.
        ENDIF.
        MODIFY SCREEN.

*Case-on click of button
        CASE ucomm.
          WHEN 'BUT1'. "Anzeigen
            IF screen-name = 'P_FILNU2'.
              screen-input = 0.
            ENDIF.
            MODIFY SCREEN.

            IF screen-name = 'P_FILBE2'
               OR screen-name = 'P_ORT2'
               OR screen-name = 'P_STR2'
               OR screen-name = 'P_PLZ2'
               OR screen-name = 'P_TEL2'.
              screen-input = 1.
            ENDIF.
            MODIFY SCREEN.

          WHEN 'BUT2'. "Aktualisieren
            IF screen-name = 'P_FILNU2'.
              screen-input = 0.
            ENDIF.
            MODIFY SCREEN.
        ENDCASE.


    ENDCASE.

  ENDLOOP.


************************************************************************



AT SELECTION-SCREEN ON 1p_flnr.
  CASE sy-tcode.
    WHEN 'ZSD_G2_UMLAGERUNG'.
      SELECT SINGLE * FROM zsd_grp2_filbest INTO @DATA(x) WHERE filialnummer = @1p_flnr.
      IF sy-subrc <> 0.
        MESSAGE i025 WITH 1p_flnr.
               rollback work.
      ENDIF.

  ENDCASE.


AT SELECTION-SCREEN ON 1arl_nr.
  CASE sy-tcode.
    WHEN 'ZSD_G2_UMLAGERUNG'.
      SELECT SINGLE * FROM zsd_grp2_arst INTO @DATA(x) WHERE artikelnummer = @1arl_nr.
      IF sy-subrc <> 0.
        MESSAGE i026 WITH 1arl_nr.
*        set screen 100.
      ENDIF.
  ENDCASE.

AT SELECTION-SCREEN ON 1p_flnr1.
  CASE sy-tcode.
    WHEN 'ZSD_G2_UMLAGERUNG'.
      SELECT SINGLE * FROM zsd_grp2_filbest INTO @DATA(x) WHERE filialnummer = @1p_flnr1.
      IF sy-subrc <> 0.
        MESSAGE i028 WITH 1p_flnr1.
      ENDIF.
  ENDCASE.

AT SELECTION-SCREEN ON 1p_flnr2.
  CASE sy-tcode.
    WHEN 'ZSD_G2_UMLAGERUNG'.
      SELECT SINGLE * FROM zsd_grp2_filbest INTO @DATA(x) WHERE filialnummer = @1p_flnr2.
      IF sy-subrc <> 0.
        MESSAGE i029 WITH 1p_flnr2.
      ENDIF.
  ENDCASE.




AT SELECTION-SCREEN.
*  SELECT SINGLE filialnummer FROM zsd_grp2_filbest INTO @DATA(y) WHERE filialnummer = @p_fili OR filialnummer = @p_filnu2.
*  IF sy-subrc = 0.
*  ELSE.
*    MESSAGE |Not there| TYPE 'E'.
*    SET SCREEN 1200.
*  ENDIF.
  ucomm = sy-ucomm.

*  DATA lo_miniprojekt TYPE REF TO lcl_miniprojekt.

  DATA(lo_miniprojekt) = NEW lcl_miniprojekt( ).
  DATA(lo_filiale) = NEW lcl_filiale( ).

  CASE sy-tcode.

    WHEN 'ZSD_G2_WARENBESTAND'.

      lo_miniprojekt->waren_bst_liste(
      EXPORTING
        im_artgruppe =  p_artgrp
          ).


    WHEN 'ZSD_G2_VKCHANGE'.
      lo_miniprojekt->vkchange(
      EXPORTING
      im_anr_v = p_artnr
      im_vkcha = p_neupr
      ).


    WHEN 'ZSD_G2_AUSLISTEN'.
      lo_miniprojekt->auslisten( im_artnr = p_artnr ).

    WHEN 'ZSD_G2_NEUARTIKEL'.

      lo_miniprojekt->neuartikel(
        EXPORTING
          im_artnam    = p_artna
          im_artgr     = P_artgr2
          im_ekneto    = p_ekne
          im_mvp_bruto = p_mvp
          im_vpbruto   = p_vpbr
          im_active    = p_act
          im_wae       = p_war
          im_datum     = sy-datum
          im_user      = sy-uname
          im_fili      = p_fili
          im_mind      = p_mind
          im_max       = p_max
          im_lag       = p_lag
          im_meng      = p_meng
*        IMPORTING
*          ex_artnum2    = P_
      ).



    WHEN 'ZSD_G2_NEU_FILIALST'.
      lo_filiale->neuanlage(
        EXPORTING
          im_filbez =  P_filbez
          im_ort    =  p_ort
          im_str    =  p_str
          im_plz    =  p_plz
          im_tel    =  p_tel
          im_user   =  sy-uname
          im_datum  =  sy-datum

      ).


    WHEN 'ZSD_G2_PFL_FILIALST'.

      CASE ucomm.
        WHEN 'BUT1'.


          SELECT SINGLE FOR UPDATE filialbezeichnung FROM zsd_grp2_filbest INTO p_filbe2 WHERE filialnummer = p_filnu2.
          SELECT SINGLE  FOR UPDATE ort FROM zsd_grp2_filbest INTO p_ort2 WHERE filialnummer = p_filnu2.
          SELECT SINGLE  FOR UPDATE strasse FROM zsd_grp2_filbest INTO p_str2 WHERE filialnummer = p_filnu2.
          SELECT SINGLE  FOR UPDATE plz FROM zsd_grp2_filbest INTO p_plz2 WHERE filialnummer = p_filnu2.
          SELECT SINGLE   FOR UPDATE telefon FROM zsd_grp2_filbest INTO p_tel2 WHERE filialnummer = p_filnu2.




          IF p_filnu2 IS INITIAL OR p_filbe2 IS INITIAL OR p_ort2 IS INITIAL.
            MESSAGE |Diese Filialnummer existiert nicht. Bitte verwenden Sie die Transaktion, um eine neue Filiale zu anlegen.!| TYPE 'E'.
          ENDIF.


        WHEN 'BUT2'.

          IF p_filnu2 IS NOT INITIAL AND p_filbe2 IS NOT INITIAL AND p_ort2 IS NOT INITIAL AND p_str2 IS NOT INITIAL AND p_plz2 IS NOT INITIAL.

            lo_filiale->pflege(
              EXPORTING
                im_filnum = p_filnu2
                im_filbez =  P_filbe2
                im_ort    =  p_ort2
                im_str    =  p_str2
                im_plz    =  p_plz2
                im_tel    =  p_tel2
                im_user   =  sy-uname
                im_datum  =  sy-datlo
 ).
          ELSE.
            MESSAGE |Einige Felder sind nicht ausgefüllt. Bitte prüfen Sie ihren Eintrag.!| TYPE 'E'.
          ENDIF.

        WHEN 'BUT3'.
          CLEAR: p_filnu2,
                 p_filbe2,
                 p_ort2   ,
                 p_str2   ,
                 p_plz2  ,
                 p_tel2   .
      ENDCASE.

    WHEN 'ZSD_G2_UMLAGERUNG'.

      DATA lo_umlagerung TYPE REF TO lcl_umlagerung.
      CREATE OBJECT lo_umlagerung.
      DATA re_menge TYPE zsd_grp2_umlag-menge.
      SET HANDLER lo_umlagerung->update_bestand_tbl FOR lo_umlagerung.


      lo_umlagerung->pruefen_menge(
        EXPORTING
*    im_menge = p_menge
          im_men1  = 1p_men1
          im_men2  = 1p_men2
          RECEIVING re_men = re_menge
      ).
      IF re_menge EQ 1p_menge.
        lo_umlagerung->fill_umlagerung_tbl(
      EXPORTING
         im_flnr1 =  1p_flnr
        im_arl_nr =  1arl_nr
        im_menge1 =   1p_menge
        im_bwgng =   1p_bwgng
        im_flnr2 =   1p_flnr1
        im_menge2  =   1p_men1
        im_flnr3 =   1p_flnr2
        im_menge3  =   1p_men2
    ).
      ELSE.
*    WRITE 'Die Abgegebene Menge ist nicht gleich wie aufnehmende menge'.
        MESSAGE e018.
        EXIT.
      ENDIF.
      MESSAGE i021.


  ENDCASE.
