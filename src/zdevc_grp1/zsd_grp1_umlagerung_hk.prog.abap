*&---------------------------------------------------------------------*
*& Report ZSD_GRP1_UMLAGERUNG_HK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSD_GRP1_UMLAGERUNG_HK.
*
Tables: zsd_grp1_uml.
Types : lt type zsd_grp1_uml.

CLASS lcl_umlagerung DEFINITION.
  PUBLIC SECTION.

  METHODS : fil_umlagerung
    IMPORTING im_flnr   TYPE lt-filialnr
              im_artnr TYPE lt-artnr
              im_menge  TYPE lt-menge
              im_bwart  TYPE lt-bwart
              im_flnr1  TYPE lt-filialnr
              im_menge1   TYPE lt-menge
              im_flnr2  TYPE lt-filialnr
              im_menge2   TYPE lt-menge.

ENDCLASS.

CLASS lcl_umlagerung IMPLEMENTATION.

  METHOD fil_umlagerung.

    DATA ls_umlagerung TYPE zsd_grp1_uml.

         ls_umlagerung-filialnr = im_flnr.
         ls_umlagerung-artnr = im_artnr.
         ls_umlagerung-menge = im_menge.
         ls_umlagerung-mengeneinheit = 'ST'.
         ls_umlagerung-bwart = im_bwart.

    IF im_bwart = '105'.
      ls_umlagerung-sollhaben = '+'.
    ELSE.
      ls_umlagerung-sollhaben = '-'.
    ENDIF.

    ls_umlagerung-verbuchender = sy-uname.
    ls_umlagerung-verbuchungsdatum = sy-datum.
    ls_umlagerung-verbuchungszeit = sy-uzeit.

    INSERT zsd_grp1_uml FROM ls_umlagerung.
    COMMIT WORK.

    "Werte ausfüllen für 2 Warenbewegung

    ls_umlagerung-filialnr = im_flnr1.

    IF im_bwart = '105'. "Bewegungsart = zugang
      ls_umlagerung-bwart = '106'.
      ls_umlagerung-sollhaben = '-'.
    ELSE.
      ls_umlagerung-bwart = '105'.
      ls_umlagerung-sollhaben = '+'.
    ENDIF.
    ls_umlagerung-menge = im_menge1.
    INSERT zsd_grp1_uml FROM ls_umlagerung.
    COMMIT WORK.

*  Werte ausfüllen für 3 Warenbewegung

    IF im_flnr2 IS NOT INITIAL.
      ls_umlagerung-filialnr = im_flnr2.

      IF im_bwart = '105'. "Bewegungsart = zugang(inflow)
        ls_umlagerung-bwart = '106'.
        ls_umlagerung-sollhaben = '-'.
      ELSE.
        ls_umlagerung-bwart = '105'.
        ls_umlagerung-sollhaben = '+'.
      ENDIF.
      ls_umlagerung-menge = im_menge2.
    ENDIF.

    INSERT zsd_grp1_uml FROM ls_umlagerung.
    COMMIT WORK.
  ENDMETHOD.
ENDCLASS.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
*  TABLES : zsd_grp2_umlag.
  PARAMETERS:
    p_flnr  TYPE zsd_grp1_uml-filialnr OBLIGATORY VALUE CHECK,
    p_artnr  TYPE zsd_grp1_uml-artnr OBLIGATORY VALUE CHECK,
    p_menge TYPE zsd_grp1_uml-menge OBLIGATORY,
    p_bwart TYPE zsd_grp1_uml-bwart,
    p_flnr1 TYPE zsd_grp1_uml-filialnr OBLIGATORY VALUE CHECK,
    p_menge1  TYPE zsd_grp1_uml-menge OBLIGATORY,
    p_flnr2 TYPE zsd_grp1_uml-filialnr VALUE CHECK,
    p_menge2  TYPE zsd_grp1_uml-menge.

SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  DATA lo_umlagerung TYPE REF TO lcl_umlagerung.
  CREATE OBJECT lo_umlagerung.

  lo_umlagerung->fil_umlagerung(
    EXPORTING
      im_flnr =  p_flnr
      im_artnr =  p_artnr
      im_menge =   p_menge
      im_bwart =   p_bwart
      im_flnr1 =   p_flnr1
      im_menge1  =   p_menge1
      im_flnr2 =   p_flnr2
      im_menge2  =   p_menge2
  ).
