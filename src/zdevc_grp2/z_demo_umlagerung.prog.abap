*&---------------------------------------------------------------------*
*& Report Z_DEMO_UMLAGERUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_demo_umlagerung.

TABLES: zsd_grp2_umlag, zsd_grp2_bes.
TYPES : tl TYPE zsd_grp2_umlag,
        bs TYPE zsd_grp2_bes.

CLASS lcl_umlagerung DEFINITION.
  PUBLIC SECTION.

    EVENTS : reloc_succ
      EXPORTING VALUE(art_nr) TYPE tl-artikel_nr
                VALUE(flnr1)  TYPE tl-filial_nr
                VALUE(bes1)   TYPE tl-menge
                VALUE(flnr2)  TYPE tl-filial_nr
                VALUE(bes2)   TYPE tl-menge
                VALUE(flnr3)  TYPE tl-filial_nr
                VALUE(bes3)   TYPE tl-menge.




    METHODS : fill_umlagerung_tbl
      IMPORTING im_flnr1  TYPE tl-filial_nr
                im_arl_nr TYPE tl-artikel_nr
                im_menge1 TYPE tl-menge
                im_bwgng  TYPE tl-bewegungsart
                im_flnr2  TYPE tl-filial_nr
                im_menge2 TYPE tl-menge
                im_flnr3  TYPE tl-filial_nr
                im_menge3 TYPE tl-menge,

      pruefen_menge
        IMPORTING
                  im_men1       TYPE tl-menge
                  im_men2       TYPE tl-menge
        RETURNING VALUE(re_men) TYPE tl-menge,

      update_bestand_tbl FOR EVENT reloc_succ OF  lcl_umlagerung
        IMPORTING art_nr
                  flnr1
                  bes1
                  flnr2
                  bes2
                  flnr3
                  bes3 .

ENDCLASS.

CLASS lcl_umlagerung IMPLEMENTATION.

  METHOD pruefen_menge.
    re_men = im_men1 + im_men2.
  ENDMETHOD .

  METHOD update_bestand_tbl.

    UPDATE zsd_grp2_bes SET akt_lagerbestand = @bes1
    WHERE artikelnummer = @art_nr AND filialnummer = @flnr1.

    IF sy-subrc = 0.
      WRITE: / 'LagerBestand für filiale:', flnr1, 'ist aktualisiert'.
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
          WRITE : 'Die Filiale:' , im_flnr1, 'kann diese Menge nicht annehmen, da sonst der Maximalbestand überschritten wird'.
          EXIT.
        ENDIF.
      ELSE.
        WRITE : 'Die filiale : ', im_flnr1, ' verfügt über kein Inventar für diesen Artikel'.
        EXIT.
      ENDIF.


      SELECT SINGLE mindestbestand, maximalbestand , akt_lagerbestand FROM zsd_grp2_bes
      WHERE artikelnummer = @im_arl_nr
      AND filialnummer = @im_flnr2
      INTO @DATA(ls2_bestand).
      IF sy-subrc = 0.
        IF ls2_bestand-mindestbestand > ls2_bestand-akt_lagerbestand - im_menge2.
          WRITE : 'Die Filiale:', im_flnr2,' kann diese Menge nicht abgeben, da sonst der Minimalbestand nicht eingehalten wird'.
          EXIT.
        ENDIF.
      ELSE.
        WRITE : 'Die filiale : ', im_flnr2, ' verfügt über kein Inventar für diesen Artikel'.
        EXIT.
      ENDIF.

      IF im_flnr3 IS NOT INITIAL.
        SELECT SINGLE mindestbestand, maximalbestand , akt_lagerbestand FROM zsd_grp2_bes
       WHERE artikelnummer = @im_arl_nr
       AND filialnummer = @im_flnr3
       INTO @DATA(ls3_bestand).
        IF sy-subrc = 0.
          IF ls3_bestand-mindestbestand > ls3_bestand-akt_lagerbestand - im_menge3.
            WRITE : 'Die Filiale:', im_flnr3,' kann diese Menge nicht abgeben, da sonst der Minimalbestand nicht eingehalten wird'.
            EXIT.
          ENDIF.
        ELSE.
          WRITE : 'Die filiale : ', im_flnr3, ' verfügt über kein Inventar für diesen Artikel'.
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
          WRITE : 'Die Filiale:', im_flnr1,' kann diese Menge nicht abgeben, da sonst der Minimalbestand nicht eingehalten wird'.
          EXIT.
        ENDIF.
      ELSE.
        WRITE : 'Die filiale : ', im_flnr1, ' verfügt über kein Inventar für diesen Artikel'.
        EXIT.
      ENDIF.

      SELECT SINGLE mindestbestand, maximalbestand , akt_lagerbestand FROM zsd_grp2_bes
      WHERE artikelnummer = @im_arl_nr
      AND filialnummer = @im_flnr2
      INTO @DATA(ls5_bestand).
      IF sy-subrc = 0.
        IF ls5_bestand-maximalbestand < im_menge2 + ls5_bestand-akt_lagerbestand.
          WRITE : 'Die Filiale:' , im_flnr2, 'kann diese Menge nicht annehmen, da sonst der Maximalbestand überschritten wird'.
          EXIT.
        ENDIF.
      ELSE.
        WRITE : 'Die filiale : ', im_flnr2, ' verfügt über kein Inventar für diesen Artikel'.
        EXIT.
      ENDIF.


      IF im_flnr3 IS NOT INITIAL.
        SELECT SINGLE mindestbestand, maximalbestand , akt_lagerbestand FROM zsd_grp2_bes
       WHERE artikelnummer = @im_arl_nr
       AND filialnummer = @im_flnr3
       INTO @DATA(ls6_bestand).
        IF sy-subrc = 0.
          IF ls6_bestand-maximalbestand < im_menge3 + ls6_bestand-akt_lagerbestand.
            WRITE : 'Die Filiale:', im_flnr3,' kann diese Menge nicht abgeben, da sonst der Minimalbestand nicht eingehalten wird'.
            EXIT.
          ENDIF.
        ELSE.
          WRITE : 'Die filiale : ', im_flnr3, ' verfügt über kein Inventar für diesen Artikel'.
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

