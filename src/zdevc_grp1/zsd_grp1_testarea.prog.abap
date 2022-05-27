*&---------------------------------------------------------------------*
*& Report ZSD_GRP1_TESTAREA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSD_GRP1_TESTAREA.





select bes~filnr, bes~artnr, bes~akbes
  from zsd_grp1_bes as bes
  inner join  zsd_grp1_uml as uml
  on bes~artnr = uml~artnr AND bes~filnr = uml~filialnr into @data(umlagerung).
    ENDSELECT.
BREAK-POINT.

*
*  METHOD uml_tab_bef.
*    DATA ls_umlagerung TYPE lt.
*    ls_umlagerung-filialnr = i_fil_a.
*    ls_umlagerung-artnr = i_artnr1.
*    ls_umlagerung-menge  = i_mengea.
*    ls_umlagerung-bwart = i_bwart.
*
*
*******    Bewegung A
*    IF i_bwart = '105'.
*      ls_umlagerung-sollhaben = '+'.
*    ELSE.
*      ls_umlagerung-sollhaben = '-'.
*    ENDIF.
*    ls_umlagerung-verbuchender = sy-uname.
*    ls_umlagerung-verbuchungsdatum = sy-datum.
*    ls_umlagerung-verbuchungszeit = sy-uzeit.
*    APPEND ls_umlagerung TO lt_uml.
**    INSERT zsd_grp1_uml FROM ls_umlagerung.
*    COMMIT WORK.
*    CASE i_mengea.
*      WHEN NE i_meng1 + 1_meng1.
*        message 'Die Verteilung der Artikelmengen stimmt nicht überein! Bitte prüfen Sie Ihre Einagbe!' type 'I'.
*      WHEN i_menga = i_meng1 + 1_meng1.
*        continue.
*    ENDCASE.
*
*    CASE ls_umlagerung-bwart.
*      WHEN '+'.
*        if zsd_grp1_uml-maxbestand < zsd_grp1_uml-maxbestand + ls_umlagerung-menge.
*          message ' Der Maximalbestand in der aufnehmenden Filiale würde bei dieser Menge überschritten werden! Bitte ändern Sie Ihre Einagbe!' type 'i'.
*          else.
*            raise event bla bla
*      WHEN '-'.
*            if zsd_grp1_uml-minbestand < zsd_grp1_uml-aktbestand - ls_umlagerung-menge.
*          message ' Der Minimalbestand in der angebenden Filiale würde bei dieser Menge unterschritten werden! Bitte ändern Sie Ihre Einagbe!' type 'i'.
*          else.
*            raise event bla bla
*      WHEN OTHERS.
*            message 'Ein Fehler ist aufgetreten!' Type 'I'.
*    ENDCASE.