*            RAISE EVENT reloc_succ
*        EXPORTING art_nr = im_arl_nr
*          flnr1 = im_flnr1
*          bes1 = im_menge1 + ls1_bestand-akt_lagerbestand
*          flnr2 =  im_flnr2
*          bes2 = ls2_bestand-akt_lagerbestand - im_menge2
*             flnr3 =  im_flnr3
*          bes3 = ls3_bestand-akt_lagerbestand - im_menge3.
        WRITE 'Tabelle können nicht aktualisiert werde'.
      ENDIF.


    ENDIF.

  ENDMETHOD.
ENDCLASS.
SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
*  TABLES : zsd_grp2_umlag.
  PARAMETERS:
    p_flnr  TYPE zsd_grp2_umlag-filial_nr OBLIGATORY VALUE CHECK,
    arl_nr  TYPE zsd_grp2_umlag-artikel_nr OBLIGATORY VALUE CHECK,
    p_menge TYPE zsd_grp2_umlag-menge OBLIGATORY,
    p_bwgng TYPE zsd_grp2_umlag-bewegungsart,
    p_flnr1 TYPE zsd_grp2_umlag-filial_nr OBLIGATORY VALUE CHECK,
    p_men1  TYPE zsd_grp2_umlag-menge OBLIGATORY,
    p_flnr2 TYPE zsd_grp2_umlag-filial_nr,
    p_men2  TYPE zsd_grp2_umlag-menge.

SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  DATA lo_umlagerung TYPE REF TO lcl_umlagerung.
  CREATE OBJECT lo_umlagerung.
  DATA re_menge TYPE zsd_grp2_umlag-menge.
  SET HANDLER lo_umlagerung->update_bestand_tbl FOR lo_umlagerung.


  lo_umlagerung->pruefen_menge(
    EXPORTING
*    im_menge = p_menge
      im_men1  = p_men1
      im_men2  = p_men2
      RECEIVING re_men = re_menge
  ).
  IF re_menge EQ p_menge.
    lo_umlagerung->fill_umlagerung_tbl(
  EXPORTING
     im_flnr1 =  p_flnr
    im_arl_nr =  arl_nr
    im_menge1 =   p_menge
    im_bwgng =   p_bwgng
    im_flnr2 =   p_flnr1
    im_menge2  =   p_men1
    im_flnr3 =   p_flnr2
    im_menge3  =   p_men2
).
  ELSE.
    WRITE 'Die Abgegebene Menge ist nicht gleich wie aufnehmende menge'.
  ENDIF.

  BREAK-POINT.
